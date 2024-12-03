WITH PlayerAges AS (
    SELECT 
        player_id,
        player_name
    FROM 
        SoccerProjects.dbo.AU_player_names
),
DistinctPlayerSalaries AS (
    SELECT 
        ps.player_id,
        CAST(ps.guaranteed_compensation AS DECIMAL(15, 2)) AS guaranteed_compensation, -- Ensure proper numeric formatting
        ROW_NUMBER() OVER (PARTITION BY ps.player_id ORDER BY ps.season_name DESC) AS row_num
    FROM 
        SoccerProjects.dbo.AU_player_salaries ps
    WHERE 
        ps.season_name = 2024
),
DistinctPlayerStats AS (
    SELECT 
        ps.player_id,
        ps.goals,
        ps.xgoals,
        ps.goals_minus_xgoals,
        ps.key_passes,
        ps.primary_assists,
        ps.xassists,
        ps.xgoals_plus_xassists,
        CAST(ps.points_added AS DECIMAL(10, 6)) AS points_added, -- Ensure numeric formatting
        ps.xpoints_added,
        ROW_NUMBER() OVER (PARTITION BY ps.player_id ORDER BY ps.season_name DESC) AS row_num
    FROM 
        SoccerProjects.dbo.AU_player_stats ps
    WHERE 
        ps.season_name = 2024
)
SELECT 
    pa.player_id,
    pa.player_name,
    s.guaranteed_compensation,
    ps.goals,
    ps.xgoals,
    ps.goals_minus_xgoals,
    ps.key_passes,
    ps.primary_assists,
    ps.xassists,
    ps.xgoals_plus_xassists,
    ps.points_added,
    ps.xpoints_added
FROM 
    PlayerAges pa
LEFT JOIN 
    DistinctPlayerSalaries s
    ON pa.player_id = s.player_id AND s.row_num = 1
LEFT JOIN 
    DistinctPlayerStats ps
    ON pa.player_id = ps.player_id AND ps.row_num = 1
ORDER BY 
    ps.points_added DESC;

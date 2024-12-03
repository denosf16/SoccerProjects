SELECT 
    tn.team_id,
    tn.team_name,
    SUM(CAST(ps.guaranteed_compensation AS FLOAT)) AS total_salaries
FROM 
    SoccerProjects.dbo.AU_team_names tn
INNER JOIN 
    SoccerProjects.dbo.AU_player_salaries ps
    ON tn.team_id = ps.team_id
INNER JOIN 
    SoccerProjects.dbo.AU_player_names pn
    ON ps.player_id = pn.player_id AND ps.team_id = tn.team_id
WHERE 
    ps.season_name = 2024
GROUP BY 
    tn.team_id, 
    tn.team_name
ORDER BY 
    total_salaries DESC;

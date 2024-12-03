SELECT 
    md.game_id,
    md.date_time_utc,
    md.home_score,
    md.away_score,
    htn.team_name AS home_team_name,
    atn.team_name AS away_team_name
FROM 
    SoccerProjects.dbo.AU_match_data md
LEFT JOIN 
    SoccerProjects.dbo.AU_team_names htn
    ON md.home_team_id = htn.team_id
LEFT JOIN 
    SoccerProjects.dbo.AU_team_names atn
    ON md.away_team_id = atn.team_id
WHERE 
    season_name = 2023
ORDER BY 
    md.date_time_utc;

TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER `after_delete_view_statistic` \n                    AFTER DELETE ON `viewsStatisticArticles` \n                    FOR EACH ROW BEGIN \n                        UPDATE `blogArticles`\n                        SET viewCount = (SELECT COUNT(viewsStatisticArticles.id) FROM `viewsStatisticArticles` WHERE viewsStatisticArticles.idArticle = blogArticles.id);\n                    END'
sql_modes=1342177280
definers='root@localhost'
client_cs_names='utf8'
connection_cl_names='utf8_general_ci'
db_cl_names='utf8_general_ci'

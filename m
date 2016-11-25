From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH] regulator: twl: drop of_match_ptr
Date: Fri, 25 Nov 2016 09:49:00 +0200
Message-ID: <20161125074900.7172-1-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

We can safely drop of_match_ptr since the driver
depends on CONFIG_OF symbol

Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
---
Depends on "regulator: twl6030: add dependency on OF".
After sending that one I realised that twl-regulator can also
have that change. You can squash these two if you like.

 drivers/regulator/twl-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 6c9ec84..48c060f 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -654,7 +654,7 @@ static struct platform_driver twlreg_driver = {
 	 */
 	.driver  = {
 		.name  = "twl4030_reg",
-		.of_match_table = of_match_ptr(twl_of_match),
+		.of_match_table = twl_of_match,
 	},
 };
 
-- 
2.9.3

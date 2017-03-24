From: Colin King <colin.king@canonical.com>
Subject: [PATCH] regulator: twl6030: remove redundant range check min_uV > 1300000 && min_uV <= 1350000
Date: Fri, 24 Mar 2017 17:13:50 +0000
Message-ID: <20170324171350.9953-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alban.auzeill@sonarsource.com, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

It has been pointed out to me that the range for vsel = 58 is actually
dead code as this is covered by an earlier check for (min_uV >= 700000)
&& (min_uV <= 1420000) so remove that check completely.

Reported-by: Alban Auzeill <alban.auzeill@sonarsource.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/twl6030-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 716191046a70..56aada387887 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -456,8 +456,6 @@ static int twl6030smps_map_voltage(struct regulator_dev *rdev, int min_uV,
 			vsel = 60;
 		else if ((min_uV > 1350000) && (min_uV <= 1500000))
 			vsel = 59;
-		else if ((min_uV > 1300000) && (min_uV <= 1350000))
-			vsel = 58;
 		else
 			return -EINVAL;
 		break;
-- 
2.11.0

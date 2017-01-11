From: Colin King <colin.king@canonical.com>
Subject: [PATCH] regulator: twl6030: fix range comparison, allowing vsel = 59
Date: Wed, 11 Jan 2017 15:36:20 +0000
Message-ID: <20170111153620.20342-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The range min_uV > 1350000 && min_uV <= 150000 is never reachable
because of a typo in the previous range check and hence vsel = 59
is never reached.  Fix the previous range check to enable the
vsel = 59 setting.

Fixes CoverityScan CID#728454 ("Logially dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/regulator/twl6030-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 4864b9d..7161910 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -452,7 +452,7 @@ static int twl6030smps_map_voltage(struct regulator_dev *rdev, int min_uV,
 			vsel = 62;
 		else if ((min_uV > 1800000) && (min_uV <= 1900000))
 			vsel = 61;
-		else if ((min_uV > 1350000) && (min_uV <= 1800000))
+		else if ((min_uV > 1500000) && (min_uV <= 1800000))
 			vsel = 60;
 		else if ((min_uV > 1350000) && (min_uV <= 1500000))
 			vsel = 59;
-- 
2.10.2

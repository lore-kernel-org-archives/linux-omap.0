From: J Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/4] regulator: Palmas: Add TPS659038 support
Date: Thu, 20 Jun 2013 16:32:15 +0530
Message-ID: <1371726135-9891-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, sameo@linux.intel.com
Cc: broonie@kernel.org, j-keerthy@ti.com, ldewangan@nvidia.com, grant.likely@secretlab.ca, swarren@nvidia.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, gg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

Add TPS659038 support.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Acked-by: Mark Brown <broonie@linaro.org>
---
 drivers/regulator/palmas-regulator.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 1ae1e83..d0c8785 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1054,6 +1054,7 @@ static struct of_device_id of_palmas_match_tbl[] = {
 	{ .compatible = "ti,tps65913-pmic", },
 	{ .compatible = "ti,tps65914-pmic", },
 	{ .compatible = "ti,tps80036-pmic", },
+	{ .compatible = "ti,tps659038-pmic", },
 	{ /* end */ }
 };
 
-- 
1.7.5.4


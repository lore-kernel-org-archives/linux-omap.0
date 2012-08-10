From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/6] regulator: twl: Remove get_voltage implementation for
 single voltage regulators
Date: Fri, 10 Aug 2012 09:37:09 +0800
Message-ID: <1344562629.2996.5.camel@phoenix>
References: <1344562353.2996.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344562353.2996.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, loml <linux-omap@vger.kernel.org>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: linux-omap@vger.kernel.org

This is not required after commit f7df20ec
"regulator: core: Use list_voltage() to read single voltage regulators"

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/regulator/twl-regulator.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index f2f49e2..2d9a2a8 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -624,18 +624,9 @@ static int twlfixed_list_voltage(struct regulator_dev *rdev, unsigned index)
 	return info->min_mV * 1000;
 }
 
-static int twlfixed_get_voltage(struct regulator_dev *rdev)
-{
-	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-
-	return info->min_mV * 1000;
-}
-
 static struct regulator_ops twl4030fixed_ops = {
 	.list_voltage	= twlfixed_list_voltage,
 
-	.get_voltage	= twlfixed_get_voltage,
-
 	.enable		= twl4030reg_enable,
 	.disable	= twl4030reg_disable,
 	.is_enabled	= twl4030reg_is_enabled,
@@ -648,8 +639,6 @@ static struct regulator_ops twl4030fixed_ops = {
 static struct regulator_ops twl6030fixed_ops = {
 	.list_voltage	= twlfixed_list_voltage,
 
-	.get_voltage	= twlfixed_get_voltage,
-
 	.enable		= twl6030reg_enable,
 	.disable	= twl6030reg_disable,
 	.is_enabled	= twl6030reg_is_enabled,
-- 
1.7.9.5

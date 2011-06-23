From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH] regulator: twl: Add 'fixed' set_voltage callback
Date: Fri, 24 Jun 2011 02:16:54 +0530
Message-ID: <1308862014-11212-1-git-send-email-jaswinder.singh@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49754 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933925Ab1FWUrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 16:47:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: ti@lists.linaro.org, linux-omap@vger.kernel.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com, sameo@linux.intel.com, Jassi Brar <jaswinder.singh@linaro.org>

Define dummy set_voltage callback for fixed lines,
without which voltage constraints fail to apply.

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 drivers/regulator/twl-regulator.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 87fe0f7..8223e49 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -591,10 +591,18 @@ static int twlfixed_get_voltage(struct regulator_dev *rdev)
 	return info->min_mV * 1000;
 }
 
+static int twlfixed_set_voltage(struct regulator_dev *rdev,
+	int min_uV, int max_uV, unsigned *selector)
+{
+	*selector = min_uV / 1000;
+	return 0;
+}
+
 static struct regulator_ops twl4030fixed_ops = {
 	.list_voltage	= twlfixed_list_voltage,
 
 	.get_voltage	= twlfixed_get_voltage,
+	.set_voltage	= twlfixed_set_voltage,
 
 	.enable		= twl4030reg_enable,
 	.disable	= twl4030reg_disable,
@@ -609,6 +617,7 @@ static struct regulator_ops twl6030fixed_ops = {
 	.list_voltage	= twlfixed_list_voltage,
 
 	.get_voltage	= twlfixed_get_voltage,
+	.set_voltage	= twlfixed_set_voltage,
 
 	.enable		= twl6030reg_enable,
 	.disable	= twl6030reg_disable,
-- 
1.7.4.1


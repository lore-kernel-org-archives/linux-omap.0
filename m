From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] mfd: twl4030-power: Add support for board specific configuration
Date: Wed, 23 Apr 2014 17:40:28 -0700
Message-ID: <1398300030-7386-3-git-send-email-tony@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19739 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaDXAkg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 20:40:36 -0400
In-Reply-To: <1398300030-7386-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

With the recommended twl4030 configuration added, we can now add
board specific changes as modifications to the recommended
configuration.

Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/twl4030-power.c | 21 +++++++++++++++++++++
 include/linux/i2c/twl.h     |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 89a8528..89c6b1a 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -511,13 +511,34 @@ twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
 	return 0;
 }
 
+static void twl4030_patch_rconfig(struct twl4030_resconfig *common,
+				  struct twl4030_resconfig *board)
+{
+	while (common->resource) {
+		struct twl4030_resconfig *b = board;
+
+		while (b->resource) {
+			if (b->resource == common->resource) {
+				*common = *b;
+				break;
+			}
+			b++;
+		}
+		common++;
+	}
+}
+
 static int
 twl4030_power_configure_resources(const struct twl4030_power_data *pdata)
 {
 	struct twl4030_resconfig *resconfig = pdata->resource_config;
+	struct twl4030_resconfig *boardconf = pdata->board_config;
 	int err;
 
 	if (resconfig) {
+		if (boardconf)
+			twl4030_patch_rconfig(resconfig, boardconf);
+
 		while (resconfig->resource) {
 			err = twl4030_configure_resource(resconfig);
 			if (err)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index ade1c06..069f78f 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -659,6 +659,7 @@ struct twl4030_power_data {
 	struct twl4030_script **scripts;
 	unsigned num;
 	struct twl4030_resconfig *resource_config;
+	struct twl4030_resconfig *board_config;
 #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
 	bool use_poweroff;	/* Board is wired for TWL poweroff */
 };
-- 
1.8.1.1


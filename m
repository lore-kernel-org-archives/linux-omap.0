From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/7] mfd: twl4030-power: Add support for board specific configuration
Date: Tue, 13 May 2014 18:34:08 -0700
Message-ID: <1400031250-29542-6-git-send-email-tony@atomide.com>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44766 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752070AbaENBeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2014 21:34:22 -0400
In-Reply-To: <1400031250-29542-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

With the recommended twl4030 configuration added, we can now add
board specific changes as modifications to the recommended
configuration.

Note that the data is private to this driver, and the data must
always have a NULL resource in the sentinel.

Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/twl4030-power.c | 21 +++++++++++++++++++++
 include/linux/i2c/twl.h     |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 39eeee2..4b3f192 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -557,13 +557,34 @@ twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
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
index 5fe0313..57fe782 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -662,6 +662,7 @@ struct twl4030_power_data {
 	struct twl4030_script **scripts;
 	unsigned num;
 	struct twl4030_resconfig *resource_config;
+	struct twl4030_resconfig *board_config;
 #define TWL4030_RESCONFIG_UNDEF	((u8)-1)
 	bool use_poweroff;	/* Board is wired for TWL poweroff */
 };
-- 
1.8.1.1


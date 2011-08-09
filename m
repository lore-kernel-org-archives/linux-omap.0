From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 2/3] OMAP2+: pm: clean up error messages
Date: Tue,  9 Aug 2011 18:34:20 +0200
Message-ID: <1312907661-24436-2-git-send-email-jhovold@gmail.com>
References: <1312907661-24436-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45654 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab1HIQel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 12:34:41 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so192442fxh.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Aug 2011 09:34:40 -0700 (PDT)
In-Reply-To: <1312907661-24436-1-git-send-email-jhovold@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Replace all printks with pr_err.

Clean up error messages by adding missing whitespace, fixing
capitalisations, removing double newlines, and reducing verbosity.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-omap2/pm.c |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index fd77cf4..3837818 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -137,8 +137,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 
 	ret = pwrdm_set_next_pwrst(pwrdm, state);
 	if (ret) {
-		printk(KERN_ERR "Unable to set state of powerdomain: %s\n",
-		       pwrdm->name);
+		pr_err("%s: unable to set state of powerdomain: %s\n",
+		       __func__, pwrdm->name);
 		goto err;
 	}
 
@@ -179,21 +179,20 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	unsigned long freq, bootup_volt;
 
 	if (!vdd_name || !clk_name || !dev) {
-		printk(KERN_ERR "%s: Invalid parameters!\n", __func__);
+		pr_err("%s: invalid parameters\n", __func__);
 		goto exit;
 	}
 
 	voltdm = omap_voltage_domain_lookup(vdd_name);
 	if (IS_ERR(voltdm)) {
-		printk(KERN_ERR "%s: Unable to get vdd pointer for vdd_%s\n",
+		pr_err("%s: unable to get vdd pointer for vdd_%s\n",
 			__func__, vdd_name);
 		goto exit;
 	}
 
 	clk =  clk_get(NULL, clk_name);
 	if (IS_ERR(clk)) {
-		printk(KERN_ERR "%s: unable to get clk %s\n",
-			__func__, clk_name);
+		pr_err("%s: unable to get clk %s\n", __func__, clk_name);
 		goto exit;
 	}
 
@@ -202,14 +201,14 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 
 	opp = opp_find_freq_ceil(dev, &freq);
 	if (IS_ERR(opp)) {
-		printk(KERN_ERR "%s: unable to find boot up OPP for vdd_%s\n",
+		pr_err("%s: unable to find boot up OPP for vdd_%s\n",
 			__func__, vdd_name);
 		goto exit;
 	}
 
 	bootup_volt = opp_get_voltage(opp);
 	if (!bootup_volt) {
-		printk(KERN_ERR "%s: unable to find voltage corresponding"
+		pr_err("%s: unable to find voltage corresponding "
 			"to the bootup OPP for vdd_%s\n", __func__, vdd_name);
 		goto exit;
 	}
@@ -218,8 +217,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	return 0;
 
 exit:
-	printk(KERN_ERR "%s: Unable to set vdd_%s to its init voltage\n\n",
-		__func__, vdd_name);
+	pr_err("%s: unable to set vdd_%s\n", __func__, vdd_name);
 	return -EINVAL;
 }
 
-- 
1.7.6


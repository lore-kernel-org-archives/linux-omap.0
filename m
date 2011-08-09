From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 1/3] OMAP2+: pm: fix typos
Date: Tue,  9 Aug 2011 18:34:19 +0200
Message-ID: <1312907661-24436-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45654 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab1HIQej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 12:34:39 -0400
Received: by fxh19 with SMTP id 19so192442fxh.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Aug 2011 09:34:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Fix typos in comment and error message.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-omap2/pm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 3feb359..fd77cf4 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -163,11 +163,11 @@ err:
 }
 
 /*
- * This API is to be called during init to put the various voltage
+ * This API is to be called during init to set the various voltage
  * domains to the voltage as per the opp table. Typically we boot up
  * at the nominal voltage. So this function finds out the rate of
  * the clock associated with the voltage domain, finds out the correct
- * opp entry and puts the voltage domain to the voltage specifies
+ * opp entry and sets the voltage domain to the voltage specified
  * in the opp entry
  */
 static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
@@ -218,7 +218,7 @@ static int __init omap2_set_init_voltage(char *vdd_name, char *clk_name,
 	return 0;
 
 exit:
-	printk(KERN_ERR "%s: Unable to put vdd_%s to its init voltage\n\n",
+	printk(KERN_ERR "%s: Unable to set vdd_%s to its init voltage\n\n",
 		__func__, vdd_name);
 	return -EINVAL;
 }
-- 
1.7.6


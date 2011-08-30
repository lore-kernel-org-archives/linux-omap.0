From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 1/2 RESEND] OMAP2+: pm: fix typos
Date: Tue, 30 Aug 2011 18:48:16 +0200
Message-ID: <1314722897-25040-1-git-send-email-jhovold@gmail.com>
References: <87r543rkdk.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65364 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258Ab1H3Qsq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 12:48:46 -0400
Received: by bke11 with SMTP id 11so5204748bke.19
        for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 09:48:45 -0700 (PDT)
In-Reply-To: <87r543rkdk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Johan Hovold <jhovold@gmail.com>

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


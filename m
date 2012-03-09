From: Kevin Hilman <khilman@ti.com>
Subject: DSS pwrdm usecount, disabling autodeps for DSS
Date: Thu, 08 Mar 2012 16:42:03 -0800
Message-ID: <87r4x27gh0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33735 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754087Ab2CIAmC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 19:42:02 -0500
Received: by iajr24 with SMTP id r24so1958849iaj.14
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 16:42:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

Hi Tomi,

A while ago you were asking about why DSS pwrdm counts were so high on
OMAP3, and why DSS was transitioning even though it was completely
unused. Paul and I just spent some a little time debugging this, and
narrowed it down to autodeps. (sorry it took so long, it finally
bothered me enough to actually look into it.)

The patch below fixes the problem at least when DSS is not loaded (DSS
just stays in retention), but I didn't try this with any active DSS
usage, or loading/unloding the DSS drivers.

Could you give the patch below a try on OMAP3 along with some active DSS
usage as well as unloading the modules after using.  Could you also
verify that suspend/resume continues to work for DSS?

Thanks,

Kevin

>From 42fc4f2acd9d6ba08992f8daa36297be384e76ef Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 8 Mar 2012 16:22:19 -0800
Subject: [PATCH] ARM: OMAP3: clockdomain: disable autodeps for DSS

Due to autodeps, the DSS powerdomain is transitioning with the MPU
powerdomain even when DSS is inactive.

autodeps are deprecated in favor of hwmod managing initiator
dependencies directly, and we're hoping to eventually remove them.

For starters, disable autodeps for DSS and see what happens...

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index b84e138..ba0285f 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -254,7 +254,7 @@ static struct clockdomain core_l4_3xxx_clkdm = {
 static struct clockdomain dss_3xxx_clkdm = {
 	.name		= "dss_clkdm",
 	.pwrdm		= { .name = "dss_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_NO_AUTODEPS,
 	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
 	.wkdep_srcs	= dss_wkdeps,
 	.sleepdep_srcs	= dss_sleepdeps,
-- 
1.7.9.2


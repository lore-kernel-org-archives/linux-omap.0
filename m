From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] AM35xx: disable checking for reserved feature bits
Date: Tue, 08 Nov 2011 16:57:48 -0800
Message-ID: <87d3d2kt83.fsf@ti.com>
References: <1320796298-7202-1-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:53303 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752587Ab1KIA5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 19:57:52 -0500
Received: by mail-yx0-f175.google.com with SMTP id m3so158470yen.20
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 16:57:51 -0800 (PST)
In-Reply-To: <1320796298-7202-1-git-send-email-yanok@emcraft.com> (Ilya
	Yanok's message of "Wed, 9 Nov 2011 00:51:38 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com

Ilya Yanok <yanok@emcraft.com> writes:

> Bits corresponding to the IVA and ISP features in OMAP_STATUS register
> are reserved on AM35xx and checking for them results in wrong results.

Ouch.

> So we don't want to check for this features on AM35xx.
>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

This "feature" selection mechanism is clearly not scaling to newer SoCs.
While this patch works around the problem, IMO, we need a more scalable
solution.

For features like IVA and ISP (and SGX) which are acutally IP blocks on
the SoC, not "features"  per-se, what we really need to be doing is
checking for the presence of the IP block, not checking a bit in a
register that's not consistent across various SoCs.

We already have all the knowledge about whether the IP blocks are
present in the SoC-specific hwmod data.  So checking for the "feature"
of a specific IP block should instead be done using an
omap_hwmod_lookup().

However, there's a bit of a snag because this "feature" detection is
currently done before the hwmods are registered.

As a quick-and-dirty proof of concept, the patch/hack below moves the
feature checking after the hwmod init (omap3 only currently) and uses
omap_hwmod_lookup() to check whether a given IP block exists.

I only did a quick test on one OMAP3 platform (3430/n900) and it seems
to work.    The init order changes need some more thought, as I didn't
fully validate whether the feature detection can be safely moved later
for all platforms.

This is just to show the direction we should be taking this SoC
detection for newer SoCs.

Kevin


diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 7f47092..54eaf23 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -23,6 +23,7 @@
 
 #include <plat/common.h>
 #include <plat/cpu.h>
+#include <plat/omap_hwmod.h>
 
 #include <mach/id.h>
 
@@ -172,6 +173,18 @@ static void __init omap24xx_check_revision(void)
 		omap_features |= OMAP3_HAS_ ##feat;			\
 	}
 
+static void omap_check_ip(char *name, u32 feat)	
+{
+	struct omap_hwmod *oh;
+
+	oh = omap_hwmod_lookup(name);
+	printk("%s: checking for %s\n", __func__, name);
+	if (oh) {
+		printk("%s: %s present\n", __func__, name);
+		omap_features |= feat;
+	}
+}
+
 static void __init omap3_check_features(void)
 {
 	u32 status;
@@ -180,11 +193,12 @@ static void __init omap3_check_features(void)
 
 	status = omap_ctrl_readl(OMAP3_CONTROL_OMAP_STATUS);
 
+	omap_check_ip("iva", OMAP3_HAS_IVA);
+	omap_check_ip("isp", OMAP3_HAS_ISP);
+
 	OMAP3_CHECK_FEATURE(status, L2CACHE);
-	OMAP3_CHECK_FEATURE(status, IVA);
 	OMAP3_CHECK_FEATURE(status, SGX);
 	OMAP3_CHECK_FEATURE(status, NEON);
-	OMAP3_CHECK_FEATURE(status, ISP);
 	if (cpu_is_omap3630())
 		omap_features |= OMAP3_HAS_192MHZ_CLK;
 	if (cpu_is_omap3430() || cpu_is_omap3630())
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 25d20ce..c3faa7e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -393,12 +393,12 @@ void __init omap2430_init_early(void)
 void __init omap3_init_early(void)
 {
 	omap2_set_globals_3xxx();
-	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
 	omap3xxx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_common_init_early();
 	omap3xxx_clk_init();
 }
 


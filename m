From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap2+: Make omap_hwmod_late_init into core_initcall
Date: Mon, 24 Jan 2011 18:24:05 -0800
Message-ID: <20110125022405.GH13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
 <20110124201731.GC13589@atomide.com>
 <20110124202629.GE13589@atomide.com>
 <20110124215213.GA27044@n2100.arm.linux.org.uk>
 <20110125022119.GG13589@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14122 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab1AYCY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 21:24:28 -0500
Content-Disposition: inline
In-Reply-To: <20110125022119.GG13589@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Otherwise things will fail with early_init changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..8f47609 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -402,8 +402,6 @@ void __init omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 {
 	omap_serial_early_init();
 
-	omap_hwmod_late_init();
-
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
 		_omap2_init_reprogram_sdrc();
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e282e35..eacdfd3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1628,7 +1628,7 @@ int __init omap_hwmod_init(struct omap_hwmod **ohs)
  * to struct clk pointers for each registered omap_hwmod.  Also calls
  * _setup() on each hwmod.  Returns 0.
  */
-int omap_hwmod_late_init(void)
+static int __init omap_hwmod_late_init(void)
 {
 	int r;
 
@@ -1644,6 +1644,7 @@ int omap_hwmod_late_init(void)
 
 	return 0;
 }
+core_initcall(omap_hwmod_late_init);
 
 /**
  * omap_hwmod_enable - enable an omap_hwmod
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1eee85a..fedd829 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -539,7 +539,6 @@ int omap_hwmod_init(struct omap_hwmod **ohs);
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
-int omap_hwmod_late_init(void);
 
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int _omap_hwmod_enable(struct omap_hwmod *oh);

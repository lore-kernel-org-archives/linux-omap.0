From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 6/6] ARM: OMAP2+: hwmod: use init-time function pointer for _init_clkdm
Date: Fri, 27 Apr 2012 13:05:40 -0700
Message-ID: <1335557140-10854-7-git-send-email-khilman@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:36629 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752244Ab2D0UFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 16:05:01 -0400
Received: by pbbrq13 with SMTP id rq13so1500228pbb.36
        for <linux-omap@vger.kernel.org>; Fri, 27 Apr 2012 13:05:00 -0700 (PDT)
In-Reply-To: <1335557140-10854-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Rather than use runtime cpu_is* checking inside _init_clkdm, initialize
SoC specific function pointer at init time.

Note that initializing the function pointer oh->init_clkdm pointer
must be done before _init_clocks() is called because it is used there.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   19 +++++++++----------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6b08f19..e7d95e6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1288,9 +1288,6 @@ static struct omap_hwmod *_lookup(const char *name)
  */
 static int _init_clkdm(struct omap_hwmod *oh)
 {
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return 0;
-
 	if (!oh->clkdm_name) {
 		pr_warning("omap_hwmod: %s: no clkdm_name\n", oh->name);
 		return -EINVAL;
@@ -1331,7 +1328,8 @@ static int _init_clocks(struct omap_hwmod *oh, void *data)
 	ret |= _init_main_clk(oh);
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
-	ret |= _init_clkdm(oh);
+	if (oh->init_clkdm)
+		ret |= oh->init_clkdm(oh);
 
 	if (!ret)
 		oh->_state = _HWMOD_STATE_CLKS_INITED;
@@ -2082,12 +2080,6 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 
 	_init_mpu_rt_base(oh, NULL);
 
-	r = _init_clocks(oh, NULL);
-	if (IS_ERR_VALUE(r)) {
-		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
-		return -EINVAL;
-	}
-
 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		oh->wait_module_ready = omap2_wait_module_ready;
 		oh->assert_hardreset = omap2_assert_hardreset;
@@ -2100,6 +2092,13 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 		oh->assert_hardreset = omap4_assert_hardreset;
 		oh->deassert_hardreset = omap4_deassert_hardreset;
 		oh->is_hardreset_asserted = omap4_is_hardreset_asserted;
+		oh->init_clkdm = _init_clkdm;
+	}
+
+	r = _init_clocks(oh, NULL);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh->name);
+		return -EINVAL;
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 4f512b6..6c10e08 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -574,6 +574,7 @@ struct omap_hwmod {
 				  struct omap_hwmod_rst_info *ohri);
 	int (*is_hardreset_asserted)(struct omap_hwmod *oh,
 				     struct omap_hwmod_rst_info *ohri);
+	int (*init_clkdm)(struct omap_hwmod *oh);
 };
 
 struct omap_hwmod *omap_hwmod_lookup(const char *name);
-- 
1.7.9.2


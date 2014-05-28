From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 3/6] ARM: OMAP2+: Add CONTROL_MODULE_CORE as a clock provider for DRA7x
Date: Wed, 28 May 2014 16:20:52 +0530
Message-ID: <1401274255-16845-4-git-send-email-archit@ti.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
 <1401274255-16845-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37318 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbaE1Kw3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2014 06:52:29 -0400
In-Reply-To: <1401274255-16845-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

In DRA7x SoCs, the CONTROL_MODULE_CORE sub block in the control module has a
few register fields which perform gating or muxing of clocks.

These gate/muxes are generally SoC level clocks entering an IP, which didn't
manage to make it in the clock management related registers for the IP.

Other OMAP SOCs don't seem to have clock related register fields in the control
module.

We create a new table and function to init ctrl-core IPS as clock providers.
This, along with scrm clock providers, are initialized in of_control_init().
We add a compatible string for dra7-ctrl-core in the DT match table.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/control.c | 22 +++++++++++++++++++++-
 arch/arm/mach-omap2/control.h |  2 +-
 arch/arm/mach-omap2/io.c      |  2 +-
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 12cd736..d9567bc 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -592,7 +592,27 @@ static struct of_device_id omap_scrm_dt_match_table[] = {
 	{ }
 };
 
-int __init of_scrm_init(void)
+static int __init of_scrm_init(void)
 {
 	return of_prcm_module_init(omap_scrm_dt_match_table);
 }
+
+static struct of_device_id omap_ctrl_core_dt_match_table[] = {
+	{ .compatible = "ti,dra7-ctrl-core" },
+	{ }
+};
+
+static int __init of_ctrl_core_init(void)
+{
+	return of_prcm_module_init(omap_ctrl_core_dt_match_table);
+}
+
+int __init of_control_init(void)
+{
+	int ret;
+
+	ret = of_scrm_init();
+	ret |= of_ctrl_core_init();
+
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index 5d695f1..405979e 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -428,7 +428,7 @@ extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 extern void omap3_ctrl_set_iva_bootmode_idle(void);
-int of_scrm_init(void);
+int of_control_init(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c78e2b8..49e344b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -725,7 +725,7 @@ int __init omap_clk_init(void)
 	if (!omap_clk_soc_init)
 		return 0;
 
-	ret = of_scrm_init();
+	ret = of_control_init();
 	if (ret)
 		return ret;
 
-- 
1.8.3.2


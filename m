From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/19] OMAP3 clock: Check return values for clk_get()
Date: Mon, 15 Feb 2010 18:24:51 -0700
Message-ID: <20100216012450.1101.88296.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57422 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495Ab0BPB07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:59 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

From: Sanjeev Premi <premi@ti.com>

This patch checks if clk_get() returned success for
the clocks used in function omap2_clk_arch_init().

This version incorporates review comments from
Kevin Hilman and Paul Walmsley.

Signed-off-by: Sanjeev Premi <premi@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 6180a03..37da629 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/err.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -286,6 +287,7 @@ static int __init omap3xxx_clk_arch_init(void)
 {
 	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
 	unsigned long osc_sys_rate;
+	bool err = 0;
 
 	if (!cpu_is_omap34xx())
 		return 0;
@@ -295,9 +297,23 @@ static int __init omap3xxx_clk_arch_init(void)
 
 	/* XXX test these for success */
 	dpll1_ck = clk_get(NULL, "dpll1_ck");
+	if (WARN(IS_ERR(dpll1_ck), "Failed to get dpll1_ck.\n"))
+		err = 1;
+
 	arm_fck = clk_get(NULL, "arm_fck");
+	if (WARN(IS_ERR(arm_fck), "Failed to get arm_fck.\n"))
+		err = 1;
+
 	core_ck = clk_get(NULL, "core_ck");
+	if (WARN(IS_ERR(core_ck), "Failed to get core_ck.\n"))
+		err = 1;
+
 	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
+	if (WARN(IS_ERR(osc_sys_ck), "Failed to get osc_sys_ck.\n"))
+		err = 1;
+
+	if (err)
+		return -ENOENT;
 
 	/* REVISIT: not yet ready for 343x */
 	if (clk_set_rate(dpll1_ck, mpurate))



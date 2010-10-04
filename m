From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH] OMAP3: SDRC : Add comments on Errata i520 for Global SW reset
Date: Mon,  4 Oct 2010 20:09:36 +0530
Message-ID: <1286203176-32602-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51823 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab0JDOl6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 10:41:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>

This patch adds comments on precatution to be taken if Global SW reset is
used as the means to trigger sysem reset.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index c201374..fdc860e
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -157,6 +157,32 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 	else
 		WARN_ON(1);
 
+	/* As per Errata i520, In some cases, user
+	 * will not be able to access DDR memory after warm-reset.
+	 * This situation occurs while the warm-reset happens during a read
+	 * access to DDR memory. In that particular condition, DDR memory
+	 * does not respond to a corrupted read command due to the warm
+	 * reset occurence but SDRC is waiting for read completion.
+	 * SDRC is not sensitive to the warm reset, but the interconect is
+	 * reset on the fly, thus causing a misalignment between SDRC logic,
+	 * interconect logic and DDR memory state.
+	 * WORKAROUND:
+	 * Steps to perform before a Warm reset is trigged:
+	 * 1. enable self-refresh on idle request
+	 * 2. put SDRC in idle
+	 * 3. wait until SDRC goes to idle
+	 * 4. generate SW reset (Global SW reset)
+
+	 * Steps to be performed after warm reset occurs (in bootloader):
+	 * if HW warm reset is the source, apply below steps before any
+	 * accesses to SDRAM:
+	 * 1. Reset SMS and SDRC and wait till reset is complete
+	 * 2. Re-initialize SMS, SDRC and memory
+
+	 * NOTE: Above work around is required only if arch reset is implemented
+	 * using Global SW reset(GLOBAL_SW_RST). DPLL3 reset does not need
+	 * the WA since it resets SDRC as well as part of cold reset. */
+
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
 						 OMAP2_RM_RSTCTRL);
-- 
1.7.0.4


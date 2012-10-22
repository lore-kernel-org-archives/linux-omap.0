From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC] ARM: OMAP: hwmod: wait for sysreset complete after enabling hwmod
Date: Mon, 22 Oct 2012 19:15:32 +0300
Message-ID: <1350922532-26338-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46927 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240Ab2JVQPi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 12:15:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Venkatraman S <svenkatr@ti.com>

When waking up from off-mode, some IP blocks are reset automatically by
hardware. For this reason, software must wait until the reset has
completed before attempting to access the IP block.

This patch fixes for example the bug introduced by commit
6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c ("mmc: omap_hsmmc: remove access
to SYSCONFIG register"), in which the MMC IP block is reset during
off-mode entry, but the code expects the module to be already available
during the execution of context restore.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b969ab1..523729b 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1278,6 +1278,7 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	u8 idlemode, sf;
 	u32 v;
 	bool clkdm_act;
+	int c;
 
 	if (!oh->class->sysc)
 		return;
@@ -1338,6 +1339,27 @@ static void _enable_sysc(struct omap_hwmod *oh)
 		_set_module_autoidle(oh, idlemode, &v);
 		_write_sysconfig(v, oh);
 	}
+
+	/*
+	 * Wait until reset has completed, this is needed as the IP
+	 * block is reset automatically by hardware in some cases
+	 * (off-mode for example), and the drivers require the
+	 * IP to be ready when they access it
+	 */
+	if (sf & SYSS_HAS_RESET_STATUS)
+		omap_test_timeout((omap_hwmod_read(oh,
+						   oh->class->sysc->syss_offs)
+				   & SYSS_RESETDONE_MASK),
+				  MAX_MODULE_SOFTRESET_WAIT, c);
+
+	if (sf & SYSC_HAS_RESET_STATUS) {
+		u32 softrst_mask =
+			(0x1 << oh->class->sysc->sysc_fields->srst_shift);
+		omap_test_timeout(!(omap_hwmod_read(oh,
+						    oh->class->sysc->sysc_offs)
+				   & softrst_mask),
+				  MAX_MODULE_SOFTRESET_WAIT, c);
+	}
 }
 
 /**
-- 
1.7.4.1


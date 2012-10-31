From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/4] ARM: OMAP: hwmod: wait for sysreset complete after
 enabling hwmod
Date: Wed, 31 Oct 2012 04:43:13 -0600
Message-ID: <20121031104312.6557.22628.stgit@dusk.lan>
References: <20121031103607.6557.64591.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:51164 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291Ab2JaKqj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 06:46:39 -0400
In-Reply-To: <20121031103607.6557.64591.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Venkatraman S <svenkatr@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Tero Kristo <t-kristo@ti.com>

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
Tested-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: moved softreset wait code into separate function; call
 from top of _enable_sysc() rather than the bottom]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   56 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b969ab1..f9d8b2a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -422,6 +422,38 @@ static int _set_softreset(struct omap_hwmod *oh, u32 *v)
 }
 
 /**
+ * _wait_softreset_complete - wait for an OCP softreset to complete
+ * @oh: struct omap_hwmod * to wait on
+ *
+ * Wait until the IP block represented by @oh reports that its OCP
+ * softreset is complete.  This can be triggered by software (see
+ * _ocp_softreset()) or by hardware upon returning from off-mode (one
+ * example is HSMMC).  Waits for up to MAX_MODULE_SOFTRESET_WAIT
+ * microseconds.  Returns the number of microseconds waited.
+ */
+static int _wait_softreset_complete(struct omap_hwmod *oh)
+{
+	struct omap_hwmod_class_sysconfig *sysc;
+	u32 softrst_mask;
+	int c = 0;
+
+	sysc = oh->class->sysc;
+
+	if (sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
+		omap_test_timeout((omap_hwmod_read(oh, sysc->syss_offs)
+				   & SYSS_RESETDONE_MASK),
+				  MAX_MODULE_SOFTRESET_WAIT, c);
+	else if (sysc->sysc_flags & SYSC_HAS_RESET_STATUS) {
+		softrst_mask = (0x1 << sysc->sysc_fields->srst_shift);
+		omap_test_timeout(!(omap_hwmod_read(oh, sysc->sysc_offs)
+				    & softrst_mask),
+				  MAX_MODULE_SOFTRESET_WAIT, c);
+	}
+
+	return c;
+}
+
+/**
  * _set_dmadisable: set OCP_SYSCONFIG.DMADISABLE bit in @v
  * @oh: struct omap_hwmod *
  *
@@ -1282,6 +1314,14 @@ static void _enable_sysc(struct omap_hwmod *oh)
 	if (!oh->class->sysc)
 		return;
 
+	/*
+	 * Wait until reset has completed, this is needed as the IP
+	 * block is reset automatically by hardware in some cases
+	 * (off-mode for example), and the drivers require the
+	 * IP to be ready when they access it
+	 */
+	_wait_softreset_complete(oh);
+
 	v = oh->_sysc_cache;
 	sf = oh->class->sysc->sysc_flags;
 
@@ -1804,7 +1844,7 @@ static int _am33xx_disable_module(struct omap_hwmod *oh)
  */
 static int _ocp_softreset(struct omap_hwmod *oh)
 {
-	u32 v, softrst_mask;
+	u32 v;
 	int c = 0;
 	int ret = 0;
 
@@ -1834,19 +1874,7 @@ static int _ocp_softreset(struct omap_hwmod *oh)
 	if (oh->class->sysc->srst_udelay)
 		udelay(oh->class->sysc->srst_udelay);
 
-	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
-		omap_test_timeout((omap_hwmod_read(oh,
-						    oh->class->sysc->syss_offs)
-				   & SYSS_RESETDONE_MASK),
-				  MAX_MODULE_SOFTRESET_WAIT, c);
-	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS) {
-		softrst_mask = (0x1 << oh->class->sysc->sysc_fields->srst_shift);
-		omap_test_timeout(!(omap_hwmod_read(oh,
-						     oh->class->sysc->sysc_offs)
-				   & softrst_mask),
-				  MAX_MODULE_SOFTRESET_WAIT, c);
-	}
-
+	c = _wait_softreset_complete(oh);
 	if (c == MAX_MODULE_SOFTRESET_WAIT)
 		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",
 			   oh->name, MAX_MODULE_SOFTRESET_WAIT);



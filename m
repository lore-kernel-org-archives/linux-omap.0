From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/7] ARM: OMAP2+: PRM: prepare for use of prm_ll_data
 function pointers
Date: Mon, 15 Oct 2012 19:32:09 -0600
Message-ID: <20121016013203.21844.65536.stgit@dusk.lan>
References: <20121016012448.21844.92339.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42851 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486Ab2JPBe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:34:27 -0400
In-Reply-To: <20121016012448.21844.92339.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

There are several PRM operations which behave similarly across OMAP2+
SoCs, but which have slight differences in their underlying
implementations.  For example, to fetch the SoC's last reset sources,
different registers are read across OMAP2xxx, 3xxx, and 44xx, and
different bits are used on each SoC.  But the information returned is
so similar that a single, common interface for drivers is useful.

This patch creates the support code for this function pointer
registration process.  No function pointers are included yet, but a
subsequent patch will create one for the reset source API.

To illustrate the end goal with the above reset source example, each
per-SoC driver will use its own low-level implementation function --
e.g., prm2xxx.c would contain omap2xxx_prm_read_reset_sources().  This
function would read the appropriate register and remap the register
bits to a standard set of reset source bits.  When the prm2xxx.c
driver is loaded, it would register this function with the common PRM
driver, prm.c.  prm.c would then export a common function,
omap_prm_read_reset_sources().  Calling it would call through to the
function pointer for the currently-registered SoC PRM driver.  This
will allow other drivers to use PRM-provided data and operations
without needing to know which SoC is currently in use.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm.h        |   11 ++++++++
 arch/arm/mach-omap2/prm_common.c |   52 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 39d5621..3e51c1d 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -52,5 +52,16 @@
 #define OMAP_POWERSTATE_SHIFT				0
 #define OMAP_POWERSTATE_MASK				(0x3 << 0)
 
+#ifndef __ASSEMBLER__
+
+/**
+ * struct prm_ll_data - fn ptrs to per-SoC PRM function implementations
+ */
+struct prm_ll_data {};
+
+extern int prm_register(struct prm_ll_data *pld);
+extern int prm_unregister(struct prm_ll_data *pld);
+
+#endif
 
 #endif
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 0a100d9..8670a3c 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -53,6 +53,13 @@ static struct irq_chip_generic **prcm_irq_chips;
  */
 static struct omap_prcm_irq_setup *prcm_irq_setup;
 
+/*
+ * prm_ll_data: function pointers to SoC-specific implementations of
+ * common PRM functions
+ */
+static struct prm_ll_data null_prm_ll_data;
+static struct prm_ll_data *prm_ll_data = &null_prm_ll_data;
+
 /* Private functions */
 
 /*
@@ -318,3 +325,48 @@ err:
 	omap_prcm_irq_cleanup();
 	return -ENOMEM;
 }
+
+/**
+ * prm_register - register per-SoC low-level data with the PRM
+ * @pld: low-level per-SoC OMAP PRM data & function pointers to register
+ *
+ * Register per-SoC low-level OMAP PRM data and function pointers with
+ * the OMAP PRM common interface.  The caller must keep the data
+ * pointed to by @pld valid until it calls prm_unregister() and
+ * it returns successfully.  Returns 0 upon success, -EINVAL if @pld
+ * is NULL, or -EEXIST if prm_register() has already been called
+ * without an intervening prm_unregister().
+ */
+int prm_register(struct prm_ll_data *pld)
+{
+	if (!pld)
+		return -EINVAL;
+
+	if (prm_ll_data != &null_prm_ll_data)
+		return -EEXIST;
+
+	prm_ll_data = pld;
+
+	return 0;
+}
+
+/**
+ * prm_unregister - unregister per-SoC low-level data & function pointers
+ * @pld: low-level per-SoC OMAP PRM data & function pointers to unregister
+ *
+ * Unregister per-SoC low-level OMAP PRM data and function pointers
+ * that were previously registered with prm_register().  The
+ * caller may not destroy any of the data pointed to by @pld until
+ * this function returns successfully.  Returns 0 upon success, or
+ * -EINVAL if @pld is NULL or if @pld does not match the struct
+ * prm_ll_data * previously registered by prm_register().
+ */
+int prm_unregister(struct prm_ll_data *pld)
+{
+	if (!pld || prm_ll_data != pld)
+		return -EINVAL;
+
+	prm_ll_data = &null_prm_ll_data;
+
+	return 0;
+}



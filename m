From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/12] OMAP2/3: Add omap_type() for determining GP/EMU/HS
Date: Mon, 22 Jun 2009 14:45:06 +0300
Message-ID: <20090622114506.28477.81240.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50382 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZFVLpG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:45:06 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.deeprootsystems.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

The omap_type() function is added and returns the DEVICETYPE field of
the CONTROL_STATUS register.  The result can be used for conditional
code based on whether device is GP (general purpose), EMU or
HS (high security). Also move the type defines so omap1 code
compile does not require ifdefs for sections using these defines.

This code is needed for the following fix to set the SRAM
size correctly for HS omaps.  Also at least PM and watchdog
code will need this function.

Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c              |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/cpu.h |   22 +++++++++++-----------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 458990e..a98201c 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -48,6 +48,28 @@ int omap_chip_is(struct omap_chip_id oci)
 }
 EXPORT_SYMBOL(omap_chip_is);
 
+int omap_type(void)
+{
+	u32 val = 0;
+
+	if (cpu_is_omap24xx())
+		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
+	else if (cpu_is_omap34xx())
+		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
+	else {
+		pr_err("Cannot detect omap type!\n");
+		goto out;
+	}
+
+	val &= OMAP2_DEVICETYPE_MASK;
+	val >>= 8;
+
+out:
+	return val;
+}
+EXPORT_SYMBOL(omap_type);
+
+
 /*----------------------------------------------------------------------------*/
 
 #define OMAP_TAP_IDCODE		0x0204
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index fc60c4e..285eaa3 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -30,6 +30,17 @@
 #ifndef __ASM_ARCH_OMAP_CPU_H
 #define __ASM_ARCH_OMAP_CPU_H
 
+/*
+ * Omap device type i.e. EMU/HS/TST/GP/BAD
+ */
+#define OMAP2_DEVICE_TYPE_TEST		0
+#define OMAP2_DEVICE_TYPE_EMU		1
+#define OMAP2_DEVICE_TYPE_SEC		2
+#define OMAP2_DEVICE_TYPE_GP		3
+#define OMAP2_DEVICE_TYPE_BAD		4
+
+int omap_type(void);
+
 struct omap_chip_id {
 	u8 oc;
 	u8 type;
@@ -424,17 +435,6 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 
 int omap_chip_is(struct omap_chip_id oci);
-int omap_type(void);
-
-/*
- * Macro to detect device type i.e. EMU/HS/TST/GP/BAD
- */
-#define OMAP2_DEVICE_TYPE_TEST		0
-#define OMAP2_DEVICE_TYPE_EMU		1
-#define OMAP2_DEVICE_TYPE_SEC		2
-#define OMAP2_DEVICE_TYPE_GP		3
-#define OMAP2_DEVICE_TYPE_BAD		4
-
 void omap2_check_revision(void);
 
 #endif    /* defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) */


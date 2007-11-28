From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] improve System Control Module defines
Date: Wed, 28 Nov 2007 03:00:10 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711280258450.6342@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
Cc: jmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

This patch:

- prefaces the SCM register offsets with the appropriate platform string
  (e.g., OMAP2_ for 24xx/34xx-common registers) and updates code that uses
  these registers to use the correct name;

- adds some more register bit defines (e.g., OMAP2_DEVICETYPE_MASK) and 
  cleans up code to use these common macros;

- fixes the offset of the CONTROL_STATUS register on 24xx that partially
  caused SRAM patcher problems (with thanks to Kyungmin Park 
  <kmpark@infradead.org> for finding this problem)

- adds many more register offset defines for the 'GENERAL' section of the 
  SCM.

Boot-tested on N800 and 2430SDP.  3430SDP is down at the moment, so
can't test there.  Incidentally, on N800, there is no vmlinux size 
difference between unpatched and patched kernels.  Comments welcome.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/board-h4.c      |    5 +
 arch/arm/mach-omap2/clock34xx.h     |   10 +-
 arch/arm/mach-omap2/id.c            |   20 ++++-
 arch/arm/mach-omap2/pm.c            |    4 -
 arch/arm/plat-omap/devices.c        |    4 -
 arch/arm/plat-omap/sram.c           |    4 -
 arch/arm/plat-omap/usb.c            |   16 ++--
 drivers/usb/gadget/omap_udc.c       |   10 ++
 include/asm-arm/arch-omap/control.h |  142 +++++++++++++++++++++++++++++++-----
 9 files changed, 174 insertions(+), 41 deletions(-)

Index: linux-omap/include/asm-arm/arch-omap/control.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/control.h	2007-11-27 17:37:30.000000000 -0700
+++ linux-omap/include/asm-arm/arch-omap/control.h	2007-11-28 01:44:29.000000000 -0700
@@ -22,37 +22,145 @@
 #define OMAP243X_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + reg)
 #define OMAP343X_CTRL_REGADDR(reg)	(void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + reg)
 
+/*
+ * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid for
+ * OMAP24XX and OMAP34XX.
+ */
+
 /* Control submodule offsets */
 
-#define CONTROL_INTERFACE		0x000
-#define CONTROL_PADCONFS		0x030
-#define CONTROL_GENERAL			0x270
-#define CONTROL_MEM_WKUP		0x600
-#define CONTROL_PADCONFS_WKUP		0xa00
-#define CONTROL_GENERAL_WKUP		0xa60
+#define OMAP2_CONTROL_INTERFACE		0x000
+#define OMAP2_CONTROL_PADCONFS		0x030
+#define OMAP2_CONTROL_GENERAL		0x270
+#define OMAP343X_CONTROL_MEM_WKUP	0x600
+#define OMAP343X_CONTROL_PADCONFS_WKUP	0xa00
+#define OMAP343X_CONTROL_GENERAL_WKUP	0xa60
 
 /* Control register offsets - read/write with ctrl_{read,write}_reg() */
 
-#define CONTROL_SYSCONFIG		(CONTROL_INTERFACE + 0x10)
+#define OMAP2_CONTROL_SYSCONFIG		(OMAP2_CONTROL_INTERFACE + 0x10)
 
-#define CONTROL_DEVCONF0		(CONTROL_GENERAL + 0x04)
-#define CONTROL_DEVCONF1		(CONTROL_GENERAL + 0x68) /* > 242x */
-#define CONTROL_STATUS			(CONTROL_GENERAL + 0x80)
+/* CONTROL_GENERAL register offsets common to OMAP2 & 3 */
+#define OMAP2_CONTROL_DEVCONF0		(OMAP2_CONTROL_GENERAL + 0x0004)
+#define OMAP2_CONTROL_MSUSPENDMUX_0	(OMAP2_CONTROL_GENERAL + 0x0020)
+#define OMAP2_CONTROL_MSUSPENDMUX_1	(OMAP2_CONTROL_GENERAL + 0x0024)
+#define OMAP2_CONTROL_MSUSPENDMUX_2	(OMAP2_CONTROL_GENERAL + 0x0028)
+#define OMAP2_CONTROL_MSUSPENDMUX_3	(OMAP2_CONTROL_GENERAL + 0x002c)
+#define OMAP2_CONTROL_MSUSPENDMUX_4	(OMAP2_CONTROL_GENERAL + 0x0030)
+#define OMAP2_CONTROL_MSUSPENDMUX_5	(OMAP2_CONTROL_GENERAL + 0x0034)
+#define OMAP2_CONTROL_SEC_CTRL		(OMAP2_CONTROL_GENERAL + 0x0040)
+#define OMAP2_CONTROL_RPUB_KEY_H_0	(OMAP2_CONTROL_GENERAL + 0x0090)
+#define OMAP2_CONTROL_RPUB_KEY_H_1	(OMAP2_CONTROL_GENERAL + 0x0094)
+#define OMAP2_CONTROL_RPUB_KEY_H_2	(OMAP2_CONTROL_GENERAL + 0x0098)
+#define OMAP2_CONTROL_RPUB_KEY_H_3	(OMAP2_CONTROL_GENERAL + 0x009c)
+
+/* 242x-only CONTROL_GENERAL register offsets */
+#define OMAP242X_CONTROL_DEVCONF	OMAP2_CONTROL_DEVCONF0 /* match TRM */
+#define OMAP242X_CONTROL_OCM_RAM_PERM	(OMAP2_CONTROL_GENERAL + 0x0068)
+
+/* 243x-only CONTROL_GENERAL register offsets */
+/* CONTROL_IVA2_BOOT{ADDR,MOD} are at the same place on 343x - noted below */
+#define OMAP243X_CONTROL_DEVCONF1	(OMAP2_CONTROL_GENERAL + 0x0078)
+#define OMAP243X_CONTROL_CSIRXFE	(OMAP2_CONTROL_GENERAL + 0x007c)
+#define OMAP243X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
+#define OMAP243X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
+#define OMAP243X_CONTROL_IVA2_GEMCFG	(OMAP2_CONTROL_GENERAL + 0x0198)
+
+/* 24xx-only CONTROL_GENERAL register offsets */
+#define OMAP24XX_CONTROL_DEBOBS		(OMAP2_CONTROL_GENERAL + 0x0000)
+#define OMAP24XX_CONTROL_EMU_SUPPORT	(OMAP2_CONTROL_GENERAL + 0x0008)
+#define OMAP24XX_CONTROL_SEC_TEST	(OMAP2_CONTROL_GENERAL + 0x0044)
+#define OMAP24XX_CONTROL_PSA_CTRL	(OMAP2_CONTROL_GENERAL + 0x0048)
+#define OMAP24XX_CONTROL_PSA_CMD	(OMAP2_CONTROL_GENERAL + 0x004c)
+#define OMAP24XX_CONTROL_PSA_VALUE	(OMAP2_CONTROL_GENERAL + 0x0050)
+#define OMAP24XX_CONTROL_SEC_EMU	(OMAP2_CONTROL_GENERAL + 0x0060)
+#define OMAP24XX_CONTROL_SEC_TAP	(OMAP2_CONTROL_GENERAL + 0x0064)
+#define OMAP24XX_CONTROL_OCM_PUB_RAM_ADD	(OMAP2_CONTROL_GENERAL + 0x006c)
+#define OMAP24XX_CONTROL_EXT_SEC_RAM_START_ADD	(OMAP2_CONTROL_GENERAL + 0x0070)
+#define OMAP24XX_CONTROL_EXT_SEC_RAM_STOP_ADD	(OMAP2_CONTROL_GENERAL + 0x0074
+#define OMAP24XX_CONTROL_SEC_STATUS		(OMAP2_CONTROL_GENERAL + 0x0080)
+#define OMAP24XX_CONTROL_SEC_ERR_STATUS		(OMAP2_CONTROL_GENERAL + 0x0084)
+#define OMAP24XX_CONTROL_STATUS			(OMAP2_CONTROL_GENERAL + 0x0088)
+#define OMAP24XX_CONTROL_GENERAL_PURPOSE_STATUS	(OMAP2_CONTROL_GENERAL + 0x008c)
+#define OMAP24XX_CONTROL_RAND_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00a0)
+#define OMAP24XX_CONTROL_RAND_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00a4)
+#define OMAP24XX_CONTROL_RAND_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00a8)
+#define OMAP24XX_CONTROL_RAND_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00ac)
+#define OMAP24XX_CONTROL_CUST_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00b0)
+#define OMAP24XX_CONTROL_CUST_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00b4)
+#define OMAP24XX_CONTROL_TEST_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00c0)
+#define OMAP24XX_CONTROL_TEST_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00c4)
+#define OMAP24XX_CONTROL_TEST_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00c8)
+#define OMAP24XX_CONTROL_TEST_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00cc)
+#define OMAP24XX_CONTROL_TEST_KEY_4	(OMAP2_CONTROL_GENERAL + 0x00d0)
+#define OMAP24XX_CONTROL_TEST_KEY_5	(OMAP2_CONTROL_GENERAL + 0x00d4)
+#define OMAP24XX_CONTROL_TEST_KEY_6	(OMAP2_CONTROL_GENERAL + 0x00d8)
+#define OMAP24XX_CONTROL_TEST_KEY_7	(OMAP2_CONTROL_GENERAL + 0x00dc)
+#define OMAP24XX_CONTROL_TEST_KEY_8	(OMAP2_CONTROL_GENERAL + 0x00e0)
+#define OMAP24XX_CONTROL_TEST_KEY_9	(OMAP2_CONTROL_GENERAL + 0x00e4)
+
+/* 34xx-only CONTROL_GENERAL register offsets */
+#define OMAP343X_CONTROL_PADCONF_OFF	(OMAP2_CONTROL_GENERAL + 0x0000)
+#define OMAP343X_CONTROL_MEM_DFTRW0	(OMAP2_CONTROL_GENERAL + 0x0008)
+#define OMAP343X_CONTROL_MEM_DFTRW1	(OMAP2_CONTROL_GENERAL + 0x000c)
+#define OMAP343X_CONTROL_DEVCONF1	(OMAP2_CONTROL_GENERAL + 0x0068)
+#define OMAP343X_CONTROL_CSIRXFE		(OMAP2_CONTROL_GENERAL + 0x006c)
+#define OMAP343X_CONTROL_SEC_STATUS		(OMAP2_CONTROL_GENERAL + 0x0070)
+#define OMAP343X_CONTROL_SEC_ERR_STATUS		(OMAP2_CONTROL_GENERAL + 0x0074)
+#define OMAP343X_CONTROL_SEC_ERR_STATUS_DEBUG	(OMAP2_CONTROL_GENERAL + 0x0078)
+#define OMAP343X_CONTROL_STATUS			(OMAP2_CONTROL_GENERAL + 0x0080)
+#define OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS	(OMAP2_CONTROL_GENERAL + 0x0084)
+#define OMAP343X_CONTROL_RPUB_KEY_H_4	(OMAP2_CONTROL_GENERAL + 0x00a0)
+#define OMAP343X_CONTROL_RAND_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00a8)
+#define OMAP343X_CONTROL_RAND_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00ac)
+#define OMAP343X_CONTROL_RAND_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00b0)
+#define OMAP343X_CONTROL_RAND_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00b4)
+#define OMAP343X_CONTROL_TEST_KEY_0	(OMAP2_CONTROL_GENERAL + 0x00c8)
+#define OMAP343X_CONTROL_TEST_KEY_1	(OMAP2_CONTROL_GENERAL + 0x00cc)
+#define OMAP343X_CONTROL_TEST_KEY_2	(OMAP2_CONTROL_GENERAL + 0x00d0)
+#define OMAP343X_CONTROL_TEST_KEY_3	(OMAP2_CONTROL_GENERAL + 0x00d4)
+#define OMAP343X_CONTROL_TEST_KEY_4	(OMAP2_CONTROL_GENERAL + 0x00d8)
+#define OMAP343X_CONTROL_TEST_KEY_5	(OMAP2_CONTROL_GENERAL + 0x00dc)
+#define OMAP343X_CONTROL_TEST_KEY_6	(OMAP2_CONTROL_GENERAL + 0x00e0)
+#define OMAP343X_CONTROL_TEST_KEY_7	(OMAP2_CONTROL_GENERAL + 0x00e4)
+#define OMAP343X_CONTROL_TEST_KEY_8	(OMAP2_CONTROL_GENERAL + 0x00e8)
+#define OMAP343X_CONTROL_TEST_KEY_9	(OMAP2_CONTROL_GENERAL + 0x00ec)
+#define OMAP343X_CONTROL_TEST_KEY_10	(OMAP2_CONTROL_GENERAL + 0x00f0)
+#define OMAP343X_CONTROL_TEST_KEY_11	(OMAP2_CONTROL_GENERAL + 0x00f4)
+#define OMAP343X_CONTROL_TEST_KEY_12	(OMAP2_CONTROL_GENERAL + 0x00f8)
+#define OMAP343X_CONTROL_TEST_KEY_13	(OMAP2_CONTROL_GENERAL + 0x00fc)
+#define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
+#define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
 
+/*
+ * REVISIT: This list of registers is not comprehensive - there are more
+ * that should be added.
+ */
 
 /*
  * Control module register bit defines - these should eventually go into
- * their own regbits file
+ * their own regbits file.  Some of these will be complicated, depending
+ * on the device type (general-purpose, emulator, test, secure, bad, other)
+ * and the security mode (secure, non-secure, don't care)
  */
 /* CONTROL_DEVCONF0 bits */
-#define OMAP2_MCBSP2_CLKS_MASK		    (1 << 6)
-#define OMAP2_MCBSP1_CLKS_MASK		    (1 << 2)
+#define OMAP24XX_USBSTANDBYCTRL		(1 << 15)
+#define OMAP2_MCBSP2_CLKS_MASK		(1 << 6)
+#define OMAP2_MCBSP1_CLKS_MASK		(1 << 2)
 
 /* CONTROL_DEVCONF1 bits */
-#define OMAP2_MCBSP5_CLKS_MASK		    (1 << 4)
-#define OMAP2_MCBSP4_CLKS_MASK		    (1 << 2)
-#define OMAP2_MCBSP3_CLKS_MASK		    (1 << 0)
-
+#define OMAP2_MCBSP5_CLKS_MASK		(1 << 4) /* > 242x */
+#define OMAP2_MCBSP4_CLKS_MASK		(1 << 2) /* > 242x */
+#define OMAP2_MCBSP3_CLKS_MASK		(1 << 0) /* > 242x */
+
+/* CONTROL_STATUS bits */
+#define OMAP2_DEVICETYPE_MASK		(0x7 << 8)
+#define OMAP2_SYSBOOT_5_MASK		(1 << 5)
+#define OMAP2_SYSBOOT_4_MASK		(1 << 4)
+#define OMAP2_SYSBOOT_3_MASK		(1 << 3)
+#define OMAP2_SYSBOOT_2_MASK		(1 << 2)
+#define OMAP2_SYSBOOT_1_MASK		(1 << 1)
+#define OMAP2_SYSBOOT_0_MASK		(1 << 0)
 
 #endif /* __ASM_ARCH_CONTROL_H */
 
Index: linux-omap/arch/arm/mach-omap2/board-h4.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/board-h4.c	2007-11-27 17:37:30.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/board-h4.c	2007-11-27 18:17:12.000000000 -0700
@@ -272,7 +272,10 @@
 /* 2420 Sysboot setup (2430 is different) */
 static u32 get_sysboot_value(void)
 {
-	return (ctrl_read_reg(CONTROL_STATUS) & 0xFFF);
+	return (ctrl_read_reg(OMAP24XX_CONTROL_STATUS) &
+		(OMAP2_SYSBOOT_5_MASK | OMAP2_SYSBOOT_4_MASK |
+		 OMAP2_SYSBOOT_3_MASK | OMAP2_SYSBOOT_2_MASK |
+		 OMAP2_SYSBOOT_1_MASK | OMAP2_SYSBOOT_0_MASK));
 }
 
 /* FIXME: This function should be moved to some other file, gpmc.c? */
Index: linux-omap/arch/arm/mach-omap2/id.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/id.c	2007-11-27 17:37:30.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/id.c	2007-11-28 01:54:25.000000000 -0700
@@ -162,9 +162,23 @@
 	/* Embedding the ES revision info in type field */
 	system_rev = omap_ids[j].type;
 
-	ctrl_status = ctrl_read_reg(CONTROL_STATUS);
-	system_rev |= (ctrl_status & 0x3f);
-	system_rev |= (ctrl_status & 0x700);
+	/* Add in the device type and sys_boot fields (see above) */
+	if (cpu_is_omap24xx()) {
+		i = OMAP24XX_CONTROL_STATUS;
+	} else if (cpu_is_omap343x()) {
+		i = OMAP343X_CONTROL_STATUS;
+	} else {
+		printk(KERN_ERR "id: unknown CPU type\n");
+		BUG();
+	}
+	ctrl_status = ctrl_read_reg(i);
+	system_rev |= (ctrl_status & (OMAP2_SYSBOOT_5_MASK |
+				      OMAP2_SYSBOOT_4_MASK |
+				      OMAP2_SYSBOOT_3_MASK |
+				      OMAP2_SYSBOOT_2_MASK |
+				      OMAP2_SYSBOOT_1_MASK |
+				      OMAP2_SYSBOOT_0_MASK));
+	system_rev |= (ctrl_status & OMAP2_DEVICETYPE_MASK);
 
 	pr_info("OMAP%04x", system_rev >> 16);
 	if ((system_rev >> 8) & 0x0f)
Index: linux-omap/arch/arm/plat-omap/sram.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-27 17:37:30.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-27 18:17:12.000000000 -0700
@@ -49,7 +49,6 @@
 #define VA_READPERM0		IO_ADDRESS(0x68005050)
 #define VA_WRITEPERM0		IO_ADDRESS(0x68005058)
 #define GP_DEVICE		0x300
-#define TYPE_MASK		0x700
 
 #define ROUND_DOWN(value,boundary)	((value) & (~((boundary)-1)))
 
@@ -94,7 +93,8 @@
 
 #if defined(CONFIG_ARCH_OMAP242X)
 	if (cpu_is_omap242x())
-		type = ctrl_read_reg(CONTROL_STATUS) & TYPE_MASK;
+		type = (ctrl_read_reg(OMAP24XX_CONTROL_STATUS) &
+			OMAP2_DEVICETYPE_MASK);
 #endif
 
 	if (type == GP_DEVICE) {
Index: linux-omap/drivers/usb/gadget/omap_udc.c
===================================================================
--- linux-omap.orig/drivers/usb/gadget/omap_udc.c	2007-11-27 17:37:30.000000000 -0700
+++ linux-omap/drivers/usb/gadget/omap_udc.c	2007-11-27 18:17:12.000000000 -0700
@@ -52,6 +52,7 @@
 
 #include <asm/arch/dma.h>
 #include <asm/arch/usb.h>
+#include <asm/arch/control.h>
 
 #include "omap_udc.h"
 
@@ -2263,8 +2264,15 @@
 
 	tmp = OTG_REV_REG;
 	if (cpu_is_omap24xx()) {
+		/*
+		 * REVISIT: Not clear how this works on OMAP2.  trans
+		 * is ANDed to produce bits 7 and 8, which might make
+		 * sense for USB_TRANSCEIVER_CTRL_REG on OMAP1,
+		 * but with CONTROL_DEVCONF, these bits have something to
+		 * do with the frame adjustment counter and McBSP2.
+		 */
 		ctrl_name = "control_devconf";
-		trans = CONTROL_DEVCONF_REG;
+		trans = ctrl_read_reg(CONTROL_DEVCONF0);
 	} else {
 		ctrl_name = "tranceiver_ctrl";
 		trans = USB_TRANSCEIVER_CTRL_REG;
Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2007-11-26 23:29:19.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-11-28 01:34:17.000000000 -0700
@@ -922,7 +922,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF1),
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP2_MCBSP5_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -934,7 +934,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF0),
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 	.clksel_mask	= OMAP2_MCBSP1_CLKS_MASK,
 	.clksel		= mcbsp_15_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -1982,7 +1982,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF0),
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
 	.clksel_mask	= OMAP2_MCBSP2_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -1994,7 +1994,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF1),
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP2_MCBSP3_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2006,7 +2006,7 @@
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
-	.clksel_reg	= OMAP343X_CTRL_REGADDR(CONTROL_DEVCONF1),
+	.clksel_reg	= OMAP343X_CTRL_REGADDR(OMAP343X_CONTROL_DEVCONF1),
 	.clksel_mask	= OMAP2_MCBSP4_CLKS_MASK,
 	.clksel		= mcbsp_234_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
Index: linux-omap/arch/arm/plat-omap/devices.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/devices.c	2007-11-23 15:29:40.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/devices.c	2007-11-28 01:32:16.000000000 -0700
@@ -280,9 +280,9 @@
 			 * Module Input Clock selection
 			 */
 			if (cpu_is_omap24xx()) {
-				u32 v = ctrl_read_reg(CONTROL_DEVCONF0);
+				u32 v = ctrl_read_reg(OMAP2_CONTROL_DEVCONF0);
 				v |= (1 << 24); /* not used in 243x */
-				ctrl_write_reg(v, CONTROL_DEVCONF0);
+				ctrl_write_reg(v, OMAP2_CONTROL_DEVCONF0);
 			}
 		}
 #endif
Index: linux-omap/arch/arm/plat-omap/usb.c
===================================================================
--- linux-omap.orig/arch/arm/plat-omap/usb.c	2007-11-23 15:29:40.000000000 -0700
+++ linux-omap/arch/arm/plat-omap/usb.c	2007-11-28 01:31:16.000000000 -0700
@@ -116,36 +116,36 @@
 {
 	u32 r;
 
-	r = ctrl_read_reg(CONTROL_DEVCONF0);
+	r = ctrl_read_reg(OMAP2_CONTROL_DEVCONF0);
 	r &= ~USBTXWRMODEI(port, mask);
-	ctrl_write_reg(r, CONTROL_DEVCONF0);
+	ctrl_write_reg(r, OMAP2_CONTROL_DEVCONF0);
 }
 
 static void omap2_usb_devconf_set(u8 port, u32 mask)
 {
 	u32 r;
 
-	r = ctrl_read_reg(CONTROL_DEVCONF0);
+	r = ctrl_read_reg(OMAP2_CONTROL_DEVCONF0);
 	r |= USBTXWRMODEI(port, mask);
-	ctrl_write_reg(r, CONTROL_DEVCONF0);
+	ctrl_write_reg(r, OMAP2_CONTROL_DEVCONF0);
 }
 
 static void omap2_usb2_disable_5pinbitll(void)
 {
 	u32 r;
 
-	r = ctrl_read_reg(CONTROL_DEVCONF0);
+	r = ctrl_read_reg(OMAP2_CONTROL_DEVCONF0);
 	r &= ~(USBTXWRMODEI(2, USB_BIDIR_TLL) | USBT2TLL5PI);
-	ctrl_write_reg(r, CONTROL_DEVCONF0);
+	ctrl_write_reg(r, OMAP2_CONTROL_DEVCONF0);
 }
 
 static void omap2_usb2_enable_5pinunitll(void)
 {
 	u32 r;
 
-	r = ctrl_read_reg(CONTROL_DEVCONF0);
+	r = ctrl_read_reg(OMAP2_CONTROL_DEVCONF0);
 	r |= USBTXWRMODEI(2, USB_UNIDIR_TLL) | USBT2TLL5PI;
-	ctrl_write_reg(r, CONTROL_DEVCONF0);
+	ctrl_write_reg(r, OMAP2_CONTROL_DEVCONF0);
 }
 
 static u32 __init omap_usb0_init(unsigned nwires, unsigned is_device)
Index: linux-omap/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/pm.c	2007-11-23 15:29:40.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/pm.c	2007-11-28 01:55:17.000000000 -0700
@@ -414,8 +414,8 @@
 			  MPU_MOD, PM_PWSTCTRL);
 
 	/* Workaround to kill USB */
-	l = ctrl_read_reg(CONTROL_DEVCONF0) | 0x00008000;
-	ctrl_write_reg(l, CONTROL_DEVCONF0);
+	l = ctrl_read_reg(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
+	ctrl_write_reg(l, OMAP2_CONTROL_DEVCONF0);
 
 	omap2_gpio_prepare_for_retention();
 

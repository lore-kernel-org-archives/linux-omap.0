From: "Girish" <girishsg@ti.com>
Subject: [PATCH 1/2] CPU identification support for 3430
Date: Fri, 26 Oct 2007 20:41:56 +0530
Message-ID: <000c01c817e2$8ca991b0$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch add cpu identification support for 3430 and some code clean up.

Signed-off-by: Girish S G <girishsg@ti.com>

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 1435923..a4c15e6 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -22,11 +22,15 @@
 #elif defined(CONFIG_ARCH_OMAP2430)
 #define TAP_BASE	io_p2v(0x4900A000)
 #elif defined(CONFIG_ARCH_OMAP34XX)
-#define TAP_BASE	io_p2v(0x54004000)
+#define TAP_BASE	io_p2v(0x4830A000)
 #endif
 
 #define OMAP_TAP_IDCODE		0x0204
+#if defined(CONFIG_ARCH_OMAP34XX)
+#define OMAP_TAP_PROD_ID	0x0210
+#else
 #define OMAP_TAP_PROD_ID	0x0208
+#endif
 
 #define OMAP_TAP_DIE_ID_0	0x0218
 #define OMAP_TAP_DIE_ID_1	0x021C
@@ -54,15 +58,44 @@ static struct omap_id omap_ids[] __initdata = {
 	{ .hawkeye = 0xb5d9, .dev = 0x4, .type = 0x24220000 },
 	{ .hawkeye = 0xb5d9, .dev = 0x8, .type = 0x24230000 },
 	{ .hawkeye = 0xb68a, .dev = 0x0, .type = 0x24300000 },
+	{ .hawkeye = 0xb7ae, .dev = 0xf, .type = 0x34300000 },
+	{ .hawkeye = 0xb7ae, .dev = 0x0, .type = 0x34301000 },
 };
 
 static u32 __init read_tap_reg(int reg)
 {
-	return __raw_readl(TAP_BASE + reg);
+	unsigned int regval = 0;
+	u32 cpuid;
+
+	/* Reading the IDCODE register on 3430 ES1 results in a
+	 * data abort as the register is not exposed on the OCP
+	 * Hence reading the Cortex Rev
+	 */
+	cpuid = read_cpuid(CPUID_ID);
+
+	/* If the processor type is Cortex-A8 and the revision is 0x0
+	 * it means its Cortex r0p0 which is 3430 ES1
+	 */
+	if ((((cpuid >> 4) & 0xFFF) == 0xC08) && ((cpuid & 0xF) == 0x0)) {
+		switch (reg) {
+		case OMAP_TAP_IDCODE  : regval = 0x0B7AE02F; break;
+		/* Making DevType as 0xF in ES1 to differ from ES2 */
+		case OMAP_TAP_PROD_ID : regval = 0x000F00F0; break;
+		case OMAP_TAP_DIE_ID_0: regval = 0x01000000; break;
+		case OMAP_TAP_DIE_ID_1: regval = 0x1012d687; break;
+		case OMAP_TAP_DIE_ID_2:	regval = 0x00000000; break;
+		case OMAP_TAP_DIE_ID_3:	regval = 0x2d2c0000; break;
+		}
+	} else
+		regval = __raw_readl(TAP_BASE + reg);
+
+	return regval;
+
 }
 
 void __init omap2_check_revision(void)
 {
+	int ctrl_status = 0;
 	int i, j;
 	u32 idcode;
 	u32 prod_id;
@@ -114,23 +147,27 @@ void __init omap2_check_revision(void)
 				omap_ids[i].type >> 16);
 		j = i;
 	}
-	system_rev = omap_ids[j].type;
-
-	system_rev |= rev << 8;
 
-	/* REVISIT:
-	 * OMAP 3430 ES 1.0 does't populate IDCODE registers
-	 * Following lines have to be revisited for next version
+	/*
+	 * system_rev encoding is as follows
+	 * system_rev & 0xff000000 -> Omap Class (24xx/34xx)
+	 * system_rev & 0xfff00000 -> Omap Sub Class (242x/343x)
+	 * system_rev & 0xffff0000 -> Omap type (2420/2422/2423/2430/3430)
+	 * system_rev & 0x0000f000 -> Silicon revision (ES1, ES2 )
+	 * system_rev & 0x00000700 -> Device Type ( EMU/HS/GP/BAD )
+	 * system_rev & 0x0000003f -> sys_boot[0:5]
 	 */
+	/* Embedding the ES revision info in type field */
+	system_rev = omap_ids[j].type;
+
+	ctrl_status = omap_readl(OMAP2_CONTROL_STATUS);
+	system_rev |= (ctrl_status & 0x3f);
+	system_rev |= (ctrl_status & 0x700);
 
-#ifndef CONFIG_ARCH_OMAP3
-	system_rev |= 0x24;
-#else
-	system_rev |= 0x34;
-#endif
 	pr_info("OMAP%04x", system_rev >> 16);
 	if ((system_rev >> 8) & 0x0f)
-		printk("%x", (system_rev >> 8) & 0x0f);
+		printk("ES%x", (system_rev >> 12) & 0xf);
 	printk("\n");
+
 }
 
diff --git a/include/asm-arm/arch-omap/omap34xx.h
b/include/asm-arm/arch-omap/omap34xx.h
index 6bc7f8a..792ee09 100644
--- a/include/asm-arm/arch-omap/omap34xx.h
+++ b/include/asm-arm/arch-omap/omap34xx.h
@@ -71,6 +71,7 @@
 #define OMAP2_CTRL_BASE			OMAP3430_CTRL_BASE
 #define OMAP34XX_CONTROL_DEVCONF0	(L4_34XX_BASE + 0x2274)
 #define OMAP34XX_CONTROL_DEVCONF1	(L4_34XX_BASE + 0x22D8)
+#define OMAP2_CONTROL_STATUS		(OMAP2_CTRL_BASE + 0x2f0)
 
 #endif

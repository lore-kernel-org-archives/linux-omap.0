From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] omap3evm: Add board revision function
Date: Wed, 28 Oct 2009 17:08:45 +0530
Message-ID: <1256729925-28650-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37194 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751737AbZJ1Lis (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 07:38:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, srk@ti.com, Ajay Kumar Gupta <ajay.gupta@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Sanjeev Premi <premi@ti.com>

Added function to differentiate between the OMAP3EVM revisions. The
chip-id of the ethernet PHY is being used for this purpose.

Rev A to D : 0x01150000
Rev >= E   : 0x92200000

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c    |   33 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/board.h |   18 ++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b9b0f4c..0595ce8 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -48,9 +48,40 @@
 
 #define OMAP3EVM_ETHR_START	0x2c000000
 #define OMAP3EVM_ETHR_SIZE	1024
+#define OMAP3EVM_ETHR_ID_REV	0x50	
 #define OMAP3EVM_ETHR_GPIO_IRQ	176
 #define OMAP3EVM_SMC911X_CS	5
 
+static u8 omap3_evm_version;
+
+u8 get_omap3_evm_rev(void)
+{
+	return omap3_evm_version;
+}
+EXPORT_SYMBOL(get_omap3_evm_rev);
+
+static void __init omap3_evm_get_revision(void)
+{
+	void __iomem *ioaddr;
+	unsigned int smsc_id;
+
+	/* Ethernet PHY ID is stored at ID_REV register */
+	ioaddr = ioremap_nocache(OMAP3EVM_ETHR_START, SZ_1K);
+	smsc_id = readl(ioaddr + OMAP3EVM_ETHR_ID_REV) & 0xFFFF0000;
+	iounmap(ioaddr);
+
+	switch (smsc_id) {
+	/*SMSC9115 chipset*/
+	case 0x01150000:
+		omap3_evm_version = OMAP3EVM_BOARD_GEN_1;
+		break;
+	/*SMSC 9220 chipset*/
+	case 0x92200000:
+	default:
+		omap3_evm_version = OMAP3EVM_BOARD_GEN_2;
+	}
+}
+
 static struct resource omap3evm_smc911x_resources[] = {
 	[0] =	{
 		.start	= OMAP3EVM_ETHR_START,
@@ -357,6 +388,8 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 
 static void __init omap3_evm_init(void)
 {
+	omap3_evm_get_revision();
+
 	omap3_evm_i2c_init();
 
 	platform_add_devices(omap3_evm_devices, ARRAY_SIZE(omap3_evm_devices));
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-omap/include/plat/board.h
index c4fc69f..abb17b6 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -14,6 +14,18 @@
 
 #include <plat/gpio-switch.h>
 
+/*
+ * OMAP35x EVM revision
+ * Run time detection of EVM revision is done by reading Ethernet
+ * PHY ID -
+ *	GEN_1	= 0x01150000
+ *	GEN_2	= 0x92200000
+ */
+enum {
+	OMAP3EVM_BOARD_GEN_1 = 0,	/* EVM Rev between  A - D */
+	OMAP3EVM_BOARD_GEN_2,		/* EVM Rev >= Rev E */
+};
+
 /* Different peripheral ids */
 #define OMAP_TAG_CLOCK		0x4f01
 #define OMAP_TAG_LCD		0x4f05
@@ -157,4 +169,10 @@ extern int omap_board_config_size;
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
 
+/* OMAP3EVM revision */
+#if defined(CONFIG_MACH_OMAP3EVM)
+u8 get_omap3_evm_rev(void);
+#else
+#define get_omap3_evm_rev() (-EINVAL)
+#endif
 #endif
-- 
1.6.2.4


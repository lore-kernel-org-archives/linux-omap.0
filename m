From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/19] ARM: OMAP4: SAR: generate overwrite data based on SAR ROM contents
Date: Fri, 20 Apr 2012 12:33:40 +0300
Message-ID: <1334914432-26456-8-git-send-email-t-kristo@ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48144 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab2DTJef (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 05:34:35 -0400
In-Reply-To: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

omap_sar_overwrite() now uses offsets detected during init time from
the SAR ROM contents.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap-sar.c |  158 ++++++++++++++++++++++++++++------------
 1 files changed, 112 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-sar.c b/arch/arm/mach-omap2/omap-sar.c
index da4696a..0572e7b 100644
--- a/arch/arm/mach-omap2/omap-sar.c
+++ b/arch/arm/mach-omap2/omap-sar.c
@@ -38,7 +38,52 @@ struct sar_ram_entry {
 	u32 ram_addr;
 };
 
+struct sar_overwrite_entry {
+	u32 reg_addr;
+	u32 sar_offset;
+	bool valid;
+};
+
+enum {
+	MEMIF_CLKSTCTRL_IDX,
+	SHADOW_FREQ_CFG2_IDX,
+	SHADOW_FREQ_CFG1_IDX,
+	MEMIF_CLKSTCTRL_2_IDX,
+	HSUSBHOST_CLKCTRL_IDX,
+	HSUSBHOST_CLKCTRL_2_IDX,
+	OW_IDX_SIZE
+};
+
 static struct sar_ram_entry *sar_ram_layout[3];
+static struct sar_overwrite_entry *sar_overwrite_data;
+
+static struct sar_overwrite_entry omap4_sar_overwrite_data[OW_IDX_SIZE] = {
+	[MEMIF_CLKSTCTRL_IDX] = { .reg_addr = 0x4a009e0c },
+	[SHADOW_FREQ_CFG2_IDX] = { .reg_addr = 0x4a004e2c },
+	[SHADOW_FREQ_CFG1_IDX] = { .reg_addr = 0x4a004e30 },
+	[MEMIF_CLKSTCTRL_2_IDX] = { .reg_addr = 0x4a009e0c },
+	[HSUSBHOST_CLKCTRL_IDX] = { .reg_addr = 0x4a009e54 },
+	[HSUSBHOST_CLKCTRL_2_IDX] = { .reg_addr = 0x4a009e54 },
+};
+
+static void check_overwrite_data(u32 io_addr, u32 ram_addr, int size)
+{
+	int i;
+
+	while (size) {
+		for (i = 0; i < OW_IDX_SIZE; i++) {
+			if (sar_overwrite_data[i].reg_addr == io_addr &&
+			    !sar_overwrite_data[i].valid) {
+				sar_overwrite_data[i].sar_offset = ram_addr;
+				sar_overwrite_data[i].valid = true;
+				break;
+			}
+		}
+		size--;
+		io_addr += 4;
+		ram_addr += 4;
+	}
+}
 
 /*
  * omap_sar_save :
@@ -174,58 +219,76 @@ int omap_sar_save(void)
 void omap_sar_overwrite(void)
 {
 	u32 val = 0;
-	u32 usb_offset = 0x2ec;
-	u32 usb_offset2 = 0x91c;
+	u32 offset = 0;
+
+	if (sar_overwrite_data[MEMIF_CLKSTCTRL_IDX].valid)
+		__raw_writel(0x2, sar_ram_base +
+			sar_overwrite_data[MEMIF_CLKSTCTRL_IDX].sar_offset);
+
+	if (sar_overwrite_data[SHADOW_FREQ_CFG1_IDX].valid) {
+		offset = sar_overwrite_data[SHADOW_FREQ_CFG1_IDX].sar_offset;
+		val = __raw_readl(sar_ram_base + offset);
+		val |= 1 << OMAP4430_FREQ_UPDATE_SHIFT;
+		val &= ~OMAP4430_DLL_OVERRIDE_2_2_MASK;
+		__raw_writel(val, sar_ram_base + offset);
+	}
 
-	if (cpu_is_omap446x()) {
-		usb_offset = 0x2f4;
-		usb_offset2 = 0x920;
+	if (sar_overwrite_data[SHADOW_FREQ_CFG2_IDX].valid) {
+		offset = sar_overwrite_data[SHADOW_FREQ_CFG2_IDX].sar_offset;
+		val = __raw_readl(sar_ram_base + offset);
+		/*
+		 * FIXME: Implement FREQ UPDATE for L#/M5 before enabling
+		 * val |= 1 << OMAP4430_FREQ_UPDATE_SHIFT;
+		 */
+		__raw_writel(val, sar_ram_base + offset);
 	}
 
-	/* Overwriting Phase1 data to be restored */
-	/* CM2 MEMIF_CLKTRCTRL = SW_WKUP, before FREQ UPDATE */
-	__raw_writel(0x2, sar_ram_base + SAR_BANK1_OFFSET + 0xd0);
-	/* CM1 CM_SHADOW_FREQ_CONFIG2, Enable FREQ UPDATE */
-	val = __raw_readl(OMAP4430_CM_SHADOW_FREQ_CONFIG2);
-	/*
-	 * FIXME: Implement FREQ UPDATE for L#/M5 before enabling this
-	 * val |= 1 << OMAP4430_FREQ_UPDATE_SHIFT;
-	 */
-	__raw_writel(val, sar_ram_base + SAR_BANK1_OFFSET + 0x100);
-	/* CM1 CM_SHADOW_FREQ_CONFIG1, Enable FREQ UPDATE */
-	val = __raw_readl(OMAP4430_CM_SHADOW_FREQ_CONFIG1);
-	val |= 1 << OMAP4430_FREQ_UPDATE_SHIFT;
-	val &= ~OMAP4430_DLL_OVERRIDE_2_2_MASK;
-	__raw_writel(val, sar_ram_base + SAR_BANK1_OFFSET + 0x104);
-	/* CM2 MEMIF_CLKTRCTRL = HW_AUTO, after FREQ UPDATE */
-	__raw_writel(0x3, sar_ram_base + SAR_BANK1_OFFSET + 0x124);
-
-	/* Overwriting Phase2a data to be restored */
-	/* CM_L3INIT_USB_HOST_CLKCTRL: SAR_MODE = 1, MODULEMODE = 2 */
-	__raw_writel(0x00000012,
-		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset);
-	/* CM_L3INIT_USB_TLL_CLKCTRL: SAR_MODE = 1, MODULEMODE = 1 */
-	__raw_writel(0x00000011,
-		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset + 4);
-	/* CM2 CM_SDMA_STATICDEP : Enable static depedency for SAR modules */
-	__raw_writel(0x000090e8,
-		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset + 8);
-
-	/* Overwriting Phase2b data to be restored */
-	/* CM_L3INIT_USB_HOST_CLKCTRL: SAR_MODE = 0, MODULEMODE = 0 */
-	val = __raw_readl(OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL);
-	val &= (OMAP4430_CLKSEL_UTMI_P1_MASK | OMAP4430_CLKSEL_UTMI_P2_MASK);
-	__raw_writel(val, sar_ram_base + SAR_BANK1_OFFSET + usb_offset2);
-	/* CM_L3INIT_USB_TLL_CLKCTRL: SAR_MODE = 0, MODULEMODE = 0 */
-	__raw_writel(0x0000000,
-		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset2 + 4);
-	/* CM2 CM_SDMA_STATICDEP : Clear the static depedency */
-	__raw_writel(0x00000040,
-		     sar_ram_base + SAR_BANK1_OFFSET + usb_offset2 + 8);
+	if (sar_overwrite_data[MEMIF_CLKSTCTRL_2_IDX].valid)
+		__raw_writel(0x3, sar_ram_base +
+			sar_overwrite_data[MEMIF_CLKSTCTRL_2_IDX].sar_offset);
+
+	if (sar_overwrite_data[HSUSBHOST_CLKCTRL_IDX].valid) {
+		offset = sar_overwrite_data[HSUSBHOST_CLKCTRL_IDX].sar_offset;
+
+		/* Overwriting Phase2a data to be restored */
+		/* CM_L3INIT_USB_HOST_CLKCTRL: SAR_MODE = 1, MODULEMODE = 2 */
+		__raw_writel(OMAP4430_SAR_MODE_MASK | 0x2,
+			sar_ram_base + offset);
+		/* CM_L3INIT_USB_TLL_CLKCTRL: SAR_MODE = 1, MODULEMODE = 1 */
+		__raw_writel(OMAP4430_SAR_MODE_MASK | 0x1,
+			sar_ram_base + offset + 4);
+		/*
+		 * CM2 CM_SDMA_STATICDEP : Enable static depedency for
+		 * SAR modules
+		 */
+		__raw_writel(OMAP4430_L4WKUP_STATDEP_MASK |
+			     OMAP4430_L4CFG_STATDEP_MASK |
+			     OMAP4430_L3INIT_STATDEP_MASK |
+			     OMAP4430_L3_1_STATDEP_MASK |
+			     OMAP4430_L3_2_STATDEP_MASK |
+			     OMAP4430_ABE_STATDEP_MASK,
+			     sar_ram_base + offset + 8);
+	}
+
+	if (sar_overwrite_data[HSUSBHOST_CLKCTRL_2_IDX].valid) {
+		offset = sar_overwrite_data[HSUSBHOST_CLKCTRL_2_IDX].sar_offset;
+
+		/* Overwriting Phase2b data to be restored */
+		/* CM_L3INIT_USB_HOST_CLKCTRL: SAR_MODE = 0, MODULEMODE = 0 */
+		val = __raw_readl(OMAP4430_CM_L3INIT_USB_HOST_CLKCTRL);
+		val &= (OMAP4430_CLKSEL_UTMI_P1_MASK |
+			OMAP4430_CLKSEL_UTMI_P2_MASK);
+		__raw_writel(val, sar_ram_base + offset);
+		/* CM_L3INIT_USB_TLL_CLKCTRL: SAR_MODE = 0, MODULEMODE = 0 */
+		__raw_writel(0, sar_ram_base + offset + 4);
+		/* CM2 CM_SDMA_STATICDEP : Clear the static depedency */
+		__raw_writel(OMAP4430_L3_2_STATDEP_MASK,
+			     sar_ram_base + offset + 8);
+	}
 
 	/* readback to ensure data reaches to SAR RAM */
 	barrier();
-	val = __raw_readl(sar_ram_base + SAR_BANK1_OFFSET + usb_offset2 + 8);
+	val = __raw_readl(sar_ram_base + offset + 8);
 }
 
 void __iomem *omap4_get_sar_ram_base(void)
@@ -327,6 +390,8 @@ static int sar_layout_generate(void)
 				if (!set_sar_io_addr(entry[bank], io_addr)) {
 					entry[bank]->size = size;
 					entry[bank]->ram_addr = ram_addr;
+					check_overwrite_data(io_addr, ram_addr,
+						size);
 					entry[bank]++;
 				}
 			}
@@ -400,6 +465,7 @@ static int __init omap4_sar_ram_init(void)
 	BUG_ON(!sar_ram_base);
 
 	sar_modules = omap44xx_sar_modules;
+	sar_overwrite_data = omap4_sar_overwrite_data;
 
 	sar_ioremap_modules();
 
-- 
1.7.4.1


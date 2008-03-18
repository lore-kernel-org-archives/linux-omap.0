From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/17] ARM: OMAP2: Add new pin multiplexing configurations
Date: Tue, 18 Mar 2008 16:01:59 +0200
Message-ID: <1205848935-12078-2-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-03-18-160209
	<1205848935-12078-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1205848935-12078-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add new pin multiplexing configurations

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c       |   44 +++++++++++++++++++++++++++++++++++--
 include/asm-arm/arch-omap/mux.h |   45 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 71cff46..5cba3a2 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -79,7 +79,12 @@ MUX_CFG_24XX("AA12_242X_GPIO17",	0x0e9,	3,	0,	0,	1)
 MUX_CFG_24XX("AA8_242X_GPIO58",		0x0ea,	3,	0,	0,	1)
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,	1)
 MUX_CFG_24XX("W4__24XX_GPIO74",		0x0f2,	3,	0,	0,	1)
+MUX_CFG_24XX("N15_24XX_GPIO85",		0x103,	3,	0,	0,	1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,	1)
+MUX_CFG_24XX("P20_24XX_GPIO93",		0x10b,	3,	0,	0,	1)
+MUX_CFG_24XX("P18_24XX_GPIO95",		0x10d,	3,	0,	0,	1)
+MUX_CFG_24XX("M18_24XX_GPIO96",		0x10e,	3,	0,	0,	1)
+MUX_CFG_24XX("L14_24XX_GPIO97",		0x10f,	3,	0,	0,	1)
 MUX_CFG_24XX("J15_24XX_GPIO99",		0x113,	3,	1,	1,	1)
 MUX_CFG_24XX("V14_24XX_GPIO117",	0x128,	3,	1,	0,	1)
 MUX_CFG_24XX("P14_24XX_GPIO125",	0x140,	3,	1,	1,	1)
@@ -104,9 +109,6 @@ MUX_CFG_24XX("G4_242X_DMAREQ3",		0x073,	2,	0,	0,	1)
 MUX_CFG_24XX("D3_242X_DMAREQ4",		0x072,	2,	0,	0,	1)
 MUX_CFG_24XX("E3_242X_DMAREQ5",		0x071,	2,	0,	0,	1)
 
-/* TSC IRQ */
-MUX_CFG_24XX("P20_24XX_TSC_IRQ",	0x108,	0,	0,	0,	1)
-
 /* UART3 */
 MUX_CFG_24XX("K15_24XX_UART3_TX",	0x118,	0,	0,	0,	1)
 MUX_CFG_24XX("K14_24XX_UART3_RX",	0x119,	0,	0,	0,	1)
@@ -169,6 +171,42 @@ MUX_CFG_24XX("B3__24XX_KBR5",		0x30,	3,	1,	1,	1)
 MUX_CFG_24XX("AA4_24XX_KBC2",		0xe7,	3,	0,	0,	1)
 MUX_CFG_24XX("B13_24XX_KBC6",		0x110,	3,	0,	0,	1)
 
+/* 2430 USB */
+MUX_CFG_24XX("AD9_2430_USB0_PUEN",	0x133,	4,	0,	0,	1)
+MUX_CFG_24XX("Y11_2430_USB0_VP",	0x134,	4,	0,	0,	1)
+MUX_CFG_24XX("AD7_2430_USB0_VM",	0x135,	4,	0,	0,	1)
+MUX_CFG_24XX("AE7_2430_USB0_RCV",	0x136,	4,	0,	0,	1)
+MUX_CFG_24XX("AD4_2430_USB0_TXEN",	0x137,	4,	0,	0,	1)
+MUX_CFG_24XX("AF9_2430_USB0_SE0",	0x138,	4,	0,	0,	1)
+MUX_CFG_24XX("AE6_2430_USB0_DAT",	0x139,	4,	0,	0,	1)
+MUX_CFG_24XX("AD24_2430_USB1_SE0",	0x107,	2,	0,	0,	1)
+MUX_CFG_24XX("AB24_2430_USB1_RCV",	0x108,	2,	0,	0,	1)
+MUX_CFG_24XX("Y25_2430_USB1_TXEN",	0x109,	2,	0,	0,	1)
+MUX_CFG_24XX("AA26_2430_USB1_DAT",	0x10A,	2,	0,	0,	1)
+
+/* 2430 HS-USB */
+MUX_CFG_24XX("AD9_2430_USB0HS_DATA3",	0x133,	0,	0,	0,	1)
+MUX_CFG_24XX("Y11_2430_USB0HS_DATA4",	0x134,	0,	0,	0,	1)
+MUX_CFG_24XX("AD7_2430_USB0HS_DATA5",	0x135,	0,	0,	0,	1)
+MUX_CFG_24XX("AE7_2430_USB0HS_DATA6",	0x136,	0,	0,	0,	1)
+MUX_CFG_24XX("AD4_2430_USB0HS_DATA2",	0x137,	0,	0,	0,	1)
+MUX_CFG_24XX("AF9_2430_USB0HS_DATA0",	0x138,	0,	0,	0,	1)
+MUX_CFG_24XX("AE6_2430_USB0HS_DATA1",	0x139,	0,	0,	0,	1)
+MUX_CFG_24XX("AE8_2430_USB0HS_CLK",	0x13A,	0,	0,	0,	1)
+MUX_CFG_24XX("AD8_2430_USB0HS_DIR",	0x13B,	0,	0,	0,	1)
+MUX_CFG_24XX("AE5_2430_USB0HS_STP",	0x13c,	0,	1,	1,	1)
+MUX_CFG_24XX("AE9_2430_USB0HS_NXT",	0x13D,	0,	0,	0,	1)
+MUX_CFG_24XX("AC7_2430_USB0HS_DATA7",	0x13E,	0,	0,	0,	1)
+
+/* 2430 McBSP */
+MUX_CFG_24XX("AC10_2430_MCBSP2_FSX",	0x012E,	1,	0,	0,	1)
+MUX_CFG_24XX("AD16_2430_MCBSP2_CLX",	0x012F,	1,	0,	0,	1)
+MUX_CFG_24XX("AE13_2430_MCBSP2_DX",	0x0130,	1,	0,	0,	1)
+MUX_CFG_24XX("AD13_2430_MCBSP2_DR",	0x0131,	1,	0,	0,	1)
+MUX_CFG_24XX("AC10_2430_MCBSP2_FSX_OFF",0x012E,	0,	0,	0,	1)
+MUX_CFG_24XX("AD16_2430_MCBSP2_CLX_OFF",0x012F,	0,	0,	0,	1)
+MUX_CFG_24XX("AE13_2430_MCBSP2_DX_OFF",	0x0130,	0,	0,	0,	1)
+MUX_CFG_24XX("AD13_2430_MCBSP2_DR_OFF",	0x0131,	0,	0,	0,	1)
 };
 
 #ifdef CONFIG_ARCH_OMAP24XX
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index 0edc6ce..68dd936 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -469,7 +469,12 @@ enum omap24xx_index {
 	AA8_242X_GPIO58,
 	Y20_24XX_GPIO60,
 	W4__24XX_GPIO74,
+	N15_24XX_GPIO85,
 	M15_24XX_GPIO92,
+	P20_24XX_GPIO93,
+	P18_24XX_GPIO95,
+	M18_24XX_GPIO96,
+	L14_24XX_GPIO97,
 	J15_24XX_GPIO99,
 	V14_24XX_GPIO117,
 	P14_24XX_GPIO125,
@@ -494,8 +499,6 @@ enum omap24xx_index {
 	D3_242X_DMAREQ4,
 	E3_242X_DMAREQ5,
 
-	P20_24XX_TSC_IRQ,
-
 	/* UART3 */
 	K15_24XX_UART3_TX,
 	K14_24XX_UART3_RX,
@@ -557,6 +560,44 @@ enum omap24xx_index {
 	B3__24XX_KBR5,
 	AA4_24XX_KBC2,
 	B13_24XX_KBC6,
+
+	/* 2430 USB */
+	AD9_2430_USB0_PUEN,
+	Y11_2430_USB0_VP,
+	AD7_2430_USB0_VM,
+	AE7_2430_USB0_RCV,
+	AD4_2430_USB0_TXEN,
+	AF9_2430_USB0_SE0,
+	AE6_2430_USB0_DAT,
+	AD24_2430_USB1_SE0,
+	AB24_2430_USB1_RCV,
+	Y25_2430_USB1_TXEN,
+	AA26_2430_USB1_DAT,
+
+	/* 2430 HS-USB */
+	AD9_2430_USB0HS_DATA3,
+	Y11_2430_USB0HS_DATA4,
+	AD7_2430_USB0HS_DATA5,
+	AE7_2430_USB0HS_DATA6,
+	AD4_2430_USB0HS_DATA2,
+	AF9_2430_USB0HS_DATA0,
+	AE6_2430_USB0HS_DATA1,
+	AE8_2430_USB0HS_CLK,
+	AD8_2430_USB0HS_DIR,
+	AE5_2430_USB0HS_STP,
+	AE9_2430_USB0HS_NXT,
+	AC7_2430_USB0HS_DATA7,
+
+	/* 2430 McBSP */
+	AC10_2430_MCBSP2_FSX,
+	AD16_2430_MCBSP2_CLX,
+	AE13_2430_MCBSP2_DX,
+	AD13_2430_MCBSP2_DR,
+	AC10_2430_MCBSP2_FSX_OFF,
+	AD16_2430_MCBSP2_CLX_OFF,
+	AE13_2430_MCBSP2_DX_OFF,
+	AD13_2430_MCBSP2_DR_OFF,
+
 };
 
 struct omap_mux_cfg {
-- 
1.5.3.6


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

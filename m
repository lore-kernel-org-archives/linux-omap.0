From: "Choraria, Rohit" <rohitkc@ti.com>
Subject: [PATCH] ARM: OMAP: IRQ numbers updated for 24xx and 34xx
Date: Fri, 26 Oct 2007 18:01:46 +0530
Message-ID: <AC2D475575504148943F5EB0938951C4FC6F9C@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi,
This patch adds some of the missing IRQ entries for 24XX and 34XX and=20
reorders some of the entries.

Regards,
Rohit

Signed-off-by: Rohit Choraria (rohitkc@ti.com)
---
 include/asm-arm/arch-omap/irqs.h |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

Index: linux-omap-git/include/asm-arm/arch-omap/irqs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap-git.orig/include/asm-arm/arch-omap/irqs.h	2007-10-18 =
17:28:52.000000000 +0530
+++ linux-omap-git/include/asm-arm/arch-omap/irqs.h	2007-10-22 =
15:11:36.000000000 +0530
@@ -264,10 +264,15 @@
 #define INT_24XX_GPTIMER10	46
 #define INT_24XX_GPTIMER11	47
 #define INT_24XX_GPTIMER12	48
+#define INT_24XX_I2C1_IRQ	56
+#define INT_24XX_I2C2_IRQ	57
+#define INT_24XX_HDQ_IRQ	58
 #define INT_24XX_MCBSP1_IRQ_TX	59
 #define INT_24XX_MCBSP1_IRQ_RX	60
 #define INT_24XX_MCBSP2_IRQ_TX	62
 #define INT_24XX_MCBSP2_IRQ_RX	63
+#define INT_24XX_SPI1_IRQ	65
+#define INT_24XX_SPI2_IRQ	66
 #define INT_24XX_UART1_IRQ	72
 #define INT_24XX_UART2_IRQ	73
 #define INT_24XX_UART3_IRQ	74
@@ -278,18 +283,26 @@
 #define INT_24XX_USB_IRQ_HSOF	79
 #define INT_24XX_USB_IRQ_OTG	80
 #define INT_24XX_MMC_IRQ	83
+#define INT_24XX_MMC2_IRQ	86
+#define INT_24XX_SPI3_IRQ	91
=20
-#define	INT_243X_HS_USB_MC	92
-#define	INT_243X_HS_USB_DMA	93
-#define	INT_243X_CARKIT		94
+#define INT_243X_MCBSP2_IRQ	16
+#define INT_243X_MCBSP3_IRQ	17
+#define INT_243X_MCBSP4_IRQ	18
+#define INT_243X_MCBSP5_IRQ	19
+#define INT_243X_MCBSP1_IRQ	64
+#define INT_243X_HS_USB_MC	92
+#define INT_243X_HS_USB_DMA	93
+#define INT_243X_CARKIT_IRQ	94
=20
 #define INT_34XX_ST_MCBSP2_IRQ	4
-#define INT_34XX_ST_MCBSP3_IRQ	3
+#define INT_34XX_ST_MCBSP3_IRQ	5
 #define INT_34XX_SYS_NIRQ	7
 #define INT_34XX_MCBSP1_IRQ	16
 #define INT_34XX_MCBSP2_IRQ	17
 #define INT_34XX_MCBSP3_IRQ	22
 #define INT_34XX_MCBSP4_IRQ	23
+#define INT_34XX_CAM_IRQ	24
 #define INT_34XX_MCBSP5_IRQ	27
 #define INT_34XX_GPIO_BANK1	29
 #define INT_34XX_GPIO_BANK2	30
@@ -297,7 +310,15 @@
 #define INT_34XX_GPIO_BANK4	32
 #define INT_34XX_GPIO_BANK5	33
 #define INT_34XX_GPIO_BANK6	34
+#define INT_34XX_USIM_IRQ	35
 #define INT_34XX_WDT3_IRQ	36
+#define INT_34XX_SPI4_IRQ	48
+#define INT_34XX_I2C3_IRQ	61
+#define INT_34XX_PBIAS_IRQ	75
+#define INT_34XX_OHCI_IRQ	76
+#define INT_34XX_EHCI_IRQ	77
+#define INT_34XX_TLL_IRQ	78
+#define INT_34XX_MMC3_IRQ	94
 #define INT_34XX_GPT12_IRQ	95
=20
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730) and

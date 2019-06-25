From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH V3 06/15] ARM: imx: cleanup cppcheck shifting errors
Date: Tue, 25 Jun 2019 11:03:47 +0700
Message-ID: <20190625040356.27473-7-tranmanphong@gmail.com>
References: <20190624135105.15579-1-tranmanphong@gmail.com>
 <20190625040356.27473-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625040356.27473-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tranmanphong@gmail.com
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, alexander.sverdlin@gmail.com, allison@lohutok.net, andrew@lunn.ch, ast@kernel.org, bgolaszewski@baylibre.com, bpf@vger.kernel.org, daniel@iogearbox.net, daniel@zonque.org, dmg@turingmachine.org, festevam@gmail.com, gerg@uclinux.org, gregkh@linuxfoundation.org, gregory.clement@bootlin.com, haojian.zhuang@gmail.com, hsweeten@visionengravers.com, illusionist.neo@gmail.com, info@metux.net, jason@lakedaemon.net, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, kgene@kernel.org, krzk@kernel.org, kstewart@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux@armlinux.org.uk, liviu.dudau@arm.com, lkundrak@v3.sk
List-Id: linux-omap@vger.kernel.org

There is error from cppcheck tool
"Shifting signed 32-bit value by 31 bits is undefined behaviour errors"
change to use BIT() marco for improvement.

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-imx/iomux-mx3.h | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-imx/iomux-mx3.h b/arch/arm/mach-imx/iomux-mx3.h
index 99270a183d47..028b683866c3 100644
--- a/arch/arm/mach-imx/iomux-mx3.h
+++ b/arch/arm/mach-imx/iomux-mx3.h
@@ -59,38 +59,38 @@ enum iomux_pad_config {
  * various IOMUX general purpose functions
  */
 enum iomux_gp_func {
-	MUX_PGP_FIRI			= 1 << 0,
-	MUX_DDR_MODE			= 1 << 1,
-	MUX_PGP_CSPI_BB			= 1 << 2,
-	MUX_PGP_ATA_1			= 1 << 3,
-	MUX_PGP_ATA_2			= 1 << 4,
-	MUX_PGP_ATA_3			= 1 << 5,
-	MUX_PGP_ATA_4			= 1 << 6,
-	MUX_PGP_ATA_5			= 1 << 7,
-	MUX_PGP_ATA_6			= 1 << 8,
-	MUX_PGP_ATA_7			= 1 << 9,
-	MUX_PGP_ATA_8			= 1 << 10,
-	MUX_PGP_UH2			= 1 << 11,
-	MUX_SDCTL_CSD0_SEL		= 1 << 12,
-	MUX_SDCTL_CSD1_SEL		= 1 << 13,
-	MUX_CSPI1_UART3			= 1 << 14,
-	MUX_EXTDMAREQ2_MBX_SEL		= 1 << 15,
-	MUX_TAMPER_DETECT_EN		= 1 << 16,
-	MUX_PGP_USB_4WIRE		= 1 << 17,
-	MUX_PGP_USB_COMMON		= 1 << 18,
-	MUX_SDHC_MEMSTICK1		= 1 << 19,
-	MUX_SDHC_MEMSTICK2		= 1 << 20,
-	MUX_PGP_SPLL_BYP		= 1 << 21,
-	MUX_PGP_UPLL_BYP		= 1 << 22,
-	MUX_PGP_MSHC1_CLK_SEL		= 1 << 23,
-	MUX_PGP_MSHC2_CLK_SEL		= 1 << 24,
-	MUX_CSPI3_UART5_SEL		= 1 << 25,
-	MUX_PGP_ATA_9			= 1 << 26,
-	MUX_PGP_USB_SUSPEND		= 1 << 27,
-	MUX_PGP_USB_OTG_LOOPBACK	= 1 << 28,
-	MUX_PGP_USB_HS1_LOOPBACK	= 1 << 29,
-	MUX_PGP_USB_HS2_LOOPBACK	= 1 << 30,
-	MUX_CLKO_DDR_MODE		= 1 << 31,
+	MUX_PGP_FIRI			= BIT(0),
+	MUX_DDR_MODE			= BIT(1),
+	MUX_PGP_CSPI_BB			= BIT(2),
+	MUX_PGP_ATA_1			= BIT(3),
+	MUX_PGP_ATA_2			= BIT(4),
+	MUX_PGP_ATA_3			= BIT(5),
+	MUX_PGP_ATA_4			= BIT(6),
+	MUX_PGP_ATA_5			= BIT(7),
+	MUX_PGP_ATA_6			= BIT(8),
+	MUX_PGP_ATA_7			= BIT(9),
+	MUX_PGP_ATA_8			= BIT(10),
+	MUX_PGP_UH2			= BIT(11),
+	MUX_SDCTL_CSD0_SEL		= BIT(12),
+	MUX_SDCTL_CSD1_SEL		= BIT(13),
+	MUX_CSPI1_UART3			= BIT(14),
+	MUX_EXTDMAREQ2_MBX_SEL		= BIT(15),
+	MUX_TAMPER_DETECT_EN		= BIT(16),
+	MUX_PGP_USB_4WIRE		= BIT(17),
+	MUX_PGP_USB_COMMON		= BIT(18),
+	MUX_SDHC_MEMSTICK1		= BIT(19),
+	MUX_SDHC_MEMSTICK2		= BIT(20),
+	MUX_PGP_SPLL_BYP		= BIT(21),
+	MUX_PGP_UPLL_BYP		= BIT(22),
+	MUX_PGP_MSHC1_CLK_SEL		= BIT(23),
+	MUX_PGP_MSHC2_CLK_SEL		= BIT(24),
+	MUX_CSPI3_UART5_SEL		= BIT(25),
+	MUX_PGP_ATA_9			= BIT(26),
+	MUX_PGP_USB_SUSPEND		= BIT(27),
+	MUX_PGP_USB_OTG_LOOPBACK	= BIT(28),
+	MUX_PGP_USB_HS1_LOOPBACK	= BIT(29),
+	MUX_PGP_USB_HS2_LOOPBACK	= BIT(30),
+	MUX_CLKO_DDR_MODE		= BIT(31),
 };
 
 /*
-- 
2.11.0

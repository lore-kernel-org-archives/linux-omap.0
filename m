From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH 06/15] ARM: imx: cleanup cppcheck shifting errors
Date: Sun, 23 Jun 2019 22:13:04 +0700
Message-ID: <20190623151313.970-7-tranmanphong@gmail.com>
References: <20190623151313.970-1-tranmanphong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190623151313.970-1-tranmanphong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, kstewart@linuxfoundation.org, songliubraving@fb.com, andrew@lunn.ch, peterz@infradead.org, nsekhar@ti.com, ast@kernel.org, jolsa@redhat.com, netdev@vger.kernel.org, gerg@uclinux.org, lorenzo.pieralisi@arm.com, will@kernel.org, linux-samsung-soc@vger.kernel.org, daniel@iogearbox.net, tranmanphong@gmail.com, festevam@gmail.com, gregory.clement@bootlin.com, allison@lohutok.net, linux@armlinux.org.uk, krzk@kernel.org, haojian.zhuang@gmail.com, bgolaszewski@baylibre.com, tony@atomide.com, mingo@redhat.com, linux-imx@nxp.com, yhs@fb.com, sebastian.hesselbarth@gmail.com, illusionist.neo@gmail.com, jason@lakedaemon.net, liviu.dudau@arm.com, s.hauer@pengutronix.de, acme@kernel.org, lkundrak@v3.sk, robert.jarzmik@free.fr, dmg@turingmachine.org, swinslow@gmail.co
List-Id: linux-omap@vger.kernel.org

[arch/arm/mach-imx/iomux-mx3.h:93]: (error) Shifting signed 32-bit value
by 31 bits is undefined behaviour

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 arch/arm/mach-imx/iomux-mx3.h | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-imx/iomux-mx3.h b/arch/arm/mach-imx/iomux-mx3.h
index 99270a183d47..c30951dd110d 100644
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
+	MUX_PGP_FIRI			= 1U << 0,
+	MUX_DDR_MODE			= 1U << 1,
+	MUX_PGP_CSPI_BB			= 1U << 2,
+	MUX_PGP_ATA_1			= 1U << 3,
+	MUX_PGP_ATA_2			= 1U << 4,
+	MUX_PGP_ATA_3			= 1U << 5,
+	MUX_PGP_ATA_4			= 1U << 6,
+	MUX_PGP_ATA_5			= 1U << 7,
+	MUX_PGP_ATA_6			= 1U << 8,
+	MUX_PGP_ATA_7			= 1U << 9,
+	MUX_PGP_ATA_8			= 1U << 10,
+	MUX_PGP_UH2			= 1U << 11,
+	MUX_SDCTL_CSD0_SEL		= 1U << 12,
+	MUX_SDCTL_CSD1_SEL		= 1U << 13,
+	MUX_CSPI1_UART3			= 1U << 14,
+	MUX_EXTDMAREQ2_MBX_SEL		= 1U << 15,
+	MUX_TAMPER_DETECT_EN		= 1U << 16,
+	MUX_PGP_USB_4WIRE		= 1U << 17,
+	MUX_PGP_USB_COMMON		= 1U << 18,
+	MUX_SDHC_MEMSTICK1		= 1U << 19,
+	MUX_SDHC_MEMSTICK2		= 1U << 20,
+	MUX_PGP_SPLL_BYP		= 1U << 21,
+	MUX_PGP_UPLL_BYP		= 1U << 22,
+	MUX_PGP_MSHC1_CLK_SEL		= 1U << 23,
+	MUX_PGP_MSHC2_CLK_SEL		= 1U << 24,
+	MUX_CSPI3_UART5_SEL		= 1U << 25,
+	MUX_PGP_ATA_9			= 1U << 26,
+	MUX_PGP_USB_SUSPEND		= 1U << 27,
+	MUX_PGP_USB_OTG_LOOPBACK	= 1U << 28,
+	MUX_PGP_USB_HS1_LOOPBACK	= 1U << 29,
+	MUX_PGP_USB_HS2_LOOPBACK	= 1U << 30,
+	MUX_CLKO_DDR_MODE		= 1U << 31,
 };
 
 /*
-- 
2.11.0

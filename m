From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH 1/2] omap4: control: Add the CONTROL_SMART2IO_PADCONF_2 register definition
Date: Fri, 29 Jun 2012 12:11:04 +0300
Message-ID: <1340961065-26938-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57483 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab2F2JLI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 05:11:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, balbi@ti.com

This patch adds missing CONTROL_SMART2IO_PADCONF_2 register
definition

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 .../include/mach/ctrl_module_pad_core_44xx.h       |   45 ++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
index c88420d..d512ade 100644
--- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
+++ b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
@@ -46,6 +46,7 @@
 #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART3IO_PADCONF_2	0x05c0
 #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_USBB_HSIC		0x05c4
 #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SLIMBUS		0x05c8
+#define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_SMART2IO_PADCONF_2	0x05cc
 #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE		0x0600
 #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_0		0x0604
 #define OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_CAMERA_RX		0x0608
@@ -764,6 +765,50 @@
 #define OMAP4_HSI_DR0_LB_SHIFT					10
 #define OMAP4_HSI_DR0_LB_MASK					(1 << 10)
 
+/* CONTROL_SMART2IO_PADCONF_2 */
+#define OMAP4_DPM_DR1_DS_SHIFT					31
+#define OMAP4_DPM_DR1_DS_MASK					(1 << 31)
+#define OMAP4_DPM_DR2_DS_SHIFT					30
+#define OMAP4_DPM_DR2_DS_MASK					(1 << 30)
+#define OMAP4_DPM_DR3_DS_SHIFT					29
+#define OMAP4_DPM_DR3_DS_MASK					(1 << 29)
+#define OMAP4_GPIO_DR10_DS_SHIFT				28
+#define OMAP4_GPIO_DR10_DS_MASK					(1 << 28)
+#define OMAP4_HSI2_DR0_DS_SHIFT					27
+#define OMAP4_HSI2_DR0_DS_MASK					(1 << 27)
+#define OMAP4_HSI2_DR1_DS_SHIFT					26
+#define OMAP4_HSI2_DR1_DS_MASK					(1 << 26)
+#define OMAP4_HSI2_DR2_DS_SHIFT					25
+#define OMAP4_HSI2_DR2_DS_MASK					(1 << 25)
+#define OMAP4_SDMMC3_DR0_DS_SHIFT				24
+#define OMAP4_SDMMC3_DR0_DS_MASK				(1 << 24)
+#define OMAP4_SDMMC4_DR0_DS_SHIFT				23
+#define OMAP4_SDMMC4_DR0_DS_MASK				(1 << 23)
+#define OMAP4_SDMMC4_DR1_DS_SHIFT				22
+#define OMAP4_SDMMC4_DR1_DS_MASK				(1 << 22)
+#define OMAP4_SPI3_DR0_DS_SHIFT					21
+#define OMAP4_SPI3_DR0_DS_MASK					(1 << 21)
+#define OMAP4_SPI3_DR1_DS_SHIFT					20
+#define OMAP4_SPI3_DR1_DS_MASK					(1 << 20)
+#define OMAP4_UART3_DR2_DS_SHIFT				19
+#define OMAP4_UART3_DR2_DS_MASK					(1 << 19)
+#define OMAP4_UART3_DR3_DS_SHIFT				18
+#define OMAP4_UART3_DR3_DS_MASK					(1 << 18)
+#define OMAP4_UART3_DR4_DS_SHIFT				17
+#define OMAP4_UART3_DR4_DS_MASK					(1 << 17)
+#define OMAP4_UART3_DR5_DS_SHIFT				16
+#define OMAP4_UART3_DR5_DS_MASK					(1 << 16)
+#define OMAP4_USBA0_DR0_DS_SHIFT				15
+#define OMAP4_USBA0_DR0_DS_MASK					(1 << 15)
+#define OMAP4_USBA0_DR1_DS_SHIFT				14
+#define OMAP4_USBA0_DR1_DS_MASK					(1 << 14)
+#define OMAP4_USBA_DR2_DS_SHIFT					13
+#define OMAP4_USBA_DR2_DS_MASK					(1 << 13)
+#define OMAP4_USBB2_DR0_DS_SHIFT				12
+#define OMAP4_USBB2_DR0_DS_MASK					(1 << 12)
+#define OMAP4_USBB1_DR0_DS_SHIFT				11
+#define OMAP4_USBB1_DR0_DS_MASK					(1 << 11)
+
 /* CONTROL_USBB_HSIC */
 #define OMAP4_USBB2_DR1_SR_SHIFT				30
 #define OMAP4_USBB2_DR1_SR_MASK					(0x3 << 30)
-- 
1.7.1


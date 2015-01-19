From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 5/5] ARM: omap2plus_defconfig: Enable PCF857X and EXTCON_GPIO_USB
Date: Mon, 19 Jan 2015 19:52:22 +0200
Message-ID: <1421689942-10201-6-git-send-email-rogerq@ti.com>
References: <1421689942-10201-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421689942-10201-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Both are needed for USB cable type detection on dra7-evm.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c2c3a85..bc23b90 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -203,6 +203,7 @@ CONFIG_SPI_OMAP24XX=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_DEBUG_GPIO=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_PCF857X=y
 CONFIG_GPIO_TWL4030=y
 CONFIG_W1=y
 CONFIG_BATTERY_BQ27x00=m
@@ -326,6 +327,7 @@ CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
 CONFIG_EXTCON=y
+CONFIG_EXTCON_GPIO_USB=y
 CONFIG_EXTCON_PALMAS=y
 CONFIG_PWM=y
 CONFIG_PWM_TIECAP=y
-- 
2.1.0

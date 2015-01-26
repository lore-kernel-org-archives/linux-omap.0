From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 7/7] ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB
Date: Mon, 26 Jan 2015 14:15:32 +0200
Message-ID: <1422274532-9488-8-git-send-email-rogerq@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422274532-9488-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This driver is needed for USB cable type detection on dra7-evm,
dra72-evm and am57xx-beagle-x15.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 667d9d5..7e10e58 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -326,6 +326,7 @@ CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
 CONFIG_EXTCON=y
+CONFIG_EXTCON_USB_GPIO=m
 CONFIG_EXTCON_PALMAS=y
 CONFIG_PWM=y
 CONFIG_PWM_TIECAP=y
-- 
2.1.0

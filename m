From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 4/7] ARM: OMAP2+: omap2plus_defconfig: Add matrix-keypad support
Date: Wed, 2 Jan 2013 15:57:28 +0530
Message-ID: <1357122451-7577-5-git-send-email-anilkumar@ti.com>
References: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46327 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab3ABK1z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jan 2013 05:27:55 -0500
In-Reply-To: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

AM335X-EVM device have 3x2 matrix keypad, one has to manually enable
this support to use matrix keypad. So this patch enables matrix-keypad
driver as module in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index cd1cd51..f3e0e8c 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -111,6 +111,7 @@ CONFIG_USB_KC2190=y
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_MATRIX=m
 CONFIG_KEYBOARD_TWL4030=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
-- 
1.7.9.5


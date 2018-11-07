From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 2/3] ARM: OMAP1: ams-delta: Drop unused symbols from the board header
Date: Wed,  7 Nov 2018 21:17:45 +0100
Message-ID: <20181107201746.14705-3-jmkrzyszt@gmail.com>
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107201746.14705-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Those bitmap symbols defining pins of latch2 register, used with
read()/write() calls before the latch was converted to a GPIO device,
have been obsoleted by integer symbols defined inside the board file.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
index 06e4c64a47f8..2c3aff824cf0 100644
--- a/arch/arm/mach-omap1/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -28,10 +28,6 @@
 
 #if defined (CONFIG_MACH_AMS_DELTA)
 
-#define AMD_DELTA_LATCH2_SCARD_RSTIN	0x0400
-#define AMD_DELTA_LATCH2_SCARD_CMDVCC	0x0800
-#define AMS_DELTA_LATCH2_MODEM_CODEC	0x2000
-
 #define AMS_DELTA_GPIO_PIN_KEYBRD_DATA	0
 #define AMS_DELTA_GPIO_PIN_KEYBRD_CLK	1
 #define AMS_DELTA_GPIO_PIN_MODEM_IRQ	2
-- 
2.16.4

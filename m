From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARM: OMAP2+: Add WLAN modules and of_serial to
 omap2plus_defconfig
Date: Thu, 10 Oct 2013 16:04:43 -0700
Message-ID: <20131010230443.8152.73183.stgit@localhost>
References: <20131010230325.8152.27727.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20694 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751712Ab3JJXEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 19:04:45 -0400
In-Reply-To: <20131010230325.8152.27727.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Many boards have either WL12XX or MWIFIEX, so let's
build modules for those by default. This also makes it
easier to test WLAN on pandaboard to avoid regressions
like we had with the move to device tree based booting.

And at least the zoom boards need the of_serial for the
UARTs connected to the GPMC bus.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9549d6f..dad6816 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -118,6 +118,14 @@ CONFIG_LIBERTAS=m
 CONFIG_LIBERTAS_USB=m
 CONFIG_LIBERTAS_SDIO=m
 CONFIG_LIBERTAS_DEBUG=y
+CONFIG_WL_TI=y
+CONFIG_WL12XX=m
+CONFIG_WL18XX=m
+CONFIG_WLCORE_SPI=m
+CONFIG_WLCORE_SDIO=m
+CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
+CONFIG_MWIFIEX_USB=m
 CONFIG_INPUT_JOYDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
@@ -136,6 +144,7 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_OMAP=y
 CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_HW_RANDOM=y


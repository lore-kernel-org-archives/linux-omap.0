From: Christoph Egger <siccegge@cs.fau.de>
Subject: [PATCH 13/33] Replacing LEDS_OMAP_DEBUG with OMAP_DEBUG_LEDS
Date: Wed, 30 Jun 2010 17:58:07 +0200
Message-ID: <b1363abf63cf2e35450acae82765ba679f1979bc.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:39766 "EHLO
	faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754677Ab0F3P6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Jun 2010 11:58:09 -0400
Content-Disposition: inline
In-Reply-To: <cover.1277911345.git.siccegge@cs.fau.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.co>
Cc: vamos@i4.informatik.uni-erlangen.de

LEDS_OMAP_DEBUG doesn't exist in Kconfig, therefore replacing all
references for it with OMAP_DEBUG_LEDS from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/arm/plat-omap/Kconfig      |    2 +-
 arch/arm/plat-omap/debug-leds.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 78b49a6..a5337c8 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -51,7 +51,7 @@ config OMAP_DEBUG_DEVICES
 config OMAP_DEBUG_LEDS
 	bool
 	depends on OMAP_DEBUG_DEVICES
-	default y if LEDS || LEDS_OMAP_DEBUG
+	default y if LEDS
 
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"
diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 53fcef7..fc05b10 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -39,7 +39,7 @@ static struct h2p2_dbg_fpga __iomem	*fpga;
 static u16				led_state, hw_led_state;
 
 
-#ifdef	CONFIG_LEDS_OMAP_DEBUG
+#ifdef	CONFIG_OMAP_DEBUG_LEDS
 #define new_led_api()	1
 #else
 #define new_led_api()	0
-- 
1.7.0.4


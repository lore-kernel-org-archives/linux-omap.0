From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix compile dependency to LEDS_CLASS
Date: Tue, 28 Sep 2010 09:50:33 -0700
Message-ID: <20100928165032.GC3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49444 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849Ab0I1Quh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Sep 2010 12:50:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

If we LEDS_CLASS is not selected, we will get undefined reference
to `led_classdev_register'.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e39a417..a92cb49 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -33,7 +33,7 @@ config OMAP_DEBUG_DEVICES
 config OMAP_DEBUG_LEDS
 	bool
 	depends on OMAP_DEBUG_DEVICES
-	default y if LEDS
+	default y if LEDS_CLASS
 
 config OMAP_RESET_CLOCKS
 	bool "Reset unused clocks during boot"

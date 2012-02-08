From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 09/16] ARM: omap: preemptively fix section mismatch in
 omap4_sdp4430_wifi_mux_init()
Date: Wed, 08 Feb 2012 16:38:50 +0000
Message-ID: <E1RvAXi-0006HN-9X@rmk-PC.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34994 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2BHQiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 11:38:54 -0500
In-Reply-To: <20120208163546.GA15849@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

Found by review.

omap4_sdp4430_wifi_mux_init() is called by an __init marked function,
and only calls omap_mux_init_gpio() and omap_mux_init_signal() which
are both also an __init marked functions.

The only reason this doesn't issue a warning is because the compiler
inlines omap4_sdp4430_wifi_mux_init() into omap4_sdp4430_wifi_init().

So, lets add the __init annotation to ensure this remains safe should
the compiler choose not to inline.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/board-4430sdp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 39fba9d..49a5aab 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -841,7 +841,7 @@ static struct omap_board_mux board_mux[] __initdata = {
 #define board_mux	NULL
  #endif
 
-static void omap4_sdp4430_wifi_mux_init(void)
+static void __init omap4_sdp4430_wifi_mux_init(void)
 {
 	omap_mux_init_gpio(GPIO_WIFI_IRQ, OMAP_PIN_INPUT |
 				OMAP_PIN_OFF_WAKEUPENABLE);
-- 
1.7.4.4


From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: [PATCH] OMAP: EHCI: Wrong ehci init for 2430
Date: Mon, 28 Apr 2008 15:51:11 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560872F72C95A@dbde02.ent.ti.com>
References: <1209370114-17007-1-git-send-email-jarkko.nikula@nokia.com>
 <1209370114-17007-2-git-send-email-jarkko.nikula@nokia.com>
 <20080428094833.GA4357@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59342 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752618AbYD1KYr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 06:24:47 -0400
In-Reply-To: <20080428094833.GA4357@gandalf.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

OMAP2430 does not have USB EHCI controller.
EHCI core was introduced with OMAP3430 ES2.0 onwards.
The ehci_init() call has been wrongly introduced for OMAP2430, so removing it.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-2430sdp.c     2008-04-28 14:27:26.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-2430sdp.c  2008-04-28 15:05:34.000000000 +0530
@@ -36,7 +36,6 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/board.h>
 #include <asm/arch/usb-musb.h>
-#include <asm/arch/usb-ehci.h>
 #include <asm/arch/hsmmc.h>
 #include <asm/arch/common.h>
 #include <asm/arch/keypad.h>
@@ -394,7 +393,6 @@ static void __init omap_2430sdp_init(voi

        sdp2430_flash_init();
        usb_musb_init();
-       usb_ehci_init();

        spi_register_board_info(sdp2430_spi_board_info,
                                ARRAY_SIZE(sdp2430_spi_board_info));

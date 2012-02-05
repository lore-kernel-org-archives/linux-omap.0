From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] arm: omap3: cm-t35: fix section mismatch warning
Date: Sun,  5 Feb 2012 13:39:40 +0200
Message-ID: <1328441980-28892-1-git-send-email-grinberg@compulab.co.il>
References: <20120205012556.GG1426@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:40922
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753475Ab2BELkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Feb 2012 06:40:00 -0500
In-Reply-To: <20120205012556.GG1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

WARNING: arch/arm/mach-omap2/built-in.o(.text+0xeae8):
Section mismatch in reference from the function cm_t35_init_usbh()
to the (unknown reference) .init.data:(unknown)
The function cm_t35_init_usbh() references
the (unknown reference) __initdata (unknown).
This is often because cm_t35_init_usbh lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
Sorry about this one. I fixed similar problem for cm-t3517 a while ago,
but somehow missed cm-t35. Thanks for spotting.
Probably enabling the CONFIG_DEBUG_SECTION_MISMATCH in defconfigs
can raise people awareness for this.

 arch/arm/mach-omap2/board-cm-t35.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index d839c05..a8cedbe 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -436,7 +436,7 @@ static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
-static void cm_t35_init_usbh(void)
+static void  __init cm_t35_init_usbh(void)
 {
 	int err;
 
-- 
1.7.3.4


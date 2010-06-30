From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/16] omap: mux: Mux 2430 USB0HS_STP in board-2430.c
Date: Wed, 30 Jun 2010 15:40:12 +0300
Message-ID: <20100630124012.GE2822@atomide.com>
References: <20100630120226.2637.31198.stgit@baageli.muru.com>
 <20100630120723.2637.54397.stgit@baageli.muru.com>
 <20100630122811.GR3843@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gDGSpKKIBgtShtf+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50378 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455Ab0F3MkH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 08:40:07 -0400
Content-Disposition: inline
In-Reply-To: <20100630122811.GR3843@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, David Brownell <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Felipe Balbi <felipe.balbi@nokia.com> [100630 15:26]:
> hi,
> 
> On Wed, Jun 30, 2010 at 02:07:23PM +0200, ext Tony Lindgren wrote:
> >diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> >index e06d65e..5f04d3f 100644
> >--- a/drivers/usb/musb/omap2430.c
> >+++ b/drivers/usb/musb/omap2430.c
> >@@ -194,10 +194,6 @@ int __init musb_platform_init(struct musb *musb, void *board_data)
> >	u32 l;
> >	struct omap_musb_board_data *data = board_data;
> >
> >-#if defined(CONFIG_ARCH_OMAP2430)
> >-	omap_cfg_reg(AE5_2430_USB0HS_STP);
> >-#endif
> 
> there's a patch from Anand taking care of this hunk, could you send
> only the hunk on board-2430sdp.c ?
> 
> this part on omap2430.c will go on next merge window.

OK, updated patch below.

Regards,

Tony

--gDGSpKKIBgtShtf+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-2430-musb.patch"

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 30 Jun 2010 13:39:43 +0300
Subject: [PATCH] omap: mux: Mux 2430 USB0HS_STP in board-2430.c

Use new mux functions for that. There are no other known 2430 boards
that need this mux.

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 281aa13..71bf509 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -31,7 +31,6 @@
 #include <asm/mach/map.h>
 
 #include <mach/gpio.h>
-#include <plat/mux.h>
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
@@ -238,7 +237,10 @@ static void __init omap_2430sdp_init(void)
 	omap_serial_init();
 	omap2_hsmmc_init(mmc);
 	omap2_usbfs_init(&sdp2430_usb_config);
+
+	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
 	usb_musb_init(&musb_board_data);
+
 	board_smc91x_init();
 
 	/* Turn off secondary LCD backlight */

--gDGSpKKIBgtShtf+--

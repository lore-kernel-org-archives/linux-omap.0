From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [GIT PULL] OMAP DSS changes for .38 merge window
Date: Fri, 7 Jan 2011 22:52:17 +0900
Message-ID: <20110107135217.GA3760@linux-sh.org>
References: <1294404103.3968.56.camel@nubuntu> <20110107132541.GA31660@linux-sh.org> <1294407452.3968.81.camel@nubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:41880 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab1AGNyR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 08:54:17 -0500
Content-Disposition: inline
In-Reply-To: <1294407452.3968.81.camel@nubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Tony Lindgren <tony@atomide.com>

On Fri, Jan 07, 2011 at 03:37:32PM +0200, Tomi Valkeinen wrote:
> On Fri, 2011-01-07 at 22:25 +0900, ext Paul Mundt wrote:
> I guess it's not out-of-the-question to get driver changes in in early
> rcs, but I'd rather get everything pulled during the merge window. Also,
> some of the patches still out there touch OMAP's arch/ files, so they
> are not plain driver changes.
> 
As long as all the new and big stuff goes in for -rc1 it's certainly fine
to take care of the rest over the next few rc releases. Things do
invariably break when multiple trees are being merged, so it's to be
expected.

> > Looking at the change in question, it's just a correctness fix and
> > doesn't impact the API from the driver point of view, so at least there
> > won't be build damage if they're out of sync for a couple of days
> > (although it may trigger some nasty surprises for anyone unlucky enough
> > to bisect in the middle).
> > 
> > In any event, unless you absolutely need the change to be upstream first,
> > I'll plan to pull the rebase branch. If you need it there earlier we can
> > probably also just prod Andrew and get that one patch off earlier than
> > the rest of the -mm bits.
> 
> No, the fix is not needed urgently. The memblock fix is only important
> for some rare use cases, which I don't think anyone is currently using
> (allocating video memory from SDRAM at a predefined address).
> 
Hmm, I've just fast-forwarded to Linus's current tree and tried to pull
your rebase branch in, but it seems to have a board conflict with the
OMAP tree merge:

CONFLICT (delete/modify): arch/arm/mach-omap2/board-zoom2.c deleted in HEAD and modified in 122ffebf2191529153c079b457e38ca3829eac40. Version 122ffebf2191529153c079b457e38ca3829eac40 of arch/arm/mach-omap2/board-zoom2.c left in tree.

Additionally there's a board-zoom.c conflict that looks like this:

diff --cc arch/arm/mach-omap2/board-zoom.c
index e041c53,1523369..0000000
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@@ -118,29 -113,17 +118,36 @@@ static const struct ehci_hcd_omap_platf
  
  static void __init omap_zoom_init(void)
  {
 -	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 -	zoom_peripherals_init();
 +	if (machine_is_omap_zoom2()) {
 +		omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 +	} else if (machine_is_omap_zoom3()) {
 +		omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 +		omap_mux_init_gpio(ZOOM3_EHCI_RESET_GPIO, OMAP_PIN_OUTPUT);
 +		usb_ehci_init(&ehci_pdata);
 +	}
 +
  	board_nand_init(zoom_nand_partitions,
 -			 ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 +			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
  	zoom_debugboard_init();
++<<<<<<< HEAD:arch/arm/mach-omap2/board-zoom.c
 +	zoom_peripherals_init();
++=======
+ 	zoom_display_init();
+ 
+ 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
+ 	usb_ehci_init(&ehci_pdata);
++>>>>>>> 122ffebf2191529153c079b457e38ca3829eac40:arch/arm/mach-omap2/board-zoom3.c
  }
  
 +MACHINE_START(OMAP_ZOOM2, "OMAP Zoom2 board")
 +	.boot_params	= 0x80000100,
 +	.map_io		= omap3_map_io,
 +	.reserve	= omap_reserve,
 +	.init_irq	= omap_zoom_init_irq,
 +	.init_machine	= omap_zoom_init,
 +	.timer		= &omap_timer,
 +MACHINE_END
 +
  MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
  	.boot_params	= 0x80000100,
  	.map_io		= omap3_map_io,
* Unmerged path arch/arm/mach-omap2/board-zoom2.c

It looks like there has been some consolidation work based on the last commit,
but I'll leave it to you to decide how to handle.

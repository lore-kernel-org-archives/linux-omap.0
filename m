From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: convert to
 module_platform_driver"
Date: Fri, 3 Aug 2012 12:45:53 +0300
Message-ID: <20120803094553.GA731@harshnoise.musicnaut.iki.fi>
References: <1343948917-14760-1-git-send-email-aaro.koskinen@iki.fi>
 <CACxGe6scCYLpsEDGGwaXw_ijAk027w6Mk7D7FSOTZZdC6VkKSg@mail.gmail.com>
 <1343981127.2744.28.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:56231 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab2HCJp5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Aug 2012 05:45:57 -0400
Content-Disposition: inline
In-Reply-To: <1343981127.2744.28.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, balbi@ti.com

Hi,

On Fri, Aug 03, 2012 at 11:05:27AM +0300, Tomi Valkeinen wrote:
> On Thu, 2012-08-02 at 17:54 -0600, Grant Likely wrote:
> > On Thu, Aug 2, 2012 at 5:08 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > > This reverts commit 9fdca9dfe093c76fe1ac1a09888ba9679d46996a.
> > >
> > > Changing omap2_mcspi_init() from subsys_initcall to device_initcall broke
> > > the display initialization on N900 when all the drivers are compiled
> > > built-in. Display subsystem drivers need a certain initialization order
> > > and having all of them initialize with device_initcall seems to be too
> > > fragile. Without this revert the display init fails and the boot hangs
> > > with the following messages:
> > >
> > > [    1.260955] acx565akm spi1.2: invalid display ID
> > > [    1.265899] panel-acx565akm display0: acx_panel_probe panel detect error
> > > [    1.273071] omapdss CORE error: driver probe failed: -19
> > 
> > The dependencies are all messed up. The reverted commit is part of
> > fixing that and I don't really want to go backwards on it. How many
> > drivers are failing? Can you try modifying the failure path of those
> > drivers to return -EPROBE_DEFER and see if that helps?
> 
> The description of 9fdca9dfe093c76fe1ac1a09888ba9679d46996a seems to be
> overly positive: "this will delete a few lines of code, no functional
> changes".
> 
> But yes, the probe dependencies with omap's display are quite fragile.
> The probe order should be something like (from first to last):
> 
> - omapdss, i2c, spi, etc.

I looked more into this, and it seems this particular problem is related
to probe order within SPI (and a special case with chip selects). The
panel driver on N900 is spi1.2. It's listed in the board file before
spi1.0 (touch controller). When the panel driver is probed, SPI transfers
appear to work (no errors) but all returned data zero:

[    1.371704] omap2_mcspi omap2_mcspi.1: registered master spi1
[    1.378143] spi spi1.2: setup: speed 6000000, sample leading edge, clk normal
[    1.385864] spi spi1.2: setup mode 0, 8 bits/w, 6000000 Hz max --> 0
[    1.393005] acx565akm spi1.2: acx565akm_spi_probe
[    1.398345] panel-acx565akm display0: acx_panel_probe
[    1.416931] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.425415] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.433868] acx565akm spi1.2: LCD panel not enabled by bootloader (status 0x0000)
[    1.441894] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.450347] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.458801] acx565akm spi1.2: MIPI display ID: 000000
[    1.464202] acx565akm spi1.2: invalid display ID
[    1.469085] panel-acx565akm display0: acx_panel_probe panel detect error
[    1.476196] omapdss CORE error: driver probe failed: -19
[    1.482269] omap2_mcspi omap2_mcspi.1: registered child spi1.2
[    1.488525] spi spi1.0: setup: speed 6000000, sample leading edge, clk normal
[    1.496124] spi spi1.0: setup mode 0, 8 bits/w, 6000000 Hz max --> 0
[    1.503265] omap2_mcspi omap2_mcspi.1: registered child spi1.0

If I modify the board file so that child spi1.0 is registered before
spi1.2, then it starts to work properly:

[    1.371978] omap2_mcspi omap2_mcspi.1: registered master spi1
[    1.378417] spi spi1.0: setup: speed 6000000, sample leading edge, clk normal
[    1.386108] spi spi1.0: setup mode 0, 8 bits/w, 6000000 Hz max --> 0
[    1.393249] omap2_mcspi omap2_mcspi.1: registered child spi1.0
[    1.399505] spi spi1.2: setup: speed 6000000, sample leading edge, clk normal
[    1.407104] spi spi1.2: setup mode 0, 8 bits/w, 6000000 Hz max --> 0
[    1.414245] acx565akm spi1.2: acx565akm_spi_probe
[    1.419586] panel-acx565akm display0: acx_panel_probe
[    1.440429] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.448883] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.457305] acx565akm spi1.2: LCD panel enabled by bootloader (status 0x80730417)
[    1.465301] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.473724] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.482147] acx565akm spi1.2: MIPI display ID: 108a77
[    1.487548] acx565akm spi1.2: omapfb: acx565akm rev 8a LCD detected
[    1.494689] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.503112] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.511566] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.520019] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.528442] acx565akm spi1.2: acx565akm_bl_update_status
[    1.534149] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.542572] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.550964] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.559417] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.567840] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.576293] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.584716] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.593109] acx565akm spi1.2: setup: speed 6000000, sample trailing edge, clk inverted
[    1.601867] omap2_mcspi omap2_mcspi.1: registered child spi1.2

So an altenative hack to fix this is to modify the board file
(board-rx51-peripherals.c):

	 /* list all spi devices here */
	 enum {
	 	RX51_SPI_WL1251,
	-	RX51_SPI_MIPID,		/* LCD panel */
	 	RX51_SPI_TSC2005,	/* Touch Controller */
	+	RX51_SPI_MIPID,		/* LCD panel */
	 };

I guess the proper fix would be to modify SPI core so that it first does
spi_setup for all the children/chip selects, before calling any of the
probe functions of SPI devices? (Initializing the controller driver at
subsys_initcall is one way to accomplish this.)

A.

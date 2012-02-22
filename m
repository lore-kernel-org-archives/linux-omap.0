From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/16] OMAPDSS: old OMAPFB cleanup
Date: Wed, 22 Feb 2012 10:50:16 -0800
Message-ID: <20120222185016.GI18185@atomide.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
 <1329220343.1845.65.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34173 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798Ab2BVSuT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 13:50:19 -0500
Content-Disposition: inline
In-Reply-To: <1329220343.1845.65.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, archit@ti.com, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120214 03:21]:
> Hi Tony,
> 
> On Tue, 2012-01-24 at 12:00 +0200, Tomi Valkeinen wrote:
> > Now that all omap2+ boards have been changed to use the newer omapdss driver,
> > this patch series removes omap2+ support from the old omapfb driver
> > (drivers/video/omap), and thus makes it an omap1 dss/fb driver.
> > 
> > The use of SRAM for video ram had earlier been disabled by removing the SRAM
> > allocation (fee926bb0d399b1eaaf38f9f694bbf2747c4b8a2), and now this series also
> > removes the support from the omap fb drivers.
> > 
> > Also various cleanup patches allow us to remove remove OMAP_TAG_LCD and
> > OMAP_TAG_FBMEM.
> > 
> > All in all, the series removes quite a bit of unneeded code and cleans up the
> > links between the board files and the display drivers, and this should help
> > with device tree adaptation.

Great, looks good to me. I've acked the arch/arm/*omap*/* patches.
There may be some trivial merge conflicts with the includes with
my cleanup branch for the io.h changes.

> > Some of the patches affect the newer omapdss and omapfb drivers, but mostly the
> > patches deal with omap1. I have compile tested the series for both omap1 and
> > omap2, but I have only tested this on OMAP3 and OMAP4 boards, as I don't have
> > OMAP1/2 boards. I think N770's display won't work after these patches, but
> > other OMAP1 boards should be ok. To fix N770's display requires knowledge of
> > the hardware setup, which is currently passed from the bootloader.
> 
> Tony, do you have any feedback on this? I think the arch/arm changes are
> quite clean as such, but are you ok with (possibly) breaking N770's
> display? The other OMAP1 boards should, at least in theory, work as well
> as before.
> 
> For N770, the bootloader passes the reset GPIO number and number of
> datalines, and I have no idea what those are.

I think they should be:

conf->nreset_gpio = 13
conf->data_lines = 24

Regards,

Tony

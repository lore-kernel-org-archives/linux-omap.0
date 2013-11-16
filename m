From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
Date: Sat, 16 Nov 2013 07:45:07 -0800
Message-ID: <20131116154507.GL10317@atomide.com>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk>
 <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk>
 <20131116141853.GF10317@atomide.com>
 <5287908C.3040602@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63352 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab3KPPpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 10:45:12 -0500
Content-Disposition: inline
In-Reply-To: <5287908C.3040602@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131116 07:36]:
> Hi Tony,
> 
> On 11/16/2013 03:18 PM, Tony Lindgren wrote:
> > * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131116 05:25]:
> >> On Device Tree boot the VDDS_DSI regulator is not linked to
> >> the DPI device so omapfb driver probing fails with:
> >> 
> >> [    3.186035] OMAPFB: omapfb_probe
> >> [    3.190704] omapdss DPI error: can't get VDDS_DSI regulator
> >> [    3.196594] omapfb omapfb: failed to connect default display
> >> [    3.202667] omapfb omapfb: failed to init overlay connections
> >> [    3.208892] OMAPFB: free_resources
> >> [    3.212493] OMAPFB: free all fbmem
> >> [    3.216735] omapfb omapfb: failed to setup omapfb
> >> 
> >> As a workaround try to use the VPLL2 regulator from twl4030 in
> >> dpi_init_regulator() if getting the VDDS_DSI regulator fails.
> > 
> > Probably makes sens to fix this in the dpi.c, but this can also be set
> > in the .dts file. I just set up the following in the omap3-ldp.dts file:
> > 
> 
> Sorry is not clear to me if you agree that makes sense to do this fix on dpi.c
> or if you think this is a bad idea and prefer to do it in the DTS instead?
> 
> I'm asking to know if I have to send a follow up patch or not :)

Well let's see what Tomi prefers.

> > &vaux1 {
> > 	/* Needed for ads7846 */
> > 	regulator-name = "vcc";
> > };
> > 
> > &vpll2 {
> > 	/* Needed for DSS */
> > 	regulator-name = "vdds_dsi";
> > };

In the long we'll use regulator phandles anyways in the DSS related
nodes, so from that point of view fixing dpi.c makes sense.

Regards,

Tony

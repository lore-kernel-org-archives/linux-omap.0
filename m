From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 24/24] omap4: multi-omap: Allow build to work
Date: Wed, 17 Feb 2010 10:35:02 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF8277@dbde02.ent.ti.com>
References: <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-18-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-19-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-20-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-21-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-22-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-23-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-24-git-send-email-santosh.shilimkar@ti.com>
 <20100216185348.GO21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44212 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab0BQFFP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 00:05:15 -0500
In-Reply-To: <20100216185348.GO21755@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "paul@pwsan.com" <paul@pwsan.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, February 17, 2010 12:24 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; ben@fluff.org.uk; sameo@linux.intel.com; lrg@slimlogic.co.uk;
> paul@pwsan.com
> Subject: Re: [PATCH 24/24] omap4: multi-omap: Allow build to work
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [100216 07:55]:
> > The musb support is enable to omap3 platforms. For omap4 only board
> > support is available and the driver still isn't supported.
> > Because of this build with omap3_defconfig used for multi-omap
> > doesn't work on omap4430 sdp.
> >
> > This patch hacks the musb probe to keep the multi-omap build
> > working on omap4430 sdp
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  drivers/usb/musb/musb_core.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index bcce8e8..13b1c4a 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -2124,6 +2124,10 @@ static int __init musb_probe(struct platform_device *pdev)
> >  	struct resource	*iomem;
> >  	void __iomem	*base;
> >
> > +	/* FIXME: multi-omap build to work on omap4 */
> > +	if (cpu_is_omap44xx())
> > +		return 0;
> > +
> >  	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!iomem || irq == 0)
> >  		return -ENODEV;
> 
> Should the comment here be "FIXME: allow multi-omap to boot until
> musb is updated for omap4" instead?
yeah

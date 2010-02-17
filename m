From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 24/24] omap4: multi-omap: Allow build to work
Date: Wed, 17 Feb 2010 14:42:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03215B0CBD@dbde02.ent.ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-18-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-19-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-20-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-21-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-22-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-23-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-24-git-send-email-santosh.shilimkar@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80F0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42380 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934191Ab0BQJMU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 04:12:20 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80F0@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>"Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "paul@pwsan.com" <paul@pwsan.com>

Shilimkar, Santosh wrote:
> > From: Gadiyar, Anand
> > Shilimkar, Santosh wrote:
> > > The musb support is enable to omap3 platforms. For omap4 only board
> > > support is available and the driver still isn't supported.
> > > Because of this build with omap3_defconfig used for multi-omap
> > > doesn't work on omap4430 sdp.
> > >
> > > This patch hacks the musb probe to keep the multi-omap build
> > > working on omap4430 sdp
> > >
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > ---
> > >  drivers/usb/musb/musb_core.c |    4 ++++
> > >  1 files changed, 4 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > > index bcce8e8..13b1c4a 100644
> > > --- a/drivers/usb/musb/musb_core.c
> > > +++ b/drivers/usb/musb/musb_core.c
> > > @@ -2124,6 +2124,10 @@ static int __init musb_probe(struct platform_device *pdev)
> > >  	struct resource	*iomem;
> > >  	void __iomem	*base;
> > >
> > > +	/* FIXME: multi-omap build to work on omap4 */
> > > +	if (cpu_is_omap44xx())
> > > +		return 0;
> > > +
> > 
> > NAK. I'd prefer that we fix the driver issue correctly.
> > 
> > I would have expected the driver to at least load on OMAP4
> > even if it does not work. Could you please describe the
> > failure?
> > 
> The probe fails because the register bases aren't mapped 
> for omap4. This is because Tony has lined-up musb board support
> for omap4 but corresponding usb driver patches are not yet lined
> up.

I see the problem now - the platform support is lined up, but the
driver is not queued up yet.

This is easy to fix by removing the call to usb_musb_init from
the 4430sdp board. How about doing this?


- Anand

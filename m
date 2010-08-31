From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH 04/20] Create platform_driver for each DSS HW IP
Date: Tue, 31 Aug 2010 18:33:09 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703114AA766@dbde02.ent.ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	<1282579089-10487-2-git-send-email-svadivu@ti.com>
	<1282579089-10487-3-git-send-email-svadivu@ti.com>
	<1282579089-10487-4-git-send-email-svadivu@ti.com>
	<1282579089-10487-5-git-send-email-svadivu@ti.com>
 <877hjdszij.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44536 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab0HaNDV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 09:03:21 -0400
In-Reply-To: <877hjdszij.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, August 27, 2010 5:22 AM
> To: Guruswamy, Senthilvadivu
> Cc: linux-omap@vger.kernel.org; tomi.valkeinen@nokia.com; 
> paul@pwsan.com
> Subject: Re: [PATCH 04/20] Create platform_driver for each DSS HW IP
> 
> Guruswamy Senthilvadivu <svadivu@ti.com> writes:
> 
> > From: Senthilvadivu Guruswamy <svadivu@ti.com>
> >
> > Platform driver of DSS HW IP are to be registered in sequence before
> > the omapdss platform driver is registered.
> >
> > Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> > ---
> >  drivers/video/omap2/dss/core.c |  121 
> ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 121 insertions(+), 0 deletions(-)
> >
> >  
> > +/* DSS HW IP initialisation */
> > +static int omap_dsshw_probe(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int omap_dsshw_remove(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> 
> It's not customary to create dummy, empty functions in one patch and
> then fill them in later.  In this case, you create them here, 
> move them
> in PATCH 05/20, then fill them in later.
> 
> It would be easier to review if you created the platform_drivers when
> needed.
> 
> Anyways, I'm not crazy about this approach, but Tomi can decide.
> 
[Senthil]  As I mentioned in my TODO list, I will try to move all the probe/remove to
the corresponding driver files as directly in my next version.
> 
> > +/* DISPC HW IP initialisation */
> > +static int omap_dispchw_probe(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}

> 
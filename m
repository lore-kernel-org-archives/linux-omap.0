From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v1 11/16] OMAP3: hwmod DSS: RFBI Move init,exit to driver
Date: Fri, 8 Oct 2010 12:43:38 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94B363@dbde02.ent.ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
	<1286363699-9614-2-git-send-email-svadivu@ti.com>
	<1286363699-9614-3-git-send-email-svadivu@ti.com>
	<1286363699-9614-4-git-send-email-svadivu@ti.com>
	<1286363699-9614-5-git-send-email-svadivu@ti.com>
	<1286363699-9614-6-git-send-email-svadivu@ti.com>
	<1286363699-9614-7-git-send-email-svadivu@ti.com>
	<1286363699-9614-8-git-send-email-svadivu@ti.com>
	<1286363699-9614-9-git-send-email-svadivu@ti.com>
	<1286363699-9614-10-git-send-email-svadivu@ti.com>
	<1286363699-9614-11-git-send-email-svadivu@ti.com>
	<1286363699-9614-12-git-send-email-svadivu@ti.com>
 <20101007214722.16799b9a@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56221 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350Ab0JHHNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 03:13:51 -0400
In-Reply-To: <20101007214722.16799b9a@surf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
> Sent: Friday, October 08, 2010 1:17 AM
> To: Guruswamy, Senthilvadivu
> Cc: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com; paul@pwsan.com;
> Hiremath, Vaibhav; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v1 11/16] OMAP3: hwmod DSS: RFBI Move init,exit to
> driver
> 
> Hello Senthil,
> 
> On Wed,  6 Oct 2010 16:44:54 +0530
> Guruswamy Senthilvadivu <svadivu@ti.com> wrote:
> 
> > diff --git a/drivers/video/omap2/dss/rfbi.c
> b/drivers/video/omap2/dss/rfbi.c
> > index 23598ea..9bee39d 100644
> > --- a/drivers/video/omap2/dss/rfbi.c
> > +++ b/drivers/video/omap2/dss/rfbi.c
> > @@ -100,6 +100,7 @@ static int rfbi_convert_timings(struct rfbi_timings
> *t);
> >  static void rfbi_get_clk_info(u32 *clk_period, u32 *max_clk_div);
> >
> >  static struct {
> > +	struct platform_device *pdev;
> >  	void __iomem	*base;
> >
> >  	unsigned long	l4_khz;
> > @@ -142,11 +143,22 @@ static inline u32 rfbi_read_reg(const struct
> rfbi_reg idx)
> >  /* RFBI HW IP initialisation */
> >  static int omap_rfbihw_probe(struct platform_device *pdev)
> >  {
> > -	return 0;
> > +	int r;
> > +	rfbi.pdev = pdev;
> > +
> > +	r = rfbi_init();
> > +	if (r) {
> > +		DSSERR("Failed to initialize rfbi\n");
> > +		goto err_rfbi;
> > +	}
> > +
> > +err_rfbi:
> > +	return r;
> >  }
> >
> >  static int omap_rfbihw_remove(struct platform_device *pdev)
> >  {
> > +	rfbi_exit();
> >  	return 0;
> >  }
> >
> 
> Instead of having probe() and remove() functions that call the existing
> init() and exit(), why not making your driver look like most Linux
> drivers here, and directly do the initialization in probe() and the
> cleanup in remove() ?
> 
[Senthil] When I do existing code movement I don't change it one single patch just to make the review concentrate on the place of movement.  
I could submit additional patches to remove the extra function calls wherever required.
> Concerning the added pdev field to the rfbi structure, do you really it
> at this point ?
> 
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

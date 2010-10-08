From: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Subject: RE: [PATCH v1 13/16] OMAP3: hwmod DSS: VENC Move init,exit to driver
Date: Fri, 8 Oct 2010 12:39:41 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087034B94B35F@dbde02.ent.ti.com>
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
	<1286363699-9614-13-git-send-email-svadivu@ti.com>
	<1286363699-9614-14-git-send-email-svadivu@ti.com>
 <20101007215733.5ab1c091@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44629 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360Ab0JHHJz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 03:09:55 -0400
In-Reply-To: <20101007215733.5ab1c091@surf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
> Sent: Friday, October 08, 2010 1:28 AM
> To: Guruswamy, Senthilvadivu
> Cc: khilman@deeprootsystems.com; tomi.valkeinen@nokia.com; paul@pwsan.com;
> Hiremath, Vaibhav; linux-omap@vger.kernel.org
> Subject: Re: [PATCH v1 13/16] OMAP3: hwmod DSS: VENC Move init,exit to
> driver
> 
> Hello Senthil,
> 
> On Wed,  6 Oct 2010 16:44:56 +0530
> Guruswamy Senthilvadivu <svadivu@ti.com> wrote:
> 
> > diff --git a/drivers/video/omap2/dss/venc.c
> b/drivers/video/omap2/dss/venc.c
> > index ec17b28..3a121cb 100644
> > --- a/drivers/video/omap2/dss/venc.c
> > +++ b/drivers/video/omap2/dss/venc.c
> > @@ -87,26 +87,6 @@
> >  #define VENC_OUTPUT_TEST			0xC8
> >  #define VENC_DAC_B__DAC_C			0xC8
> >
> > -/* VENC HW IP initialisation */
> > -static int omap_venchw_probe(struct platform_device *pdev)
> > -{
> > -	return 0;
> > -}
> > -
> > -static int omap_venchw_remove(struct platform_device *pdev)
> > -{
> > -	return 0;
> > -}
> > -
> > -static struct platform_driver omap_venchw_driver = {
> > -	.probe          = omap_venchw_probe,
> > -	.remove         = omap_venchw_remove,
> > -	.driver         = {
> > -		.name   = "dss_venc",
> > -		.owner  = THIS_MODULE,
> > -	},
> > -};
> 
> Would be better in patch 7/16 to put this stuff at the correct place
> (bottom of the file) so it does not need to be moved here.
> 
[Senthil]  Taken.  Will do the movement in the first patch itself.
> > +/* VENC HW IP initialisation */
> > +static int omap_venchw_probe(struct platform_device *pdev)
> > +{
> > +	int r;
> > +	venc.pdev = pdev;
> > +
> > +	r = venc_init(pdev);
> > +	if (r) {
> > +		DSSERR("Failed to initialize venc\n");
> > +		goto err_venc;
> > +	}
> > +
> > +err_venc:
> > +	return r;
> > +}
> > +
> > +static int omap_venchw_remove(struct platform_device *pdev)
> > +{
> > +	venc_exit();
> > +	return 0;
> > +}
> 
> Same comment as before: include the code of venc_init() and venc_exit()
> directly in the ->probe() and ->remove() hooks respectively.
> 
> > +struct regulator *dss_get_vdda_dac(void)
> > +{
> > +	struct regulator *reg;
> > +
> > +	if (venc.vdda_dac_reg != NULL)
> > +		return venc.vdda_dac_reg;
> > +
> > +	reg = regulator_get(&venc.pdev->dev, "vdda_dac");
> > +	if (!IS_ERR(reg))
> > +		venc.vdda_dac_reg = reg;
> >
> > +	return reg;
> > +}
> 
> As far as I can see, this function is now only used in venc_init(),
> which is in the same file, so the function should be static, and the
> prototype removed from drivers/video/omap2/dss/core.h.
> 
> I'm also a bit skeptical about what this function does. It is called
> this way in venc_init():
> 
>   venc.vdda_dac_reg = dss_get_vdda_dac();
> 
> so it is dss_get_vdda_dac() responsability to set venc.vdda_dac_reg, or
> is it the caller responsability ?
> 
> Moreover, the logic in dss_get_vdda_dac() that tests whether
> venc.vdda_dac_reg is already initialized seems to indicate that this
> function could be called several times. However, I only see it called
> from venc_init(), which as far as I understand is called only once.
> 
[Senthil] when code was in core.c there were chances of it getting called more than once.  Now it is called only once as you see, so it could be made static.
> Isn't it possible to simplify this by removing the dss_get_vdda_dac()
> function and just doing:
> 
>   venc.vdda_dac_reg = regulator_get(&venc.pdev->dev, "vdda_dac");
> 
> in the venc_init() function (which should become the ->probe() method).
> 
> Thanks!
> 
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com

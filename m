From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 02/11] usb: musb: kill global and static for multi
 instance
Date: Wed, 25 Jul 2012 14:10:23 +0300
Message-ID: <20120725111023.GG16794@arwen.pp.htv.fi>
References: <1342698367-12978-1-git-send-email-ajay.gupta@ti.com>
 <1342698367-12978-3-git-send-email-ajay.gupta@ti.com>
 <20120725075014.GR3630@arwen.pp.htv.fi>
 <47CEF8C4B26E8C44B22B028A650E0EA93EAE56BD@DBDE01.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:42610 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756448Ab2GYLNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jul 2012 07:13:36 -0400
Received: by laai10 with SMTP id i10so789617laa.27
        for <linux-omap@vger.kernel.org>; Wed, 25 Jul 2012 04:13:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <47CEF8C4B26E8C44B22B028A650E0EA93EAE56BD@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "tony@atomide.com" <tony@atomide.com>


--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 25, 2012 at 10:34:49AM +0000, Gupta, Ajay Kumar wrote:
> Hi,
> >=20
> > On Thu, Jul 19, 2012 at 05:15:58PM +0530, Ajay Kumar Gupta wrote:
> > > Moved global variable "musb_debugfs_root" and static variable
> > > "old_state" to 'struct musb' to help support multi instance of musb
> > > controller as present on AM335x platform.
> > >
> > > Also removed the global variable "orig_dma_mask" and filled the
> > > dev->dma_mask with parent device's dma_mask.
> > >
> > > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > > ---
> > >  drivers/usb/musb/musb_core.c    |   16 +++-------------
> > >  drivers/usb/musb/musb_core.h    |    4 ++++
> > >  drivers/usb/musb/musb_debugfs.c |   14 ++++++++------
> > >  3 files changed, 15 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/drivers/usb/musb/musb_core.c
> > > b/drivers/usb/musb/musb_core.c index 3e09984..a5db4dd 100644
> > > --- a/drivers/usb/musb/musb_core.c
> > > +++ b/drivers/usb/musb/musb_core.c
> > > @@ -1802,10 +1802,9 @@ static const struct attribute_group
> > > musb_attr_group =3D {  static void musb_irq_work(struct work_struct
> > > *data)  {
> > >  	struct musb *musb =3D container_of(data, struct musb, irq_work);
> > > -	static int old_state;
> > >
> > > -	if (musb->xceiv->state !=3D old_state) {
> > > -		old_state =3D musb->xceiv->state;
> > > +	if (musb->xceiv->state !=3D musb->xceiv_old_state) {
> > > +		musb->xceiv_old_state =3D musb->xceiv->state;
> > >  		sysfs_notify(&musb->controller->kobj, NULL, "mode");
> > >  	}
> > >  }
> > > @@ -2115,11 +2114,6 @@ fail0:
> > >  /* all implementations (PCI bridge to FPGA, VLYNQ, etc) should just
> > >   * bridge to a platform device; this driver then suffices.
> > >   */
> > > -
> > > -#ifndef CONFIG_MUSB_PIO_ONLY
> > > -static u64	*orig_dma_mask;
> > > -#endif
> > > -
> > >  static int __devinit musb_probe(struct platform_device *pdev)  {
> > >  	struct device	*dev =3D &pdev->dev;
> > > @@ -2138,10 +2132,6 @@ static int __devinit musb_probe(struct
> > platform_device *pdev)
> > >  		return -ENOMEM;
> > >  	}
> > >
> > > -#ifndef CONFIG_MUSB_PIO_ONLY
> > > -	/* clobbered by use_dma=3Dn */
> > > -	orig_dma_mask =3D dev->dma_mask;
> > > -#endif
> > >  	status =3D musb_init_controller(dev, irq, base);
> > >  	if (status < 0)
> > >  		iounmap(base);
> > > @@ -2166,7 +2156,7 @@ static int __devexit musb_remove(struct
> > platform_device *pdev)
> > >  	iounmap(ctrl_base);
> > >  	device_init_wakeup(&pdev->dev, 0);
> > >  #ifndef CONFIG_MUSB_PIO_ONLY
> > > -	pdev->dev.dma_mask =3D orig_dma_mask;
> > > +	pdev->dev.dma_mask =3D (&dev->dev.parent)->dma_mask;
> >=20
> > are you sure ?? This should be:
> >=20
> > dev->parent.dma_mask;
>=20
> Actually both are fine and I used parent based on your recommendation
> in my earlier version of patch at
> http://marc.info/?l=3Dlinux-usb&m=3D134121391908734&w=3D2
>=20
> anyways I will change to :
> pdev->dev.dma_mask =3D dma_set_mask((&pdev->dev, DMA_BIT_MASK(64));

no Ajay, you misunderstood... I don't see how this patch would compile.

the variable named "dev" is already a pointer to a struct device, and
struct device doesn't have a "dev" field.

what I asked to do while doing that is:

dev_set_mask(dev, *dev->parent->dma_mask);

--=20
balbi

--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQD9QfAAoJEIaOsuA1yqRE3UUP/3c4HHItoiz5doVgnWytCdCz
M00iXKQk/M2BAvr2qKIZEkGnhWjKsy/UG91qZTS+ReJQrfvqNXIWCdrxrwkCGGSB
4w9RnwaugUJWzmzETEqRXV6nE19rFNF7VxDwK8Vgw1ph9G5pVgmS+jzT/LkNDavl
wcg5zcol5IWAT4rchtpnR8yN4U0kTloCaH/+FK7HwiZr8Mt+bDoBxmnfSsMmJ89v
ewz4GoMo65/PR9JjencqcjabVHWZnAmqht2jnMtSLEWeFbMSrpIwV0orpLmNxUnY
GjAwFnPjAPH1c36xtnWpiuRiZiT8MGXH5vrIK2nanXxUkLFfE+3mfw2nOSY6KNeU
G+Rsecl+0eHuvHeDpH27b21jtgHaLmGT9l2eHmYST9i3kd/uQqKtpr3swSv/kCHr
+BWLcuYZnnj468+GbjNAkj0YawWLI5y4BT/VM+biHSCn9XN4riQCSZXTB3IjAK5V
iIj0ZktS1GmBHGbnTK5oSoLuKUrWFia5nRyNRWChsbsYUVOaSyV9msVoq3UifoOR
uRL5MlGxMdQ4cpIuQ02zHtpFQIhk0B7EjlLnPGIA+VHlwsH6AsPX9O022tYF4/BD
MDwp/W2W5vPTUpGUjrYL5aFSiUhwO0LCY7JsxMuO+tvwRPSFQEHF9v+giYV7Gk5i
LOATssn4yo2Qs0KB3M5S
=10iL
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/6] usb: musb: Add support for ti81xx platform
Date: Tue, 6 Sep 2011 10:34:36 +0300
Message-ID: <20110906073435.GF19245@legolas.emea.dhcp.ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
 <1314357108-2279-7-git-send-email-ajay.gupta@ti.com>
 <20110826235226.GD4829@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404EC4CC87B@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:40660 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753237Ab1IFHel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 03:34:41 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404EC4CC87B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "B, Ravi" <ravibabu@ti.com>


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 06, 2011 at 12:30:15PM +0530, Gupta, Ajay Kumar wrote:
> > > diff --git a/drivers/usb/musb/musb_core.c
> > > b/drivers/usb/musb/musb_core.c index 20a2873..07f3faf 100644
> > > --- a/drivers/usb/musb/musb_core.c
> > > +++ b/drivers/usb/musb/musb_core.c
> > > @@ -1014,7 +1014,9 @@ static void musb_shutdown(struct
> > platform_device *pdev)
> > >  	|| defined(CONFIG_USB_MUSB_OMAP2PLUS)		\
> > >  	|| defined(CONFIG_USB_MUSB_OMAP2PLUS_MODULE)	\
> > >  	|| defined(CONFIG_USB_MUSB_AM35X)		\
> > > -	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)
> > > +	|| defined(CONFIG_USB_MUSB_AM35X_MODULE)	\
> > > +	|| defined(CONFIG_USB_MUSB_TI81XX)		\
> > > +	|| defined(CONFIG_USB_MUSB_TI81XX_MODULE)
> >=20
> > we really need to find a better way to handle this :-(
>=20
> We use to have 'fifo_mode' within 'struct musb_platform_ops' so shouldn't
> It be brought back to fix this?

no. I don't think that's a good idea. The best way would be for gadget
to tell us about all endpoints it will use in one go. Something like
usb_ep_request_array() (to match the gpio_request_array), with that, we
could allocate FIFO space based on how many endpoints will be used, in
fact.

But that's something for the future, for now the ifdef is the only way
:-(

--=20
balbi

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOZc0LAAoJEAv8Txj19kN1UXcH/0mHpyIBylmEnnuc/LL1c2VH
SLbGLe6rgduisvcFEMAaiAMGYQyHt+fVcyB4KmAyC0LL73EM7Nvby/cwDZeoi+O6
3CoH8YVzFMS6XZkQdj/f2/7zy94QDMRCZ8ppOP+MtsiDRS64jNNmQxb5Fy5boJRX
mJzz26BuuTbcpRIMVSG7b4kFiyZTNTIhAMj7qmVLdgHQFI5QAcU8mBFhfFyZBBcI
J0Yuu6thwpjgQadqI1GfH6TNRIAASp47GGdd2uiX0QP4cxeFKumhg1Uvs9ScBz/3
sEVJSfgPg8gA/zuRk5Vk4lhZbyf+W9FJ4w14UZWuupKqOG5KEoCKu73TzVdt53A=
=2gwq
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--

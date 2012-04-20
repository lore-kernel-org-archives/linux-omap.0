From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Fri, 20 Apr 2012 14:57:30 +0300
Message-ID: <20120420115728.GF12830@arwen.pp.htv.fi>
References: <4F901CCC.9000703@compulab.co.il>
 <Pine.LNX.4.44L0.1204191059581.2070-100000@iolanthe.rowland.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44130 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755604Ab2DTL6h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 07:58:37 -0400
Received: by lbbgm6 with SMTP id gm6so3251272lbb.41
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 04:58:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204191059581.2070-100000@iolanthe.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 11:01:16AM -0400, Alan Stern wrote:
> On Thu, 19 Apr 2012, Igor Grinberg wrote:
>=20
> > ping
> >=20
> > Alan, Felipe,
> > Can this go into 3.5?
>=20
> It's okay with me.
>=20
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Also fine from my side:

Acked-by: Felipe Balbi <balbi@ti.com>

> > The dependency patch has already reached Samuel's tree,
> > what would be the best way to apply this one?
> > Should I ask Samuel to apply this one also (after having your acks)
> > via his tree, to reduce possible merge failures/conflicts?
>=20
> Sure, go ahead.
>=20
> > On 03/27/12 16:08, Igor Grinberg wrote:
> > > When PHY reset pin is connected to a GPIO on external GPIO chip
> > > (e.g. I2C), we should not call the gpio_set_value() function, but
> > > gpio_set_value_cansleep().
> > >=20
> > > Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> > > ---
> > > This patch depends on the patch from Keshava [1]:
> > > ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
> > >=20
> > > [1] http://www.spinics.net/lists/linux-omap/msg66774.html
> > >=20
> > >  drivers/usb/host/ehci-omap.c |    4 ++--
> > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-oma=
p.c
> > > index 5c78f9e..26e9241 100644
> > > --- a/drivers/usb/host/ehci-omap.c
> > > +++ b/drivers/usb/host/ehci-omap.c
> > > @@ -258,10 +258,10 @@ static int ehci_hcd_omap_probe(struct platform_=
device *pdev)
> > >  		udelay(10);
> > > =20
> > >  		if (gpio_is_valid(pdata->reset_gpio_port[0]))
> > > -			gpio_set_value(pdata->reset_gpio_port[0], 1);
> > > +			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
> > > =20
> > >  		if (gpio_is_valid(pdata->reset_gpio_port[1]))
> > > -			gpio_set_value(pdata->reset_gpio_port[1], 1);
> > > +			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
> > >  	}
> > > =20
> > >  	return 0;
>=20

--=20
balbi

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPkU8oAAoJEIaOsuA1yqREIZAQALJDsPD4WhT5mKylfHntDl0W
ce8+Z98Kx4cUFNuHFBSzwC2geGzVC8phCcC/bhaKPZW/RyqC9pXFaXrJIjioUL1J
BUNv3hje+tw1Th44ME0b9BMIK2B2B7JXhwkc5OgB8uJZyiIjioI1wpSsCbc+rJpG
8NXbxv64bztTOTFKfeHMMZXae/9ycQ9+TCzPK+Cx6IQj9fAPJZzhXJVCz+eQMVAu
XjSKinI0Rhwo90cJN7KHcJIYULhd3zHvQjqMiFQq0Us5IcoIE+E2a2iBM+uOFZFd
Bwaq6W/4hm0JJTqaGRHem2mopRtwpXlE2FMZc0JtmzZFKzQI+BK73fzJoslHK5MZ
OgJH6bVZrcS7e5YprBNiXmFRXFWWELqpofCzKwORW5Ydki84NjRlDji9qsUvcAE/
CJh83fPfXuckzAhFHpa4hX7YGaoIQoWwpy1zbaj1p/TvDWRb70mLHpz1IGo9QWyI
FcUQXmzegRsIOxFAMd4CyCr1qhRahcwgEYtstnip33kyewW6tqVW6kXn7TrH0t8+
0K4pXCtYTdZyLJmNu5fjb0cNo1dZMpf2DyLiePK+m/x9pJtD9tqzrbUzOxCQKmaW
aTh5WhqK+tUiWg9BBS5mbFZXrf01ZVluNNqv5kqI9JOfQwlmBxq8DzY1kxlMTDne
qMCX/XLMqh2fRlSofxqo
=/EM5
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--

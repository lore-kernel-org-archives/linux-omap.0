From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/5] usb: musb: call musb_port_suspend from
 musb_bus_suspend
Date: Mon, 25 Nov 2013 14:01:21 -0600
Message-ID: <20131125200121.GE18046@saruman.home>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com>
 <1385408393-19707-3-git-send-email-zonque@gmail.com>
 <20131125194629.GA18046@saruman.home>
 <5293ABDE.4080404@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4B4+7MsODflw+h2f"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46599 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756685Ab3KYUCY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 15:02:24 -0500
Content-Disposition: inline
In-Reply-To: <5293ABDE.4080404@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, Greg KH <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>

--4B4+7MsODflw+h2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 25, 2013 at 08:58:22PM +0100, Daniel Mack wrote:
> On 11/25/2013 08:46 PM, Felipe Balbi wrote:
> > On Mon, Nov 25, 2013 at 08:39:50PM +0100, Daniel Mack wrote:
> >> Make musb_port_suspend() externally available, and call it when to host
> >> goes into suspend. This allows the core to go into suspend while a
> >> device is connected.
> >>
> >> Signed-off-by: Daniel Mack <zonque@gmail.com>
> >> ---
> >>  drivers/usb/musb/musb_host.c    | 2 ++
> >>  drivers/usb/musb/musb_host.h    | 2 ++
> >>  drivers/usb/musb/musb_virthub.c | 2 +-
> >>  3 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host=
=2Ec
> >> index 6582a20..81caf9f 100644
> >> --- a/drivers/usb/musb/musb_host.c
> >> +++ b/drivers/usb/musb/musb_host.c
> >> @@ -2433,6 +2433,8 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
> >>  	struct musb	*musb =3D hcd_to_musb(hcd);
> >>  	u8		devctl;
> >> =20
> >> +	musb_port_suspend(musb, true);
> >=20
> > have you considered the fact that when musb looses context it'll cause a
> > disconnect on the bus because soft_connect bit is lost ?
> >
> > What if you have a mounted file system on a pendrive ? Should we allow
> > suspend in that case ?
>=20
> Well, I would have expected that, but in fact, the opposite is true.
> With 3.12, mounting a filesystem on a USB media and accessing it after
> resume was exactly my test case, and it worked just fine with that patch.

so you had a mounted file system, suspend, resume, it was still mounted?
or did it reenumerate and you remounted it ?

Try to do the same with transfers in flight, it's likely to corrupt your
file system.

> In 3.13, something about the parition table reading seems to be broken
> currently, I'll have a closer look.

cool

--=20
balbi

--4B4+7MsODflw+h2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSk6yRAAoJEIaOsuA1yqRESyQP/1+qwmN70JwLHigxXK8aIXDu
xgwPFxR4OHSEGDAskyxwMqS/Cz8I2v7PRaVa6p4pL46sjcRGdgQnjmVAAe0Uxu8b
qPFY/LFOo6glnxnJMFL27uTHbtDxCSvkAT5wEgJL5SJNpRXI0pqvwnO5F4ZGyj76
0v2fSuWOIfMDTHpaSg9OzqqI2uOlRdN5wTr/9cvmY4zLi+F/Cnqxffy2HXktatpZ
gM+9fxa5eXUYeFgExnetusCzC7ZduZHc475iZANmsNC/flKn4b8G9H0L9VmBmk9b
leHuz29Sd7yx/+alW9HzkOevH4IpTf2Tbxwjo5oAzlloSNc47iyBdquf5ST1AKdY
zXIMI5gg+MRdSOum0PTD9Df6lK7tLwWixIR3893TLSp1ApTizo5IrIqF89+48TkI
uNrDJtEYkAfPqcOR7o/gfU2nNd4sA/kldN/Iij8gNtmGqogEtAqT+RWpzETRcw/u
+f2gPV0ZqrNTfsDx5a9zg/8V9CpmuyPELelmT/5VHeIrHTljL3jwILzJBRfnIGZw
Kqb50Pkef/cB+/fPWZ/DbJF2qZkxXFjz3qRAjJFaw7vof5nrcpeua/ZA4B0loDGN
g0H47ex3ySzZ6nVrtkPB+oZTsa2Pae8rJgN9yDY/L0GPvuEYdqA7dneG+gTVLAWU
unVRonOuCU4tnSYPxtnI
=EqvZ
-----END PGP SIGNATURE-----

--4B4+7MsODflw+h2f--

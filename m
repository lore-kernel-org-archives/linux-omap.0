From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 6/6] usb: musb: Add support for ti81xx platform
Date: Mon, 29 Aug 2011 11:37:59 +0300
Message-ID: <20110829083757.GD13925@legolas.emea.dhcp.ti.com>
References: <1314357108-2279-1-git-send-email-ajay.gupta@ti.com>
 <1314357108-2279-7-git-send-email-ajay.gupta@ti.com>
 <20110826235226.GD4829@legolas.emea.dhcp.ti.com>
 <19F8576C6E063C45BE387C64729E739404EC4CBA8E@dbde02.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739404EC4CBA8E-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "B, Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 29, 2011 at 11:01:54AM +0530, Gupta, Ajay Kumar wrote:
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
> How about passing the mode info from musb_config (musb->config->fifo_mode=
),
> same way as musb->config->fifo_cfg=20

not sure... Ideally we wouldn't really need those fifo tables, but I'm
still thinking how to properly do that.

> Infact I think, we can kill musb->config->fifo_cfg and have only
> musb->config->mode as in this way all the fifo tables will be at one
> place and should help in maintenance.

The idea of musb->config->fifo_cfg was to allow boards to pass their
optimal fifo table. If a certain product, knows it will only support
mass storage, why not letting them enable only those needed endpoints in
an optimized way (with double buffering, bulk combine/split, etc).

> > > diff --git a/drivers/usb/musb/ti81xx.c b/drivers/usb/musb/ti81xx.c
> > new
> > > file mode 100644 index 0000000..f95774e
> > > --- /dev/null
> > > +++ b/drivers/usb/musb/ti81xx.c
> >=20
> > I still think this should be part of am35x.c It really look like they
> > are very similar.
>=20
> Wrapper registers are different but I will see on this and provide you de=
tails
> On how the merged file would look like. I am afraid that we may have to u=
se
> Either #ifdef or cpu_is_xxx().

we can use platform_device_id to cope with the differences :-) See how
I'm using it on dwc3 driver (Greg's usb-next branch).

--=20
balbi

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOW0/lAAoJEAv8Txj19kN13VEIAIyf/ZDpYyWSwLIfn+ONdpn/
dpgRvdpB3vYx3bFCjAxBQImKU9+K4U0rrrQ2zNn0pafRDbEjLQGAe+smV8gyFlN9
W/IYrv6JPwEAhb0Ty/o+6/6S9f6xK0jZGpnWG+ZMcoRBAggD7YmArNDB137q3lx7
4JMnsnaCKze0PfUv8llsT4uIFIiFXzHJhHMfyiTne7RrUjLfInn1VmKLYscxeWdk
67yWeW2jc2hpOxFg7s5lFkKlUafE8BBqr2vVT9QyYazfAHqs13UEorYtn/q5yoJv
SF9mFktPR00Qh8IVvbHrxwi3Kkbdhq/SWefFBbgPZ34Sjpn0VjrDEXVWkyhsR8Y=
=edql
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

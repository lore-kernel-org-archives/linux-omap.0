From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 04/16] mfd: omap-usb-tll: Move port clock handling out of
 runtime ops
Date: Wed, 21 Nov 2012 16:07:00 +0200
Message-ID: <20121121140700.GS10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-5-git-send-email-rogerq@ti.com>
 <20121121120408.GF10216@arwen.pp.htv.fi>
 <50ACCCFA.6060605@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h/77pM/XNBmEJr8g"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50ACCCFA.6060605-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--h/77pM/XNBmEJr8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 21, 2012 at 02:45:46PM +0200, Roger Quadros wrote:
> >>  	spin_unlock_irqrestore(&tll->lock, flags);
> >> =20
> >> -	return 0;
> >> +	return i;
> >>  }
> >> +EXPORT_SYMBOL_GPL(omap_tll_enable);
> >> =20
> >> -static int usbtll_runtime_suspend(struct device *dev)
> >> +int omap_tll_disable(void)
> >=20
> > why ?? Why are you actually dropping runtime PM from this driver ? have
> > you tested PM transitions after applying this patch ?
> >=20
>=20
> I'm not dropping runtime PM as such. Just separating enabling of channel
> clocks from runtime PM (read enabling hwmod). The only user for this
> driver is omap-usb-host.c via the omap_tll_enable/disable() calls.
>=20
> These calls still call pm_runtime_get/put() to enable the TLL hwmod.
>=20
> I have tested PM transitions on bus suspend/resume and modprobe/rmmod.
> They still work fine.

weird, I didn't see any dev_pm_ops being re-added to your
platform_driver structure :-s

On your original patch I see this:

-static const struct dev_pm_ops usbtllomap_dev_pm_ops =3D {
-	SET_RUNTIME_PM_OPS(usbtll_runtime_suspend,
-			   usbtll_runtime_resume,
-			   NULL)
-};
-
-static struct platform_driver usbtll_omap_driver =3D {
-	.driver =3D {
-		.name		=3D (char *)usbtll_driver_name,
-		.owner		=3D THIS_MODULE,
-		.pm		=3D &usbtllomap_dev_pm_ops,
-	},
-	.probe		=3D usbtll_omap_probe,
-	.remove		=3D __devexit_p(usbtll_omap_remove),
-};

but there is never anythying re-adding that dev_pm_ops, so runtime pm
callbacks are literally dropped from this driver. If that's still fine,
please make it clear on commit log.

--=20
balbi

--h/77pM/XNBmEJr8g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrOAEAAoJEIaOsuA1yqREEKUQAI4/9frgL+fpI8R38XpMkdJb
F+NaiVRI5JO3dYmOITVoK/uX+Zs0GQhjMemiwJU5NaCkCnlQGUIj/D4zTx0+KE1E
LkjMSJid9j54v30nbfC29/tzkpTEh6KdUHajDJB/Y/H9K3viGmkoCOWimGWweNAQ
LmpgXRCGg1J1U7kWQwe7zVB23dS/oNWBqr2ivhLcGD7eoVWZLZQ6DEkDbC1m8WdL
an6bNRP3UpmKAfslvr1npw8dNX1uAkMnFZmprfehG49X7Z2sOG9xt7PXpo/UdAdi
yp1vPLNYe4vP5dekoQeZmYcapjym46fNQXXv3VmdyggClBTpIOln0HeevLL9Ka3E
gVmaUAE5KakgVx6qUHbSdeKZpWId+zQMis4Emf2ngcbMzRkZYc/6sSARdsOtRyfX
Seear+ZLiKH2YLrgDSppoFPPEE4eCRmGdwYX97KibrfENRU2FKMJ+0AMFPLty3gr
AS9YvyrJ9U2xaAPeS1BKxwxWZ/YEnXSaDUzpLFXfaC8YMXbyXlNE2iDUdXLYeUgR
m98htArr57BhZggHGcT6Nb1ayKl2r4pxZbscnarFPARbhcgGWtDcTWUu0m2l9NIS
iCETYkXmJI8VDJNq07FqdqZfwwiwkBNB3CoSCCe0Ll3B9NijxG35Q726QIwri7qw
9lWohD3e5XrzGcDWtxc7
=eM2e
-----END PGP SIGNATURE-----

--h/77pM/XNBmEJr8g--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

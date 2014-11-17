From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Mon, 17 Nov 2014 11:09:45 +0100
Message-ID: <201411171109.47795@pali>
References: <20141116075928.GA9763@amd> <201411170943.20810@pali> <20141117100519.GA4353@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1476038.VxUQSkjrrd";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141117100519.GA4353@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart1476038.VxUQSkjrrd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 17 November 2014 11:05:19 Pavel Machek wrote:
> Hi!
>=20
> On Mon 2014-11-17 09:43:19, Pali Roh=C3=A1r wrote:
> > On Sunday 16 November 2014 08:59:28 Pavel Machek wrote:
> > > For device tree people: Yes, I know I'll have to create
> > > file in documentation, but does the binding below look
> > > acceptable?
> > >=20
> > > I'll clean up driver code a bit more, remove the printks.
> > > Anything else obviously wrong?
> >=20
> > I think that this patch is probably not good and specially
> > not for n900. adp1653 should be registered throw omap3 isp
> > camera subsystem which does not have DT support yet.
>=20
> Can you explain?
>=20
> adp1653 is independend device on i2c bus, and we have kernel
> driver for it (unlike rest of n900 camera system). Just now
> it is unusable due to lack of DT binding. It has two
> functions, LED light and a camera flash; yes, the second one
> should be integrated to the rest of camera system, but that
> is not yet merged. That should not prevent us from merging DT
> support for the flash, so that this part can be
> tested/maintained.
>=20

Ok. When ISP camera subsystem has DT support somebody will modify=20
n900 DT to add camera flash from adp1653 to ISP... I believe it=20
will not be hard.

> > See n900 legacy board camera code in file
> > board-rx51-camera.c.
>=20
> I have seen that.
> 									Pavel

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart1476038.VxUQSkjrrd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRpyWsACgkQi/DJPQPkQ1Jy6QCglBKZqhyJBNS8eLewXZ7URYoB
2bwAoMfx6J2TFeyK/vaZlkPvXdihCxKe
=IbyL
-----END PGP SIGNATURE-----

--nextPart1476038.VxUQSkjrrd--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

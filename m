From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Mon, 17 Nov 2014 09:43:19 +0100
Message-ID: <201411170943.20810@pali>
References: <20141116075928.GA9763@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1847905.6cyh1QvJQ8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141116075928.GA9763@amd>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, sre-GFxCN5SEZAc@public.gmane.org, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, freemangordon-uiMcrn6V0Vs@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sakari.ailus-X3B1VOXEql0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--nextPart1847905.6cyh1QvJQ8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 16 November 2014 08:59:28 Pavel Machek wrote:
> For device tree people: Yes, I know I'll have to create file
> in documentation, but does the binding below look acceptable?
>=20
> I'll clean up driver code a bit more, remove the printks.
> Anything else obviously wrong?
>=20
> Signed-off-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
>=20
> Thanks,
> 								Pavel
>=20
>=20

Hello,

I think that this patch is probably not good and specially not=20
for n900. adp1653 should be registered throw omap3 isp camera=20
subsystem which does not have DT support yet.

See n900 legacy board camera code in file board-rx51-camera.c.

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--nextPart1847905.6cyh1QvJQ8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRptSgACgkQi/DJPQPkQ1Jp/gCcDXvCk21znfd1oIRrJyc1nuQm
Aq0Ani3PDwgQk4b7tvcNNpAAy7HkvB6o
=b1Is
-----END PGP SIGNATURE-----

--nextPart1847905.6cyh1QvJQ8--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] I2C: OMAP: remove dev->idle, use usage counting
 provided by runtime PM
Date: Thu, 4 Aug 2011 18:09:51 +0300
Message-ID: <20110804150951.GU17540@legolas.emea.dhcp.ti.com>
References: <1312394960-21689-1-git-send-email-khilman@ti.com>
 <1312394960-21689-3-git-send-email-khilman@ti.com>
 <20110803223604.GB4036@legolas.emea.dhcp.ti.com>
 <87ipqd449a.fsf@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QILrdhYozogw5Vly"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87ipqd449a.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--QILrdhYozogw5Vly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 04, 2011 at 07:53:37AM -0700, Kevin Hilman wrote:
> >> @@ -1140,6 +1128,36 @@ omap_i2c_remove(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >> =20
> >> +#ifdef CONFIG_PM_RUNTIME
> >> +static int omap_i2c_runtime_suspend(struct device *dev)
> >> +{
> >> +	struct platform_device *pdev =3D to_platform_device(dev);
> >> +	struct omap_i2c_dev *_dev =3D platform_get_drvdata(pdev);
> >
> > what happened to dev_get_drvdata(dev) ??
> >
>=20
> Yes, that would work too since:
>=20
> static inline void *platform_get_drvdata(const struct platform_device *pd=
ev)
> {
> 	return dev_get_drvdata(&pdev->dev);
> }
>=20
> but IMO, readability is better if the driver does platform_set_drvdata()
> and then the corresponding platform_get_drvdata()

fair enough, but if you already have the dev pointer, what's the gain in
doing a container_of() just to go back to the dev pointer again ?

IMHO, there's really no need for that and just calling dev_get_drvdata()
straight is enough. All in all, platform_get_[sg]et_drvdata() are just
wrappers for dev_[sg]et_drvdata(). The whole point, was to avoid
dev_[sg]et_drvdata(&pdev->dev). It's the same with <drivername>_writel()
calls we see on all drivers. Just a wrapper, but you can use
__raw_writel() directly if you wish.

--=20
balbi

--QILrdhYozogw5Vly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOOrY/AAoJEAv8Txj19kN1Wf0IAIK6q7AT5Yj1TxuFGQJ6vgJp
27uSIsVGXYGyOhsCjStUrtJjCEKb7ufJz/PuJf3JodrJx4qNKXBcZemTyaMMzwA6
6QRUgsS7PFfpbp99h0FlZiRs0IEmT3pkrTMGe4AbJac6yjzZeNVJ8iHM6f3VyM2R
8qW9rCvckbYTrdBchG8CMZja7psiDUwJwkFE41GKS1Czy1IoH+eMlGgncCZFGRUH
VD5dmSRWlIUHg+kJXk5LXyPpMbQcqm4vVsLGtn6iOJWwpACu/4sBsPZnX8WUPOVR
RwO8jlwUoR2lhv5akkMzHgwqSU9JJfAwkX/24wX9j22j7dqMPue8eUEzp8ta4BA=
=5aDd
-----END PGP SIGNATURE-----

--QILrdhYozogw5Vly--

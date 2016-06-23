From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] regulator: tps65217: Enable suspend configuration
Date: Thu, 23 Jun 2016 11:26:34 +0100
Message-ID: <20160623102634.GX28202@sirena.org.uk>
References: <1466412218-5906-1-git-send-email-j-keerthy@ti.com>
 <1466412218-5906-2-git-send-email-j-keerthy@ti.com>
 <20160621190848.GF28202@sirena.org.uk>
 <576A64EA.4000607@ti.com>
 <20160622101611.GI28202@sirena.org.uk>
 <576A67D9.6080707@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p11K2BJEgMZL61bg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <576A67D9.6080707-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--p11K2BJEgMZL61bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 22, 2016 at 03:56:33PM +0530, Keerthy wrote:

> I will allocate memory for TPS65217_NUM_REGULATOR strobes during regulator
> probe. Is this approach okay?

It should be I think.  Some more comments or changelog explaining what's
going on with the sequencing would also help.

--p11K2BJEgMZL61bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXa7lZAAoJECTWi3JdVIfQJG8H/i2uB7kAGeoUpdxJ2yswedLK
sd5zeUAUm7Vd2HMtB3CQmZ+47t9DaO3WkulOgxAdvg+MXVBCfMqgCm8FPD0PKV2v
+Yt7F98irFgHyQQqwncJSDCbpdcUFeTcjTOnpqAJHWbnjytSgNsq1ZXHOLyBNqhR
pogKDZj3elndh3CJJlZF2ALUryPc9BZwFx7tIVBVtt8tsndWzatqKv0L9cETJNcf
GAIqNOYyMswrfjhucFfCW8YqBFHf3JLTaLvoyuPmX2xpwjJQP1mmp26l8PTiP6aa
yNvnTseBIhJ2iWNPY84e97AksdGA76Fp8bMJRd+/IIcZDtRfoQW1ox8leL25Fv0=
=XVXs
-----END PGP SIGNATURE-----

--p11K2BJEgMZL61bg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

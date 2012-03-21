From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: Remove suspicous and unused TAAL regulator
 API usage
Date: Wed, 21 Mar 2012 14:49:07 +0200
Message-ID: <1332334147.2236.11.camel@deskari>
References: <1332168646-4391-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-A2LF/KjG3I8b+yQJOW+O"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:35448 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757371Ab2CUMtN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 08:49:13 -0400
Received: by lahi5 with SMTP id i5so1054182lah.11
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 05:49:10 -0700 (PDT)
In-Reply-To: <1332168646-4391-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-A2LF/KjG3I8b+yQJOW+O
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-03-19 at 14:50 +0000, Mark Brown wrote:
> The TAAL driver contains some regulator support which is currently unused
> (the code is there but the one panel supported by the driver doesn't have
> any regulators provided). This code mostly looks like an open coded
> version of the regulator core bulk API.
>=20
> The only additional feature is that a voltage range can be set once when
> the device is opened, though this is never varied at runtime. The general
> expectation is that if the device is not actively managing the voltage of
> the device (eg, doing DVFS) then any configuration will be done using the
> constraints rather than by drivers, saving them code and ensuring that
> they work well with systems where the voltage is not configurable.
>=20
> If systems are added needing regulator support this can be added back in,
> though it should be based on core features rather than open coding things=
.
>=20
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Looks fine to me, I'll apply to omapdss tree.

We had multiple panels in Nokia, almost the same but with slightly
different regulator needs, so we wrote the code removed in this patch.
But as it seems there are no more linux devices coming from Nokia, let's
just remove the regulator code.

 Tomi


--=-A2LF/KjG3I8b+yQJOW+O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPac5DAAoJEPo9qoy8lh71A2kP/Av5OTAKYZFocDrqTVckDM46
QV728yOXeAGwLdfKF9UbQM4iOBiFXmSyq7bXkcZPunsGvSy6SkBptwzE8ShfcIaF
n1GMMntOrLt5hbmRX4DUC0eGhs9heG0P5zk49/VC7XdcB87rSRm0ZylJ/Fy5dONX
R2OUIfScyLVRsvJCCnCSKhmwBLswaKNH/PLFKkTGF5hPIwjEI0sd5jvWnxx9GLPd
xmFkqHv6EAMPcNMJy1aQePcc7E4aEjD/pZPqcZLfos2Gm+ZDAr0cjpZfjGYOFi1A
E0Hpx1wmzTVlLoswOBMoRzz78bBoC+Ts6yvYup9h8wXkmP4TDz3zBmDAFaqLTjOI
XVsOph5wDqrWv+vl1WcL3xL54D3TmKTzlZJV6KKX9Uk+lCPiGjYIsJNaIn/csJpM
lqNjFDZb+dCvbBW2U3UFqv/uYIsbK+iupPivQ5Ly8K1hoRlZu0e/bLrG/CL/GJrq
X9teCRtPm/M3zPyOzSrCMg4tm/O7S4TAArg/awo+66TZQj+OrQvxkpZmGmBQIRhA
dB6ocP36QLwYyeDA05q2ITnJgyPKOpXTT4u2i+XMKfdMA4357W4w4g1njStzhyxG
vI3J2TCByMzP+Rew8YDFrhlNerdzFJZfT9xGikgkxkhFXwEJFOpN9sql1LexgzKl
HNjQbzuPLuR8QQLSDB5G
=QGa2
-----END PGP SIGNATURE-----

--=-A2LF/KjG3I8b+yQJOW+O--


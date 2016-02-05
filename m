From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Fri, 05 Feb 2016 19:48:10 +0100
Message-ID: <1454698090.2623.3.camel@collins>
References: <5681D7A8.2030101@ti.com> <1451387613.18148.9.camel@collins>
	 <568323B7.7080101@ti.com> <1451464521.2531.4.camel@collins>
	 <20151230163307.GW16023@sirena.org.uk> <1451500639.14341.6.camel@collins>
	 <20151231214007.GC16023@sirena.org.uk> <1451599146.9673.2.camel@collins>
	 <20151231221407.GF16023@sirena.org.uk> <1452929533.2520.1.camel@collins>
	 <20160118163248.GI6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-sT+mkdpR7fdBZKe2Kkuu"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160118163248.GI6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Milo Kim <milo.kim@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-sT+mkdpR7fdBZKe2Kkuu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 18 janvier 2016 =C3=A0 16:32 +0000, Mark Brown a =C3=A9crit :
> On Sat, Jan 16, 2016 at 08:32:13AM +0100, Paul Kocialkowski wrote:
>=20
> > Is there some git tree I can work with that has regulator runtime PM
> > support at this point? I'll certainly end up handling the GPIO in the
> > driver otherwise.
>=20
> No, the last week was much more busy than I was expecting.  I'm hoping
> for this week (or you could have a go at implementing it, it'd be adding
> the PM operations in _regulator_enable() or _regulator_do_enable() if a
> flag was set in the regulator_desc).

I decided to go with a function simply requesting the GPIO for v2.
Support for runtime PM can be added later. I'll get back to you on this
on the thread related to your patches, since it appears to be somewhat
broken for now.

Thanks!
--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

--=-sT+mkdpR7fdBZKe2Kkuu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWtO5rAAoJEIT9weqP7pUMRhAP/19ntaNdwbpLKkbpSu0uQvrw
jdIBPxvjFT4ydeO7c8yssOwJlNJEuB4YoYZXqaJ4vObvlZ9H7KVCJ2TsX9zzjxRl
IOuoAPPhh/Xgl6AVmefQBoWvlBKVKwd5fv78H2mboTZGHpTUUJ1x21syW8a5pbfM
ybc7Qm2+rDKf2x2U4o3jjFfpVZq9mYHmK1Sf4R8hf/dIkIOJ2ElWUXYClQtpjH0Q
CxSsqLASJRqITZfZHdHV9zJ6uaazLQez9KEdYEhG2/1zXJudSOp/vP6lFyYhX7Hb
bUoZGjodO2RYiCDMITi8U7aPzbPWo/JImYERLMV9suRY7lHTXj6Ik3EYXWuuLcvj
/1xjJ9FhdGMr5x6yiN8RWivOq2Ns5/n2wVk+4B5JOQlummquJw9wxpg1i9864y94
98dj2SaBvQaj2ReFcSGu/TRqH2FBH/X2XgCdS1nmFX8TfGCYzhr9Pyb7IUnUC2SA
tvfasX+sWO8CQ4eRNze6u/w3qNJT/2KU9JLoGgqWBndwRjIgVaJvgdSWy8N1myKU
dmOcDpB8cqhTmRKAXwyVa4qB9ODXn9z5ITTrzYNnO6UfTUkf/+Rw6GW+L/WZxe3A
SQT6/MY4QGoghdWevKDJhCP+WNq8rtFHn1UhZD8JEf+tByUxTuzYhVpvj+dLh8FJ
MyEXXWRq4ZwQ1OWG9vvv
=kdgx
-----END PGP SIGNATURE-----

--=-sT+mkdpR7fdBZKe2Kkuu--

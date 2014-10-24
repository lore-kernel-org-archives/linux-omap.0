From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V3 3/3] rtc: omap: Support regulator supply for RTC
Date: Fri, 24 Oct 2014 10:43:12 -0500
Message-ID: <20141024154312.GL26941@saruman>
References: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com>
 <1414126425-13198-4-git-send-email-lokeshvutla@ti.com>
 <544A5393.6090504@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vTfKKTivj/mQoluA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33940 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbaJXPoX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2014 11:44:23 -0400
Content-Disposition: inline
In-Reply-To: <544A5393.6090504@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, johan@kernel.org, tony@atomide.com, bcousson@baylibre.com, balbi@ti.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--vTfKKTivj/mQoluA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2014 at 08:26:43AM -0500, Nishanth Menon wrote:
> On 10/23/2014 11:53 PM, Lokesh Vutla wrote:
> > On some Soc's RTC is powered by an external power regulator.
> SoC ? -> could you rephrase this to indicate "certain SoCs such as
> DRA7, RTC is an independent voltage domain of it's own and on
> platforms such as DRA7-evm, this may be supplied by individual
> regulator on it's own.
>=20
> > e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
> > power regulator.
>=20
> Question ofcourse is what voltage would you like that regulator to be
> at? As you are aware, certain LDOs and SMPS can drive varying voltage
> and just enable/disable would do just the default voltage of the
> SMPS/LDO, right? OR am i missing something here?

just pass the correct voltage through DTS as we do for all other
regulators ? It's only tricky when we have a range of acceptable
voltages but for RTC, IIRC, it's always a set voltage (1.0V or 1.8V).

--=20
balbi

--vTfKKTivj/mQoluA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUSnOPAAoJEIaOsuA1yqREcz0P/i0tzd0n6A939NnWOnZJ35SE
qh9x6hDuTsQdcH4sjneyUL8GolH7r2L+XRPJGYQRXLhIdVjutG56RFlEEBa7QrxP
d2weYtQQBNgg7Y93/XZC65uCpfUqLPU0U79IybSkIMFOWSyBwBtdVvFwjwwFJ1WP
RgQppa6c75FFjFa7CAtbBxMnsdQ7fEKIo9Yn30la5kmthJVwaFrbmSXokYxd0IZ7
nogNG5n71jtBRaEzpRe1IebxJt1zwU/NHqMsomPGt4UpYs4SY4d2sZKEYBJRnO6v
JN8+BMCbAYcyJhLvNcBzx/3VhB3TYny/8TjwPozXmaz7St35F+++q2PvBcsXlGYN
0QLRrWHCnq2f5AZKyZHgVjQ1r+wFwXDBKjLTcb4/I/Qq0ya30FYCpWScR27XOjjA
6Uv2aMWmBKMeOT22MFlV8UB17fMpr+0hK/S+nNmIXTycf+w1mrJxMIu+08WmnWA9
Td2h508B8sGw0t3uTvBRrng0n0a0yugh3f/9fR7zhQH6jUTPDjdAMSLZA1ldDvoa
miXMPm1qJLLfG8gKQ3T/FPFwhdG6OKz3xHqg7TUc+l6PCMO/uuvvp24MBtpXk1Ne
ysZYBSvGzZf0da/R4t5cRfFTT1KEU0VQHnfIDPhdPihOiqRKBNANowS8rH1QJ+hi
5q8qZuY2Hp9o7fMAMm66
=jU8A
-----END PGP SIGNATURE-----

--vTfKKTivj/mQoluA--

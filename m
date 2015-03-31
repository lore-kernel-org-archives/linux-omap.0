From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RESEND] ARM: dts: OMAP3-N900: Add microphone bias voltages
Date: Tue, 31 Mar 2015 14:32:33 +0200
Message-ID: <20150331123233.GA15103@earth>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <55197A12.1050009@bitmer.com>
 <20150330164237.GJ10805@atomide.com>
 <55198BA4.5010207@bitmer.com>
 <20150330175051.GK10805@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39141 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213AbbCaMdD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 08:33:03 -0400
Content-Disposition: inline
In-Reply-To: <20150330175051.GK10805@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Pavel Machek <pavel@ucw.cz>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 30, 2015 at 10:50:52AM -0700, Tony Lindgren wrote:
> * Jarkko Nikula <jarkko.nikula@bitmer.com> [150330 10:46]:
> > Well, there has been regression but finding exactly how far should the
> > fix go didn't look instantly straightforward due all DT, codec driver
> > mic bias etc changes and I ended up not cc'ing stable.
> >=20
> > But well, I guess first kernel where this commit makes sense is 3.16+
> > due commit f7d0f2a08567 ("ARM: dts: omap3-n900: Add sound support").
> > Although it applies on top of commit 14e3e295b2b9 ("ARM: dts:
> > omap3-n900: Add TLV320AIC3X support") too (3.12+) but not before that.
>=20
> OK I think debian is using v3.16 kernel

Yes. It will be used for Debian jessie (not yet released) and the
N900 related drivers are enabled in the armmp flavour. Unfortunately
it does not work together with thumb using userland because the
errata 430973 workaround is not enabled.

See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D768890

I guess it should be tried to change the workaround, so that it does
only change the behaviour of affected platforms. Otherwise its a
hard decision for distributions to enable the workaround.

> and that's pretty much the first kernel that is usable with dts on
> many omap3 devices so might make sense for that.

DT support for N900's soundcard has been added in 3.16, so before
that the audio stuff didn't work at all.

> I can add it if you think it makes sense.

I guess backporting this makes sense because of fewer "broken" DTB
files in the wild.

-- Sebastian

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVGpPeAAoJENju1/PIO/qaZCAP/jFgOY3YMlHC5MAlhbQjO6m+
XIGoO/DYWUpGgTRUfsiFdeGOBpukT7GDxV+pMHebjX9ETZD4/IpKIyP9ASLEFbkY
Skrra4uleH5v6RNEQRLlEDodGba8kI8BV7qqR13AxuoLvENEOlYBvVOS6fTG7B44
QSnRUJe/ROrc/zwl2+n0/pAUgV60S5+ODlKaw/NcNmfx6DwjBStrU1wjTEp38yqc
sqG8AFF+pKkAk5ns/BHSoQY/sBXwBeecEwQlU7PZ702Lf81mUlZoyQTXOoCwFWFp
me4dxTF3Jm23Nw2qrA5roVIyn7LzBXuyszX8g0yUZgjv6b/Xxx0SoG9a/Ip8hqdn
AxoKTjr+qA0rCGYBea8uQsBlBWqkv/pX0WcVsQZOi6iNSjLImbSQcoRXOhm0Odp3
FCjvzhD1ejTMcXSglUti0eP8afeg2nY8H/wxMmmJPpkBHvDVbZe3iOnaw+zghIBE
fmDZ6mhIHI+aATTZ89S9TIr+xztrFQ1aBbos4Q39w1S8lEnZtcqp7RC+edrjQzmt
hxm3JiyOC7eQsAMlQXaPvQeRUZ0BkKAu07pn2/byCWijnvlWmQkrBCpEk9Stysjx
0c1mIp4vP+mJ8S3GY2FcGbvD6LGlYY3zhdmWFFFNX2oJpi2fTN7sq5DOS33J0xQS
6jaaOQ8jK7jR3ZD1iMkX
=iZbr
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

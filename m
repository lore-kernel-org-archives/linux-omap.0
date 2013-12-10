From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 17/26] ARM: omap3-tobi.dts: add lcd (TEST)
Date: Tue, 10 Dec 2013 14:18:46 +0200
Message-ID: <52A706A6.3060104@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1386160133-24026-18-git-send-email-tomi.valkeinen@ti.com> <52A1A492.8090205@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="bPLuk9GO1gMgT3RufwushNFoFdr6wV4H3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38794 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352Ab3LJMSx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Dec 2013 07:18:53 -0500
In-Reply-To: <52A1A492.8090205@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--bPLuk9GO1gMgT3RufwushNFoFdr6wV4H3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-12-06 12:18, Florian Vaussard wrote:
> Hello Tomi,
>=20
> On 12/04/2013 01:28 PM, Tomi Valkeinen wrote:
>> This is a test for Overo with Palo43 expansion, _not_ Tobi. Palo43
>> doesn't have a dts, but seems to work ok with omap3-tobi.dts, so I use=
d
>> it as a test.
>>
>=20
> Looking at the schematics, both seem pretty similar indeed. The main
> difference seems to be the LCD on the palo43, and the HDMI on the Tobi
> (TFP410, as in your patch 21).
>=20
> I only have a Tobi on my desk, so this is the reason for not supporting=

> other boards... We could make a .dtsi with common stuff, then add the
> LCD to the Palo43 and HDMI to the Tobi. I was going to add some more
> support to these boards in the coming days, so I can add this too, at
> least for testing purpose.

I think I'll just drop this patch, as I haven't been able to boot my
overo with nfs root for some time. I don't know if it's my pc or the
board or the kernel, but for some reason the usb gadget ethernet refuses
to work.

If you want to update the tobi.dts for the proper DT data, I'm happy to
include the patch to my series.

 Tomi



--bPLuk9GO1gMgT3RufwushNFoFdr6wV4H3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSpwamAAoJEPo9qoy8lh71ZjkP/1YzsSBGoW754Kie06BSzEzI
a55X8LkJlxLCWoQIxmqeA2Zv26121m+rPHAQ3lHgauvZGMuZTClklxXwRTZ9oC+q
lGn8UEearCoCTFUyMusjGCy/EPKtWXf+NukJJ7Jby7+ZujWCsPIDTZBYIpKlVI8X
BKKbTDmTTWslL5nv8oGR4jFOhfPb8rCc+r+ITFPae9ve8D9QkoWzUFS4W879BTG/
l/DxCgF5fsjCXRhmb98adZ14BYYCGtFyeQRN+LygbMO+SLX+Qs9K+5Y2GAxd4iFI
qVuUxTU56VqNT7wLf1CV+GyT6TSinKkNrXnnReAd1Gr98YA8fZCBK2WPi6eLIGK+
8cIbh1zqxK7opya9TPzhRGrutcCYCv+kX7BhetV7mYGKClM8/57egV+4JnnBCJyE
iMe2F+s5fE86OJp4w/v8BC4R21p8ulW1gD40Vn7AbK2o5r8T5WVWpnBXw2C5yX+f
SD9DlgzoW3rD4IxEuyiinJNIY25jTzWMoKnJ/TnuvHkAZETBfoTGhQBNvXZsWGlV
i+RwIetUjlbWbf4TRhMnylLWWv3V/jXNH437x2Hm0Ml6hejF4wubcuT+NTyintRx
t0i2NSiD+zVCoSt6BjD0b/se/sg4d1ZLANIqIX57gH0l5Z12Qnq8mJmEh9RRbbII
7SR8sy1uWcsUWE6tZ9fa
=rRS0
-----END PGP SIGNATURE-----

--bPLuk9GO1gMgT3RufwushNFoFdr6wV4H3--

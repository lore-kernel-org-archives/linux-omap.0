From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 16:52:11 +0200
Message-ID: <1326984731.7926.27.camel@lappy>
References: <20120113222045.37f9b4ec@notabene.brown>
	 <1326870839.1954.23.camel@deskari> <20120118221538.342b4782@notabene.brown>
	 <1326886940.1999.5.camel@lappy> <20120119073032.74cc0992@notabene.brown>
	 <WC20120119101721.07072A@terrafix.co.uk> <1326969658.1935.24.camel@deskari>
	 <WC20120119112911.670749@terrafix.co.uk> <1326973019.7926.7.camel@lappy>
	 <WC20120119122128.020787@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-EzUU0WGOvqdDaWQuFtvq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:35598 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753300Ab2ASOwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 09:52:18 -0500
Received: by laam7 with SMTP id m7so6002laa.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 06:52:15 -0800 (PST)
In-Reply-To: <WC20120119122128.020787@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: khilman@ti.com, NeilBrown <neilb@suse.de>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org


--=-EzUU0WGOvqdDaWQuFtvq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-19 at 12:21 +0000, Joe Woodward wrote:

> If I do (either from the console or via a button press on the screen) the=
n I never get a SYNC_LOST.
>   echo 0 > /sys/devices/omapdss/display0/enabled
>   echo 1 > /sys/devices/omapdss/display0/enabled
>=20
> Just trying to think of some ideas that may be affecting the DSS...
>   - Could it to be to do with the GPIO being used as a wake source (i.e. =
does the GPIO driver do runtime_pm properly?)?
>   - Could it to be to do with the UART as it seems to fix itself whenever=
 a character is pressed?
>   - Could it to be to do with the ordering in which drivers are resumed?

Well, none of these sound probable to me. I don't see any connection
with GPIOs or UART as such with DSS (I mean something that could cause
sync losts).

The only thing that I can see affecting DSS via GPIO/UART is indirectly
via PM, with voltages or clocks. But if DSS responds in some way, I
presume the voltages are ok. And your clocks should be low enough to
work with lower OPPs also. So I'm quite out of ideas.

Of course there could be a problem in the omapdss when it returns its
registers. But it wouldn't explain why the synclosts end if you press a
key in the console.

> Is the SYNC_LOST normally due to a lack of memory bandwidth? If so, it is=
 possible to find out what the kernel is doing during the resume?

No. That should cause fifo underflows. I don't know the exact reasons
for sync_lost, but I think it generally means that the DSS sub-modules
lose sync with each other. Mostly this is due to clock config, but can
be cause also by other (wrong) configuration which makes a DSS
sub-module behave somehow wrong (or halt totally).

> And before looking at this too much more, is the changing of the pm_runti=
me_put to the _sync versions the correct fix?

Well. I think it's a correct fix, in functional sense. However, I would
like to use non-sync versions normally, but that's just for performance
optimization.

> Sorry for so many questions, but I'm interested in getting this fixed as =
it's the only thing stopping me from switching to 3.2 from 3.0!

The only idea I have currently is to add/enable debug prints which show
information about PM changing its states, so we could see if something
actually changes at the moment you press a key in the console.

What kind of setup did you have again? I wonder if I could reproduce it
easily with overo/beagle (it was omap3, wasn't it?)?

 Tomi


--=-EzUU0WGOvqdDaWQuFtvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGC4bAAoJEPo9qoy8lh710TMQAJj++W6jiZXuZueigKq4oGeN
R7u93Fjy+6wXMz+4hKn5c/ALot1oBbmvyUDjt2LdRETLdi4BDDdmf2YCx4LXhUtL
BtXccoUX0/q6XxZKwfT7lpaqAa0hx9I6MW38soV0LBRb9uZO7usGKDz6VK7HvpCb
WCj3r4mME3E1T+Z0n4dfDnA1n0QMpdOBzRx6eSFdmHxmjF4NTJv0H5tzpQr9KGXz
fdp9qNO+ZJC4nmxpLpA2g3rEHvFv80YKiGW1jwy7iHgfleplKTAcKi0CCT+3KeXN
1nj/kNbXdGX0PXQ5Du67WK4lD3PkeFNYILJ/lgO6j/uPn+xL0sUaQEEO2cqBp3e6
Hc4qRFZ454lrCn2QHtgvgSH5oeNHxGLIhUKlhf/1aVD2qAN5v2FnYY4Tz2X4tRlZ
tGjCy2NQIZ5GhfsMhUa83APA64Zp4CIS0FQZvtZ5tei9z+ar58MCYhSDnsxKWxQ9
ARkqd4fEL9soeDEq1H35BMEEUIGbgiN3yUq2aqwSaQYlYXsQBVndLEpG3v0Zjyab
kMzYmz77YQZNStrulB002TC6allo+Q+ocnJwIO3j1th5nw8azbZkkFxLFPtZAC45
teog5F2XRPIbXG/N3be5VZUxDd679v4cF0E1uvLto4VP0L4f7dXKL9dOcZfz7ch6
2DMmJco34ewgbrIXLEeI
=n/0k
-----END PGP SIGNATURE-----

--=-EzUU0WGOvqdDaWQuFtvq--


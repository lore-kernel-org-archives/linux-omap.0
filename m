From: NeilBrown <neilb@suse.de>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Sat, 14 Jan 2012 10:09:15 +1100
Message-ID: <20120114100915.01c96727@notabene.brown>
References: <WC20120109124643.880164@terrafix.co.uk>
	<20120110080849.5a242adf@notabene.brown>
	<alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	<20120112095940.0a54413e@notabene.brown>
	<alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	<20120113222045.37f9b4ec@notabene.brown>
	<alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/qBK__bAlgkDmYa.yGSKRsQU"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33443 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab2AMXJ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 18:09:29 -0500
In-Reply-To: <alpine.DEB.2.00.1201130423280.3659@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.raja@ti.com, linux-omap@vger.kernel.org

--Sig_/qBK__bAlgkDmYa.yGSKRsQU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Jan 2012 04:31:37 -0700 (MST) Paul Walmsley <paul@pwsan.com> wro=
te:

> On Fri, 13 Jan 2012, NeilBrown wrote:
>=20
> > Also, the HDQ access to the battery 'fuel gauge' is working fine, so
> > presumably that gets disturbed by one of the lower power states (3,4,5).
> > I guess it is 4,5,6 when CORE goes to RET or OFF.  So we need some way =
for
> > HDQ to say "I'm busy" just like UART can.  omap_hdq_can_sleep() ???
> > There must be a cleaner way...
>=20
> The first thing to try is the HDQ runtime PM conversion series that was=20
> sent separately.  Maybe let us know if that fixes the problem.

Not completely - but I'm still exploring.

>=20
> > More experiments:
> >  - I enabled off_mode and started seeing state3 happening.  UART and HDQ
> >    still fine - as expected.
> >  - I set the  /sys/devices/system/cpu/cpu0/cpuidle/state?/usage values
> >    all to '10'.
> >    Now things start to break;
> >    Console is mostly OK, but the first char after 10 seconds of idle is=
 bad.
> >    I type 'enter' and get 'C'.  In general the first char typed is mapp=
ed to=20
> >    something else in a consistent way:
> >       0a -> c3
> >       20 -> 90
> >       55 -> d5
> >       2a -> 95
> >    It is a bit like we are missing a start bit, and a stop bit is shift=
ing
> >    down into the msb .. sometimes.
>=20
> I'm not seeing garbling at all on the OMAP3 BeagleBoard here, running v3.=
2=20
> with omap2plus_defconfig.  The first character from the console gets lost=
,=20
> which again is expected when the CORE enters a low-power state and there'=
s=20
> no flow control on the serial interface -- but no garbling.

What baud rate?

If I use 57600 or lower I see no problem at all.  The first char I type gets
through fine.
If I try higher rates (115200 is the default, I've tried 230400 and 460800)
I get consistent corruption, though different corruptions at different rate=
s.

I've tried enabling hardware handshaking but it makes no difference -
however it is possibly there is something wrong with the wiring so I'll che=
ck
that before pursuing that direction much further.

Presumably with working hardware handshaking we should be able to avoid any
loss or corruption??

(I'm not sure if I said - but the board I am working on is the GTA04 Openmo=
ko
board: www.gta04.org).

Thanks,
NeilBrown


--Sig_/qBK__bAlgkDmYa.yGSKRsQU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTxC5mznsnt1WYoG5AQKcsxAAuvVoHp3IJU0gmcCqCoci1zUqyoqLDwM2
v9pJlNbXzO6iZ645xRFB/rCoAYDVQbOOBOCBdFm2rDcve5GhU1WXrWFWNgHXIC05
L9AQe4FpSapJejpA9A2jF234N4Prk+si5YcZH8Y1b0fFv1GhfbOsnyDTzuvK/F/F
+kp5+ZiAzOQflIN0xYlJOFnFTe2Mo6fXIKTas61UIc/TnwplV3GxEzG42bmZ0V1a
kosuBGt+KPOXUkPBOu09jMIQ6O8a17bNkF7rdQ29w6RFYwlBZJTmzxQ1W5bkMS7Q
3YcTt5qbO6sFbjXzBtuoEpnd2i/RVhq+efSuy3uYRfoCuJnRom7nkhPjw7Er3hYH
mIP8ynzkZc6qpMLYxXvH/H6AViPrTmYkrJlAJvDqEPEXl4WjYWnhkYDtKYmlHeM/
PFlUW6TN4FfrVBA+Go7suf5V/nrGrT7msI9TzgENJYARpGIFG3UjLoM7ONNJHhad
5RJWNYk3mb/oeXHemoeiT4aKfdOGUK+PXsFu9f7S4x4WDss2c37U3b1//tcm8byG
CZWYox6UzS5Ii8iN2LaIWdSa88pj9yLRRuwrJy8pQ77GvLx0E50X0XH67eLXb/77
5MAbUXpf50kSXp+SYt5SN09fZujoZgNR9W6ez6jz+wLms5+pfZnld0WblR66yFip
8BC9+fwSapw=
=IXgo
-----END PGP SIGNATURE-----

--Sig_/qBK__bAlgkDmYa.yGSKRsQU--

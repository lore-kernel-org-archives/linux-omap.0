From: Felipe Balbi <balbi@ti.com>
Subject: Re: rts-gpio DT binding
Date: Wed, 19 Mar 2014 14:04:38 -0500
Message-ID: <20140319190349.GB2194@saruman.home>
References: <20140318165536.GH14373@saruman.home>
 <53287CAF.9040708@newflow.co.uk>
 <20140318171110.GI14373@saruman.home>
 <53296017.3090104@newflow.co.uk>
 <20140319145957.GB27752@saruman.home>
 <5329CDC0.6010705@newflow.co.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38108 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbaCSTG1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Mar 2014 15:06:27 -0400
Content-Disposition: inline
In-Reply-To: <5329CDC0.6010705@newflow.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@newflow.co.uk>
Cc: balbi@ti.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 19, 2014 at 05:02:56PM +0000, Mark Jackson wrote:
> >> Okay ... it comes back to me now.
> >>
> >> When using RS485 drivers, we're not actually using RTS as a "Ready
> >> To Send", we're really using it as an "enable RS485 driver".
> >>
> >> I just used the "RTS" mnemonic as "we're now wanting to send some
> >> data so please now enable the RS485 driver", rather than the normal
> >> "I'm ready for your to send me some data".
> >>
> >> So it's the opposite function.
> >>
> >> Maybe it was a poor choice of abbreviation ?
> >>
> >> As I said before, RS485 drivers might have active or active low
> >> enables, so we might need to invert the "RTS" polarity.  This is
> >> not handled by the hardware RTS signal.
> >>
> >> Is that a good enough explanation ?
> >=20
> > fair, but considering you can toggle RTS by hand with writes to MCR
> > register, I still don't see the need for remuxing the lines as GPIOs.
> >=20
> > Just don't use auto-RTS and toggle the line by hand with MCR, no ?
>=20
> TBH I hadn't realised you could do that, so I guess you could.
>=20
> But my solution seems more flexible as it would allow you to add an RTS
> signal to UART0 and UART5 which don't have any hardware handshaking lines.

fair, but at least turn into helper functions part of serial core so
that other serial drivers have a chance of reusing this.

IMHO, it's a pretty ugly hack, but then again, a bunch of current
in-kernel GPIO usage is, anyway.

--=20
balbi

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTKepGAAoJEIaOsuA1yqREy8oQAIiVgNKxloVMW5aVbONTJkgG
W4aPRzJXGKpb28NnaSoMyNymSpUdSuht+Xl+5FlGrVWMBGwvipcTuQOZmKQMrFCV
wiQp9MxJ5ofxOJWubZ4RmsMB17AY66yVEBShjc1TiMZxQa06KDqEdkmmDtKW2hA4
0Ax5GjmRE3qO5qC2Y/1u4onqsh1GZrE339j3SdPCOlkzzxRbo0dNNDPbwB0ZQt9j
chpXQmUFnSApdQzG/WhfDn4ZFzURA2pcg3g2S5Fda3MMhl3vnxQxe1q9hhzzgxp3
s5qp4wDIa39/sNxDb2u7rsZYmYW+r9DB2Z5K1yn7OJz/onY5gwe1UBRcmbVw2YXk
Hq1BuM+cx9dlsNLMmqhtkmX79LZ8zd5EdCRHB6aQDWvLvP6lT0qZBZ5mF+0C5g5z
VXTiUPCIzVLGSBGbAFetvCz8T/mzHCdfQ503WH1vLd63HyW3c1Rtbmz86WYf2ZTP
l+14EXvVDctxH40f1EDdfTVz4LrYRNNADhSQvJX3/bdVZ3dwybB6OUQzKO/spdbt
Gt9RP+SFqrnAGVh2DRdeE+5j6siGYuSbbbEZPwYfCb/ZllwKKzfM5ZuNVwKHgxeN
4CXs0aBeZ6Yw5huRR8/XpNtuPligFMv2gJ2vK4H5/qSS2QdZUeAVuRDRtOnUJ2TQ
j3GBt3Wda1tnw4NG4dn+
=oEhw
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--

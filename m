From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: HDMI: Move duplicate code from boardfile
 to
Date: Wed, 26 Oct 2011 11:27:59 +0300
Message-ID: <1319617679.2097.38.camel@deskari>
References: <1319189211-10991-1-git-send-email-mythripk@ti.com>
	 <1319195561.2870.75.camel@deskari>
	 <CAP5A+B9F8f+qZJg6DM1c78wj=o=rwh35bOsAEnLW4Bqr7oGVLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-v2zlOPFmBiuHLRjCFFUd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39537 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753130Ab1JZI2F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Oct 2011 04:28:05 -0400
Received: by faas16 with SMTP id s16so2033273faa.34
        for <linux-omap@vger.kernel.org>; Wed, 26 Oct 2011 01:28:03 -0700 (PDT)
In-Reply-To: <CAP5A+B9F8f+qZJg6DM1c78wj=o=rwh35bOsAEnLW4Bqr7oGVLA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org


--=-v2zlOPFmBiuHLRjCFFUd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-10-25 at 15:11 +0530, K, Mythri P wrote:
> Hi,
>=20
> On Fri, Oct 21, 2011 at 4:42 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:

> > However, for DSI we need to change the pins during runtime, so that's
> > why the functions for DSI are required. If the HDMI configuration is
> > more static, and needs to be done only once at boot time, perhaps the
> > display_init function could go through the displays from the board_data=
,
> > and if there's an HDMI display defined, do the muxing.
> Mux configuration for HDMI is static unlike for DSI, Also i have added
> a check for OMAP4,

So you are sure the HDMI pins do not need to be muxed to safe-mode or
similar when HDMI is not in use, to avoid leak currencies, prevent
interference signals on the wires, etc?

That is the reason for the runtime DSI pin muxing.

> I am not aware of any OMAP4 board without the HDMI today.

Neither am I, but it doesn't mean there won't be.

> It appears to me that even other modules do their mux configuration in
> board-file.

Most of the mux config is done in other files than board files.

My point was that I don't want identical code in every board file which
supports HDMI. One option would be to implement omap_hdmi_mux_init
function, which takes as an argument whether the internal pull up has to
be enabled or not. And this function should be called from the board
files that have HDMI.

It's not perfect, as you still need to call the function, but it's much
better than having the identical muxing code in every board file.

 Tomi


--=-v2zlOPFmBiuHLRjCFFUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOp8SPAAoJEPo9qoy8lh71bHkP/2MKqBpSSJnirufGhgPQds3d
qUHVIJ/QawH056vjRIfIl8p9zHDKWeCcMaTeBAjGg3rjZ09TeCXc4Kwahasb0Enu
bdfJfdwQDHDSja0g5qJ5VFp2NIRBPfV3BiczbhRpnrTJbRNZAB9kHkPnEPCxi6/E
gxfh4UiEJYFTSmn2Ygc2kSEkRLYTd/GReHVts51Rs0MTDB9AQxzdFzODSkz4BXWf
kinHqH7GYyRpErIWWnH2yZ5NMfgv7f2cQVgkA7INeWneXsEpamTKhxencwrjeiFV
To57wSvd7iAt2+vJp1oq2YnispjPb1EK1RiHdDhuSq1UiCZllQDFIfssk6KP2XOA
XvguBxBIgCvyH4nGjZDdVkZuXuh2eBRJmXnhhxM6vwVK6CoT+NL0gBed+cNlM2c9
iqX1K6bqTrWTDQ2gdS3tg0NJ6T9fXAqbvPk0s+nYkf/GPQe93/DqRsJQQUSwzSVH
Xf+O6Vmebc5tfh20hwyOGrnKVMItsnBY0A8Rb1WOKSvsbCbSjibO5/R7XdVHgs9h
TIxGav3t2pTWZwo/wCvJSueM/qk0p6Ww/vMlrIgXXdG3XtdljhZiUpE70yLB4NBN
J6+yZlSvij+wW1WyVw8HiymEqwDXm9k3zOUis7TK8A8jpeJz44OcIBln4sdcqlv+
NvSQj4iAlxdgaMSKnEti
=Dex+
-----END PGP SIGNATURE-----

--=-v2zlOPFmBiuHLRjCFFUd--


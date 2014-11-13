From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Thu, 13 Nov 2014 10:05:28 +0200
Message-ID: <54646648.5030807@ti.com>
References: <cover.1415803064.git.jsarha@ti.com> <20141112222344.GU3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HUQUFxbjj3oAN7H3lCtnudIQshxA2rFgM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50611 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbaKMIFo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Nov 2014 03:05:44 -0500
In-Reply-To: <20141112222344.GU3815@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com

--HUQUFxbjj3oAN7H3lCtnudIQshxA2rFgM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 13/11/14 00:23, Mark Brown wrote:
> On Wed, Nov 12, 2014 at 04:40:51PM +0200, Jyri Sarha wrote:
>=20
>> It would make the most sense to get these in trough fbdev tree. So it
>> would be nice to get acked-bys (if the patches are Ok) for ASoC side
>> changes from appropriate maintainers.
>=20
> So, this is a very large series which gets reposted every so often to n=
o
> apparent interest from the video side, there's been no response at all

Sorry for the lack of communication. We've been discussing this series
on irc. It's been mostly about how to manage the device/driver split
between drivers/video/ and sound/ sides.

> that I can remember and even the earlier bits of the series before it
> starts touching audio don't seem to be getting merged.  What's going on=

> here?

The series is all audio in terms of functionality. The first few patches
could probably be merged independently, but I've wanted this whole OMAP
HDMI audio rewrite to be in one series.

I'll start testing this latest series, and I hope we can merge it for
the next merge window so that we'll finally get the OMAP HDMI audio worki=
ng.

I don't have much knowledge of the asoc architecture, so I probably
can't comment much on the sound/ side design. For me the most important
things are that 1) it works 2) I can easily unload/load the modules
(which was broken in some of the earlier versions).

As a more general discussion item, I'm still wondering why it feels like
we (OMAP) are doing something totally new here. I'd imagine that almost
every device with HDMI would need both video and audio side support, and
those sides need to work together. And the audio side would need to get
notified of things like cable disconnect (i.e. the video stream is
stopped -> audio must be stopped also). But if I've understood right,
there was no similar existing code to be found.

 Tomi



--HUQUFxbjj3oAN7H3lCtnudIQshxA2rFgM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZGZOAAoJEPo9qoy8lh71I/wP/i2v3PZk1TUBUlE4QcxyzerI
JiW3fZ5JHMiBMXSe8lEM4EgPnj01wm+XavXAR8Yc3YcaLa8J2HN8MW+m5qIxwN7V
LUHpVmcYMcyZahguetulnT1hAxrftly/7w1d/Cc68yfGW3+JJHJ5qbYIYtiXQBiK
Bblrw896p2MmdolHpLzpslx6F6Agf1SoSZSQGRi9fni0VMyB9m1VJh0IUluYKey+
qkAqrvRN92tEgTA59fEPNhmmxwAKQf2Xb39kFXCh6jxGaVeom25FM/5dLx2kun+r
lKxQAFtn4OiCLuppotuny4iWcqOyvZ249WyQvAP6pOLQMkiSdDvVT5t3IlYpcDZd
xgoYVvHWe9cPJrUfy81YvoePZ8HJX12Gm0GdbUiSyBfoYtICb0hq+vL1yyBhJ6sv
aWi15pGRbgYxenrVL87u7keT6mBuWKQTwR4GApcr2JK+fGOhHIWDWmn1Dc4Qrihi
1Wc+uwHEuRpUQZtXFSeUnyesUkGqxowmKkmhH0dyKX23WTDzm/bFBev6KBRxDH3L
xrzAzZj/LMPkdrYLGLKsgoGXo8b8laGkUg05JZcGsGfy8tNKiYPaSNYJcup6NHr2
QIOS15v4mCbbAX3hWIqA0lPQlGUirisigPcKgBinAz6sWUXpQh5ZfNFbcokOeMhY
U2U+dcL5s8RvmqsYNCcr
=VG3T
-----END PGP SIGNATURE-----

--HUQUFxbjj3oAN7H3lCtnudIQshxA2rFgM--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/22] Tahvo cleanups and Retu optimization
Date: Mon, 11 Jul 2011 17:03:28 +0300
Message-ID: <20110711140326.GE2680@legolas.emea.dhcp.ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
 <20110711132842.10606a31@maggie>
 <20110711131231.GB2680@legolas.emea.dhcp.ti.com>
 <20110711154126.082c1514@maggie>
 <20110711134551.GC2680@legolas.emea.dhcp.ti.com>
 <20110711155123.23c33a13@maggie>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Ohz8t0v+ZTQEWKa"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:36513 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754506Ab1GKODd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 10:03:33 -0400
Received: by mail-yw0-f50.google.com with SMTP id 6so1788095ywa.37
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 07:03:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110711155123.23c33a13@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--1Ohz8t0v+ZTQEWKa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 11, 2011 at 03:51:23PM +0200, Michael B=FCsch wrote:
> On Mon, 11 Jul 2011 16:45:53 +0300
> Felipe Balbi <balbi@ti.com> wrote:
>=20
> > On Mon, Jul 11, 2011 at 03:41:26PM +0200, Michael B=FCsch wrote:
> > > On Mon, 11 Jul 2011 16:12:32 +0300
> > > Felipe Balbi <balbi@ti.com> wrote:
> > > > > Are you planning to implement a backlight driver for tahvo? I'm a=
ctually
> > > > > using the functionality that you removed in this patchset in the =
OpenWRT
> > > > > distribution.
> > > >=20
> > > > if you have some extra documentation available, I could implement it
> > > > whenever I have some extra couple hours to play with this again... I
> > > > have no docs at all, but a led-tahvo.c would be really simple to get
> > > > done :-)
> > >=20
> > > All I have is the old code. No docs. It seems rather simple, though.
> > > Only a PWM register. That's pretty straightforward.
> >=20
> > cool, any pointers would be good ;-)
>=20
> Pointers to what? How PWM works?
> http://en.wikipedia.org/wiki/Pulse_width_modulation
>=20
> You probably don't need to know the details, though.
> Just write a 0 to the register to turn the LED off. And write
> a 0xF (or 0x7F depending on tahvo revision) to the register to
> turn it fully on. Any value in between to dim the LED.

no, not to PWM... pointers to the code using the old interface ;-)

--=20
balbi

--1Ohz8t0v+ZTQEWKa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGwKuAAoJEAv8Txj19kN1HtwIAIgbN3wNmOUUyHEpaN+01yfh
bnckBlP+3f3Ohky3aWuM30iqJnf5eWmnzu9SrwZHDDHeERlrSfBxXIatyHpCGyA2
Sxntoi5E14jMKu1zMtP9fFTEoYs95qVy1FvtEa4s8uv7zTaXmOWBaEG4DoVz/WZ1
qa9/C8eEyP/oK/NgAwzG3Uwg/2aDxKwQByhHnl/LOCihR3PmvCR46mxxukC4FF1f
zyW4UN1N72KMLTA2cnSpioeR/MyDWavVeK54DXGLVzTPLm9AyNK0Cz04art4BqBD
zahMViUvefuLrDzRzFPYaUojN9+ErQ5xEsoDCIe076QU7g287KsJa88a27W3IZo=
=RGjd
-----END PGP SIGNATURE-----

--1Ohz8t0v+ZTQEWKa--

From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: N900 modem support in 3.18-rc1
Date: Fri, 7 Nov 2014 00:01:45 +0100
Message-ID: <201411070001.46481@pali>
References: <20141104205117.GA17606@amd> <20141106180335.GA21513@earth.universe> <20141106225005.GA14002@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6350092.FCnsWLNFgr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141106225005.GA14002@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

--nextPart6350092.FCnsWLNFgr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 06 November 2014 23:50:05 Pavel Machek wrote:
> > > What is needed to get voice calls to work?
> >=20
> > There's still a kernel driver missing in mainline for
> > exchanging voice data between the modem and the cpu (called
> > cmt-speech).
> >=20
> > BTW the CMT driver should be removed from your kernel tree;
> > its a deprecated variant of mainline's nokia-modem driver.
> > Thus I guess the cmt-speech driver, which is available in
> > your kernel tree, is not properly integrated into the
> > changes I did during mainlining the other modem related
> > drivers.
>=20
> Aha, so CONFIG_CMT is the same thing as CONFIG_NOKIA_NODEM?
> Ok, will disable that. Speech... if you'd have version I
> could test, I'll happily do that.
>=20
> Thanks,
> 									Pavel

=46or voice calls you need:
* kernel driver cmt-speech (or it has some new name)
* cmt-speech userspace library (communication with kernel)
* pulseaudio modules which are using that library

=46reemangordon (Ivaylo Dimitrov, CCed) should know more about it,=20
specially about pulseaudio modules...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6350092.FCnsWLNFgr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlRb/doACgkQi/DJPQPkQ1KT3gCfeVcP50c4JB3diziGMrDrNka0
oiEAoIuH7eWygsYS2PjOwa0riQBFd+8x
=tdIT
-----END PGP SIGNATURE-----

--nextPart6350092.FCnsWLNFgr--

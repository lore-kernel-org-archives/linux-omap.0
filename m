From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Fri, 29 May 2015 00:27:21 +0200
Message-ID: <201505290027.21231@pali>
References: <20131206213613.GA19648@earth.universe> <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com> <20150528222412.GM30984@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2873422.ihz4BV8RMA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150528222412.GM30984@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Reichel <sre@ring0.de>, linux-omap <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, lkml <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart2873422.ihz4BV8RMA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 29 May 2015 00:24:13 Tony Lindgren wrote:
> * Matthijs van Duin <matthijsvanduin@gmail.com> [150528 13:28]:
> > On 28 May 2015 at 18:01, Tony Lindgren <tony@atomide.com> wrote:
> > > For failed device access you get an interrupt
> >=20
> > Well for failed reads you get a bus error, and "catching" those
> > (e.g. using the existing exception mechanism used to catch MMU
> > faults) is the whole issue.
> >=20
> > Though now that you mention it, it is true that for writes you
> > won't get any fault (at least on the DM814x and AM335x the posting
> > point appears to be the async bridge from MPUSS to the L3
> > interconnect) but an interconnect error irq instead. It may be
> > easier to make some kind of harmless write (e.g. to the version
> > register), wait a bit, and check if the write triggered an
> > interconnect error.
> >=20
> > Feels hackish though: you'd need to be sure you waited long enough
> > (though using a read from another device on the same L4
> > interconnect should be a reliable barrier in this case), and
> > drivers for receiving/interpreting interconnect errors are not
> > implemented yet on all SoCs (for some, like the AM335x, TI didn't
> > even bother publishing the relevant data in its TRM). Interconnect
> > errors can also be lost in some cases (multiple errors involving
> > the same target in a short time window) though that problem
> > shouldn't arise in this particular case.
>=20
> Hmm I believe the interrupt happens immediately trying to access an
> invalid device. But maybe I'm thinking about just errors if a device
> is not powered or clocked. So obviously some experiments need to be
> done :)
>=20
> The advantage here would be that the l3 driver actually already knows
> quite a bit about the devices on the bus.
>=20
> > Also, presumably interconnect error reporting is unavailable on HS
> > devices given the fact that all interconnect registers seemed to be
> > inaccessible?
>=20
> Oh OK yeah then that would not work for Pali's case. I guess it just
> needs to be tested.
>=20
> Regards,
>=20
> Tony

Ok, thanks for info. Do you have some quick small patches for testing?=20
Or some pointers what is needed to modify and how?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2873422.ihz4BV8RMA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlVnlkkACgkQi/DJPQPkQ1IYsACdG47flm6/JReQuk5++1WGVjCO
53cAn10gPl8wLuSW8DKxEuMcPxDZTbpd
=/OoG
-----END PGP SIGNATURE-----

--nextPart2873422.ihz4BV8RMA--

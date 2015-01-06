From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 20:59:01 +0100
Message-ID: <201501062059.01617@pali>
References: <20150105230228.GO4081@atomide.com> <20150106165903.GF4025@atomide.com> <20150106194443.GH30544@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart67678647.IkPFkXBF3N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36132 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbAFT7I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 14:59:08 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so29852330wgh.23
        for <linux-omap@vger.kernel.org>; Tue, 06 Jan 2015 11:59:05 -0800 (PST)
In-Reply-To: <20150106194443.GH30544@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sebastian Reichel <sre@kernel.org>

--nextPart67678647.IkPFkXBF3N
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 January 2015 20:44:43 Aaro Koskinen wrote:
> Hi,
>=20
> On Tue, Jan 06, 2015 at 08:59:03AM -0800, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [150106 00:03]:
> > > On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> > > > Revert "ARM: dts: Disable smc91x on n900 until
> > > > bootloader dependency is removed". We've now fixed the
> > > > issues that caused problems with uninitialized hardware
> > > > depending on the bootloader version. Mostly things got
> > > > fixed with the following commits:
> > > >=20
> > > > 9a894953a97b ("ARM: dts: Fix bootloader version
> > > > dependencies by muxing n900 smc91x pins") 7d2911c43815
> > > > ("net: smc91x: Fix gpios for device tree based
> > > > booting")
> > > >=20
> > > > Note that this only affects the early development boards
> > > > with Ethernet that we still have in a few automated boot
> > > > test systems.
> > > >=20
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >=20
> > > Normally, the early development boards should have
> > > separate dts file (then include common parts), no?
> >=20
> > In this case it won't matter. The GPMC hardware is there,
> > the probe just fails if no smsc91x is found.
> >=20
> > > Could you at least add a note to the dts file what is it?
> > > Because I always thought it is a bug.
> >=20
> > Sure, updated patch below. Can somebody please test boot it
> > on a production n900 too to make sure it no longer causes
> > issues?
>=20
> Seems to work fine with normal n900.
>=20
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
>=20
> I also tested with a development board, eth0 seemed to appear,
> but couldn't configure the MAC address with busybox ifconfig.
> How should it be done, I guess the interface does not have any
> MAC by default?
>=20
> A.

Should not kernel generate some random mac address if driver does=20
not provide one?

You can try to set (temporary) mac address to if with ifconfig:

$ ifconfig eth0 hw ether <mac>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart67678647.IkPFkXBF3N
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSsPoUACgkQi/DJPQPkQ1LzTwCbBHLN0mshW0ydkJ+Xc+SlFIqg
yjMAnRikwL7PQ73RiQIP3yIGRkFimlvi
=Pikj
-----END PGP SIGNATURE-----

--nextPart67678647.IkPFkXBF3N--

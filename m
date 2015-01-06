From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Tue, 6 Jan 2015 21:34:48 +0100
Message-ID: <201501062134.48963@pali>
References: <20150105230228.GO4081@atomide.com> <20150106195454.GW4081@atomide.com> <20150106201758.GX4081@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1591609.kznBnfDBl7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:62103 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbAFUex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 15:34:53 -0500
Received: by mail-wg0-f49.google.com with SMTP id n12so793wgh.22
        for <linux-omap@vger.kernel.org>; Tue, 06 Jan 2015 12:34:52 -0800 (PST)
In-Reply-To: <20150106201758.GX4081@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sebastian Reichel <sre@kernel.org>

--nextPart1591609.kznBnfDBl7
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 06 January 2015 21:17:59 Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150106 12:01]:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [150106 11:47]:
> > > Hi,
> > >=20
> > > On Tue, Jan 06, 2015 at 08:59:03AM -0800, Tony Lindgren=20
wrote:
> > > > * Pavel Machek <pavel@ucw.cz> [150106 00:03]:
> > > > > On Mon 2015-01-05 15:02:29, Tony Lindgren wrote:
> > > > > > Revert "ARM: dts: Disable smc91x on n900 until
> > > > > > bootloader dependency is removed". We've now fixed
> > > > > > the issues that caused problems with uninitialized
> > > > > > hardware depending on the bootloader version.
> > > > > > Mostly things got fixed with the following commits:
> > > > > >=20
> > > > > > 9a894953a97b ("ARM: dts: Fix bootloader version
> > > > > > dependencies by muxing n900 smc91x pins")
> > > > > > 7d2911c43815 ("net: smc91x: Fix gpios for device
> > > > > > tree based booting")
> > > > > >=20
> > > > > > Note that this only affects the early development
> > > > > > boards with Ethernet that we still have in a few
> > > > > > automated boot test systems.
> > > > > >=20
> > > > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > >=20
> > > > > Normally, the early development boards should have
> > > > > separate dts file (then include common parts), no?
> > > >=20
> > > > In this case it won't matter. The GPMC hardware is
> > > > there, the probe just fails if no smsc91x is found.
> > > >=20
> > > > > Could you at least add a note to the dts file what is
> > > > > it? Because I always thought it is a bug.
> > > >=20
> > > > Sure, updated patch below. Can somebody please test boot
> > > > it on a production n900 too to make sure it no longer
> > > > causes issues?
> > >=20
> > > Seems to work fine with normal n900.
> > >=20
> > > Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >=20
> > OK good to hear, thanks for testing.
> >=20
> > > I also tested with a development board, eth0 seemed to
> > > appear, but couldn't configure the MAC address with
> > > busybox ifconfig. How should it be done, I guess the
> > > interface does not have any MAC by default?
> >=20
> > You need to write the eeprom with ethtool from Linux,
> > something like this:
> >=20
> > Run u-boot/tools/gen_eth_addr to generate a random local
> > mac, then swap the bytes for it for big endian. Enter them
> > into a file with hexedit in big endian order. Then just do:
> >=20
> > # cat mac | ethtool -E eth0 offset 0x40 length 6
> >=20
> > Then ethtool -e eth0 should show you the configuration.
>=20
> Oh and I have some u-boot patches that I'll post that allow
> booting n900 with bootz and to use smsc91x tftp booting. I'll
> try to post those shortly..
>=20
> Regards,
>=20
> Tony

N900 uboot support is broken, see my email on uboot ML with=20
bisected commits:

http://lists.denx.de/pipermail/u-boot/2015-January/200154.html

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1591609.kznBnfDBl7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSsRugACgkQi/DJPQPkQ1Lt/wCgxubzkhRPLvIvwQ4UUs1GSFB2
6BEAn0cw/XWYqgOjjlCPSz35iQ8mv7m5
=FGGg
-----END PGP SIGNATURE-----

--nextPart1591609.kznBnfDBl7--

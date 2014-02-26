From: Sebastian Reichel <sre@ring0.de>
Subject: Re: Help running latest linux-omap kernel on Nokia N810
Date: Wed, 26 Feb 2014 19:53:32 +0100
Message-ID: <20140226185331.GA17632@earth.universe>
References: <c57950d5cfbbdcf952b9fceb4cd243d4@doppler.thel33t.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:52587 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbaBZSxi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 13:53:38 -0500
Content-Disposition: inline
In-Reply-To: <c57950d5cfbbdcf952b9fceb4cd243d4@doppler.thel33t.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 26, 2014 at 06:24:36PM +0000, Leigh Brown wrote:
> I have built the latest linux-omap git tree for my N810 but when I
> boot it I get a black screen with the backlight on.
>=20
> Does anyone have a working .config that they could share with me?
>=20
> During my investigations I have discovered that the kernel
> configuration has changed enormously in the last couple of years.  I
> was worried that the N810 was no longer supported at allm especially
> when I saw that a few of the old drivers (blizzard) had been
> removed.  I was pleasantly surprised when I discovered that a lot of
> the old drivers had been replaced by new ones.
>=20
> I will document the latest state of play with the N810 once I have
> got things going.  All I really want is a text console with working
> keyboard and wifi, initially.
>=20
> Any help will be gratefully received.

I can't help much, because I do not own any N8x0 device, but you
should probably visit [0] (and update it once you get stuff working
:))

The omap platform is currently moving over to Device Tree [1] based
booting, so you come at the right time to test DT based booting on
your N810. Building a DT kernel for your N810 works like this:

enable the following config entries:

CONFIG_ARM_APPENDED_DTB=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=3Dy
CONFIG_PINCTRL=3Dy
CONFIG_PINCTRL_SINGLE=3Dy

and build zImage like this:

$ export ARCH=3Darm
$ export CROSS_COMPILE=3Darm-linux-gnueabi-
$ make zImage
$ make omap2420-n810.dtb
$ cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > zImage

Be aware, that the DTS file seems to lack display & keyboard support
at the moment, so you may want to start building a serial adapter
first. See [2] for details on this. This may seem like lots of work,
but it really makes things much easier.

[0] http://elinux.org/N800
[1] http://devicetree.org/
[2] http://bues.ch/cms/hacking/n810-serial.html

-- Sebastian

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTDjgrAAoJENju1/PIO/qaqaAP/2rLF8b44ajEpuq1n5mN67AS
wK01FmwdfToD/xYI4Gdy/7cvYm3mbFJujMN/FFdHLifKCUaVp5k6C9JW0OVbxpCQ
FqArosnllfWYWNCY83KYGVhkPp0Hth/VllfbWgTtkPPLFTucCZEA0yu+MQN8SxJi
SYOCz1bqmWgN8Fc55e02LDravWiqdmV/KpgYcs8xINDoTk4xlVkO7MSxsO/OdcWx
17xeI4Au4YiAXM4c5i6KXqyt88ugt52652T2N9kKN/9bMBf/BEqt4RsQ8K7gK7wf
7ue9pA/MhR7aQTnmxwhN5mtDY0F3+rjyciIVtwSiICsSgLIqWi0RfraVaBzShEo6
C2R1GXRjKoCXBqB6+aYJgQ+r6ofG0uWL2mlUOefq2+UM4Goovqm62eUUYLI40ySx
iDatWyEciEVL8Uwsu4dzJmu+QZgRTWGk18Gd+z18Hy7G9+ycTMkgAOIicrED7+kZ
HsNVXqXAlVLnbsD4d/i4+HLrqO2Tugf/MBRsx/Az9Up2rxQeozEfyygD0RKCVovo
0R8qFzZZ9pxMq0jrlbqjmsEXxg4ExAv12pB6cq/iOAQ5Fm/NE6f2yak6ieHw0974
Mp8w70ydo3+1Lr3aOzY66cjR1g4GmhoADQL+nfJ7pecVMgWPViG+hJYZ7X2rYIM/
hImXlgco1B0D2h/hcN4J
=nayh
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: Kconfig help descriptions
Date: Thu, 21 Jul 2011 12:57:03 +0300
Message-ID: <20110721095702.GP23253@legolas.emea.dhcp.ti.com>
References: <20110721092221.GA28942@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NwG7NuG0/W8LcLh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:42009 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751318Ab1GUJ5I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 05:57:08 -0400
Received: by ewy8 with SMTP id 8so1266132ewy.26
        for <linux-omap@vger.kernel.org>; Thu, 21 Jul 2011 02:57:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110721092221.GA28942@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Keerthy <j-keerthy@ti.com>


--/NwG7NuG0/W8LcLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 21, 2011 at 10:22:21AM +0100, Russell King - ARM Linux wrote:
> Some of the Kconfig help descriptions aren't very useful - for example:
>=20
> | CONFIG_TWL4030_MADC:
> |=20
> | This driver provides support for triton TWL4030-MADC. The
> | driver supports both RT and SW conversion methods.
> |=20
> | This driver can be built as a module. If so it will be
> | named twl4030-madc
>=20
> What is madc?  What does it do?  Do I enable it for the OMAP 4430SDP ?

the problem seems to be worse then you thought:

$ git ls-files drivers/  | grep madc
drivers/hwmon/twl4030-madc-hwmon.c
drivers/mfd/twl4030-madc.c

Both from the same author:

$ git grep -e MODULE_AUTHOR drivers/mfd/twl4030-madc.c drivers/hwmon/twl403=
0-madc-hwmon.c
drivers/hwmon/twl4030-madc-hwmon.c:MODULE_AUTHOR("J Keerthy");
drivers/mfd/twl4030-madc.c:MODULE_AUTHOR("J Keerthy");

but added on different commits:

commit f99c1d4f94f91fd3a20bd2eaa3be9c5e7d2668eb
Author: Keerthy <j-keerthy@ti.com>
Date:   Tue Mar 1 19:12:26 2011 +0530

    mfd: Add twl4030 madc driver
   =20
    Introducing a driver for MADC on TWL4030 powerIC. MADC stands for monit=
oring
    ADC. This driver monitors the real time conversion of analog signals li=
ke
    battery temperature, battery cuurent etc.
   =20
    Signed-off-by: Keerthy <j-keerthy@ti.com>
    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>

commit 0070bddfe7275e5bc763884a8ac59651f4e79eab
Author: Keerthy <j-keerthy@ti.com>
Date:   Tue Mar 1 19:12:36 2011 +0530

    hwmon: twl4030: Hwmon Driver for TWL4030 MADC
   =20
    This driver exposes the sysfs nodes of the TWL4030 MADC module.
    All the voltage channel values are expressed in terms of mV. Channel 13
    and channel 14 are reserved. There are channels which represent
    temperature and current the output is represented by celcius
    and mA respectively.
   =20
    Signed-off-by: Keerthy <j-keerthy@ti.com>
    Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
    Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>


--=20
balbi

--/NwG7NuG0/W8LcLh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJ/fuAAoJEAv8Txj19kN1u3QH/jJRqx+xg0ScRvBfzWJWl0B7
F3ldC/eoT4ehzR3fNN3ElWmTEjh1QigWh8AAdnsQS8by6X31+wFjtIn8pHKAxAo8
gZho9whJ+/8uzBFog2IOz9uJv+ds9bxlPHWQGRDEkzpSB87v3ZcShlYi8GWssdrX
IYGU0bQg60ahWpeCU4ftdQqDhivBN7o0fm6Z8HXQPOt894tGcJltLk21x1HxVB3R
TBkMVoSO+mKyGGzz40NYsJyWIG6i8V2v6hyiMN3MOttvSdtzOpOKG6uoaXKfOQOA
qnJYh8Cc9euXyLcFAhUSfGc+Gaw0tnfLNqY3BPZa6bJIPfDN4Lzxdu+FqJldDmA=
=K6m9
-----END PGP SIGNATURE-----

--/NwG7NuG0/W8LcLh--

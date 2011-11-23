From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 25/26] OMAP: PM: convert the SmartReflex code into the
 AVS driver framework
Date: Wed, 23 Nov 2011 11:51:21 +0200
Message-ID: <20111123095120.GD25068@legolas.emea.dhcp.ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
 <1321974370-25800-26-git-send-email-j-pihet@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:54243 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753334Ab1KWJvZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 04:51:25 -0500
Received: by mail-yx0-f170.google.com with SMTP id l2so2359395yen.1
        for <linux-omap@vger.kernel.org>; Wed, 23 Nov 2011 01:51:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1321974370-25800-26-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2011 at 04:06:09PM +0100, jean.pihet@newoldbits.com wrote:
> +config POWER_AVS_OMAP_V1
> +	tristate "AVS support for the OMAP IP version 1"
> +	depends on ARCH_OMAP3 && PM
> +	help
> +	  Say Y to enable AVS support on OMAP containing the version 1 of
> +	  the SmartReflex IP.
> +	  V1 is the 65nm version used in OMAP3430.
> +
> +	  Please note, that by default SmartReflex is only
> +	  initialized. To enable the automatic voltage
> +	  compensation for vdd mpu  and vdd core from user space,
> +	  user must write 1 to
> +		/debug/voltage/vdd_<X>/smartreflex/autocomp,
> +	  where X is mpu or core for OMAP3.
> +	  Optionally autocompensation can be enabled in the kernel
> +	  by default during system init via the enable_on_init flag
> +	  which an be passed as platform data to the smartreflex driver.
> +
> +config POWER_AVS_OMAP_V2
> +	tristate "AVS support for the OMAP IP version 2"
> +	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM
> +	help
> +	  Say Y to enable AVS support on OMAP containing the version 2 of
> +	  the SmartReflex IP.
> +	  V2 is the update for the 45nm version of the IP used in OMAP3630
> +	  and OMAP4430

can't you read the revision register and decide this in runtime ?

--=20
balbi

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOzMIXAAoJEIaOsuA1yqREGuwP/ApCYt9tvlLu6urQfa9qksvT
1KzDBeoiRfOFlSXf5lrFLE325Bls5F3JU/ABe0ugUgIEakMf34nZntk61gCmfnYc
GNFoIweVmOiHnhvYwrP7pEnY68LMtU6WOTo/tUhvTNXzVUhp/qNBPKP5CKo97nR8
+wObpbMqyCSDds3KLL8fYzPtpDHbOIwkVaP4JPpIC6ECdnfQwmJeN97wnvPUIrwW
FZw8UoAaN6rq9qRa0XJOccHKm88YmxmYsSfR7c78AAraFv3pBFmk392nU1jAmh1k
0exKOpW4sO6JxbyWMHLEH+qnjyPkh6DA3ejg9V7Myi/7tnCgqJV+xRBzeEwG2j0d
BGjVOqtO7RuMkvwccLDqPTBEVxSAlp4aZRwsiYbfB5/oxkpGMyccYDBLyf3GRGKR
EgY4fbECJw3wYaxVXeEVCSoVhP1kG+9FS4MppT8GauPgQJAfO959z7Thg9zj5eVC
T7TAxua6pcNhbYwMe1QKv1hcE7d2L/6Rn4ykwein9qlVcPYx1TR8eSeBL06DyNWl
8J4rhJ7mURijWS9Efr/tz4iHVkKQPTedLVIXrNXjftGhr575Q4+0eEPXTdYB1gNP
ZL3fYYS7wmBTTnMbr6SzPK7ZFad9AhlevhrsQOPif1NW/dgloZjl7xRR72CKoZyV
f+DX878uZ+1DvyWkEKvq
=dTze
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--

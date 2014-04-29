From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Tue, 29 Apr 2014 19:32:59 +0300
Message-ID: <535FD43B.3030102@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com> <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com> <535A5C0A.7040808@ti.com> <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com> <535DFAAE.1010606@ti.com> <20140428164528.GM20807@atomide.com> <535F37E9.8090609@ti.com> <20140429150529.GA27571@atomide.com> <535FD10B.4020108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="MASFNKrA5RQqjQn8IqeUa8CIHkvFAh93G"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33284 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933428AbaD2QdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Apr 2014 12:33:25 -0400
In-Reply-To: <535FD10B.4020108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--MASFNKrA5RQqjQn8IqeUa8CIHkvFAh93G
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 29/04/14 19:19, Tomi Valkeinen wrote:
> On 29/04/14 18:05, Tony Lindgren wrote:
>=20
>>> omap4_padconf_global is a syscon node, not pinctrl. As syscon just gi=
ves
>>> a raw regmap to its memory area, the driver needs to know about the O=
MAP
>>> control registers to use it.
>>
>> That would be probably best set up the same way we have already set up=

>> for example omap4_padconf_global: tisyscon@4a1005a0. Then drivers can
>> access it using regmap, see how drivers/regulator/pbias-regulator.c
>> sets up the pbias regulator with regmap for MMC.
>=20
> Right, but it means that the driver will contain platform specific code=

> for all the omap revisions it supports. Isn't that wrong?
>=20
> I already have a patch for DSI that uses the syscon-method, and it work=
s
> fine. But it's quite ugly, imo, to fiddle with the OMAP control
> registers in a driver.

Oh, also, if I do that, I need to know both the SoC version and the DSS
version in the driver.

 Tomi



--MASFNKrA5RQqjQn8IqeUa8CIHkvFAh93G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTX9Q7AAoJEPo9qoy8lh71VVEP/2pBCMTiBGRW6eQIWFE2ht9p
OyQkmnsOUAP8oyQyPgnl+PgQpyi9WDxyLtAeScL6cnMU93yCID+p8GCoLRnEAYg4
/h5ndWrvQ1S0XOXZnmRh04A8zU95Mp1lotVMgwoaquWuVSAWLDRfo3kqkx84Mps9
0/qlashsTsFrM0BbVlusJprY0VwcQDtQwC0bb/vGxQcLo+UctfmzXLRc6Fkdk5Uf
OVIOVCKc/20XYmrgSuOY5oa/x4JwBZ4N37EUQhSE9/hrbbBnL78O8oJQatRnZ6YN
bXmdcTHSZtpmB2OJ7LJ2hz32hQ8Tj127rWdOd9xaXmmvr92NTi/E4ArCZ37I+vUB
PkyzdV477LTMfdugHZl6uWdHAd3O7FdJtmIQ7aOsLLCDAnye/bGOZDxmAWzaB30l
Pk/ySZY0rTDIniL1/9UTlhalEzkEiFcazbvQTMWmpFx5j29omuTpzJ7a+4tA5Ku1
FodrgvwbaryeoRlXBPWyrHTfLDV9q8OO31Zq8tb2rBSs5WdHOfs0XOM93myX1ClS
ugfRBV2U7ns3fEH1RAk2cDNN+bZ2U7BehqfeWkT5h+oflp6BJdbjfVFDp9qZaCJ6
6Jcsl5FIODp7r/+O4f649WfIwjLuvYNqu4ksyzm99/9rT1fmOSHUJafVi2jTSuDo
vTlKbU+WWhK0PVIBgFkC
=IEz3
-----END PGP SIGNATURE-----

--MASFNKrA5RQqjQn8IqeUa8CIHkvFAh93G--

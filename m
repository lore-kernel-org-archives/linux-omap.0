From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv9 4/5] regulator: twl4030: add support for external
 voltage get/set
Date: Thu, 16 Feb 2012 08:29:20 -0800
Message-ID: <20120216162919.GD3383@opensource.wolfsonmicro.com>
References: <1329388073-17879-1-git-send-email-t-kristo@ti.com>
 <1329388073-17879-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48059 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750877Ab2BPQ3Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 11:29:25 -0500
Content-Disposition: inline
In-Reply-To: <1329388073-17879-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2012 at 12:27:52PM +0200, Tero Kristo wrote:
> This is needed for SMPS regulators, which use the OMAP voltage
> processor for voltage get/set functions instead of the normal I2C
> channel. For this purpose, regulator_init_data->driver_data contents
> are expanded, it is now a struct which contains function pointers
> for the set/get voltage operations, a data pointer for these, and
> the previously used features bitmask.

Applied, thanks.

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPPS6yAAoJEBus8iNuMP3dZwsP/2Gbk10xE9jmOG4/0NRRnD1T
oueRUnNGqtqSqCh5kag7HtvtXda1yR1Q6oE77n8XxodINUVTFn2rhpT7pdmqpwuw
BO0vg7CfQ+gNgnGCnRXGncpxLaUgFU1/igPJgOgelbhCBCzCFKz7F58Xe4D+mk0G
ICqkAnwqCYPQ1khM2GPzIJDaPGg9oC9diPMT3U/9DW9/2hwPQpeFUjn/Q2MNKN8H
2p/YWf22qYcS4YE0aiAfW1b0aPV7kHWfVU6Cc2A49K9RGS9U5WPNw8wTThkEGUjh
1i3PEmgff84geI/kony5pRYYbNIy1rdFk+rGBE/tp1EmCxtFWDNVjhUfDFWg5wYr
+zFMdqzjr4HabhlillCKXNbPkIWLE/iH9TO4ot3DIKxM1GJlmguUXxlOaSW8BTfj
8doOjQo8zFoalo5N3+MrZSppTKPthGV0PkQUiImdttatUWOsX9Cos7mR3wF9q1b0
VhofRT4kGx3DFzB7ar2Shdji79PZBkW20r3ek0G7xx9L2mwEFdVxDStycXZp7q28
uDeld6F5TXlsLN5zeqG11Deid8gGTANkKQuLlBTkKTJSpNOQVk2rjfkYQhX05Czo
elMuCgwdSd6uETsNvsi5azzNejZ5tEhwUDsEQ7N0K/GMpoAH7piDrhLOSmmL+s8b
v5kdFu0c7m/10zD9ykq3
=PBPt
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--

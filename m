From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND 1/4] ARM: OMAP2+: AM33XX: Add tps65910 device tree
 data
Date: Mon, 23 Jul 2012 14:34:00 +0100
Message-ID: <20120723133400.GU4435@opensource.wolfsonmicro.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-2-git-send-email-anilkumar@ti.com>
 <20120720095935.GQ4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9FA91E@DBDE01.ent.ti.com>
 <20120720113806.GW4495@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA01F1E@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O9T4zNOkGnr0n+A/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46785 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751325Ab2GWNeD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 09:34:03 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA01F1E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lee.Jones@linaro.org


--O9T4zNOkGnr0n+A/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2012 at 01:23:50PM +0000, AnilKumar, Chimata wrote:

> By the way, if we look at all the regulator added (DT supported) till now have
> the similar problem.

> arch/arm/boot/dts/imx6q.dtsi

This is fine - the SoC contains integrated regulators which supply other
bits of the Soc so we can be confident that the hookup is good just
based on the silicon.

> arch/arm/boot/dts/twl4030.dtsi
> arch/arm/boot/dts/twl6030.dtsi

These appear to have similar issues and should be fixed, at least as far
as the voltage ranges go.

> arch/arm/boot/dts/db8500.dtsi

I'm not actually seeing anything terribly problematic here, though the
regulator-name properties should really be removed as they're fairly
useless and seem to be missing the point of having the property.

--O9T4zNOkGnr0n+A/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDVK0AAoJEBus8iNuMP3dwgYP/2R7vbNG3N/Rw323Gl/+hLwh
NiOYnRbs1vgDRvdHjf4JGMZaCBoan74l6Mk7B0ahk46K0Afo62Os7OoszH0RrF+d
AFvPjAE/V7ys5AhINOtCsEX3EwzHeaKwWTOdybm11k4QQMOy96YDwt8sq4C+hK5J
VESBMtSQywdadEatCodk0BZJLhINRA9H7dAba59ulhVwjiuQY6FPBIVojzh7BWjJ
E6ISdBlwRHUajrjswx+XLI8aioFJOuuFD9Z6v75T82xKpA57lLlZX0wprLkhm+aT
7qClWRAx9E6Jl5vM1l4NeqGQL6godvWnTMkWeCa/bfYPC9uNAOTrfAp/BZNuWK72
1Ewed/1aWxKpm6qRLT7lRLivLJ+ddol9n5yLOuTNOUcXdDvrb5Bg1Pk5EO86Cag9
iBw9P8V2FDCYgW0Olc2bWbznN5Tcc6UbaeR5BptPFhbPLICiGBkh5qHTGUEQ7fyU
rFTP7ZVZ8dnaQHLNQoGPyAHhB/v4WrDVvcpSThuTrnixGK3yj4zwbbpGJNdq148/
FL3CDJz5T5TMXEQmYsxm0+vR/qHbFVDTQR9+MTXt9I+So7sKhwglHtuGyMsNoDox
Dj0l4MIMBHLdxoITKQd57YtvHjUF37mspFlAt6aUwGrmSBNsEJETcQzkYPnF12Bw
cMkSrvt5dt7K83AHT9H2
=weP2
-----END PGP SIGNATURE-----

--O9T4zNOkGnr0n+A/--

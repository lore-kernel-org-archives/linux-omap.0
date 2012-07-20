From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND 2/4] ARM: OMAP2+: AM33XX: Add tps65217 device tree
 data
Date: Fri, 20 Jul 2012 11:01:13 +0100
Message-ID: <20120720100113.GR4495@opensource.wolfsonmicro.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
 <1342766789-28148-3-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftQmbtOmUf2cr8rB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48979 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490Ab2GTKBO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 06:01:14 -0400
Content-Disposition: inline
In-Reply-To: <1342766789-28148-3-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org


--ftQmbtOmUf2cr8rB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 20, 2012 at 12:16:27PM +0530, AnilKumar Ch wrote:

> +		dcdc1_reg: regulator@0 {
> +			reg = <0>;
> +			regulator-compatible = "dcdc1";
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1800000>;

Same issue here.

--ftQmbtOmUf2cr8rB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQCSxWAAoJEBus8iNuMP3dgkQP/RIfjPZbs06b16meamuRWUTh
+iATIrwfsM1XXFxIkJqpdAp5b43HMDmueuhA22eVSjVNMk+PQ3I6E2J5+6jvUPMr
TepbUbRlMyjrnKiwuHHbkG9TjfTOgfahd6vs3DLmqf475s7XKnZlh55Z83+jRp5u
I71VY5hcMCkcpID1kVTvxUr8ys89ojy0V8ny19Lt+pbf6q+t4se6gNnG0K4VBJOj
4ULnET64Ex7oVDdj/daDHJZtLRDDAPy1OY2oDa2yrQyw0J1kCRYCeaPWw3icZVtR
soCCyfwCIISEX66i9MWUgAPf72HM+ZuAmBWSQqrcrQhNwZdXucNvaOIIULUltVv/
XnT9nFYaBjCrFOfewY7gUsK/NUh0tssF03njPtr2PztWR87q+f1PV2nuyMtKgWQZ
aGiwvPQAcWqr7T/C6d40sIqbUXLYBTBXxgRL2FjckXsjSTbwdTJgt5MUjjC6ibM7
7YQMkU4M/qhmuQZALju9IFeC0iX8gfSy19Ya4Kf8ZvcG302T25mMsD/1XIwISDe2
Q8P569rIvYUODXUJwsSFT38Yn4s0kPz5gL3PHkt/IbGNtDod2NBTjVRfAZXVRkrY
V7rl6uQ/h34i+5oFghOoaY6h9b8jBypq+cD09F0GO9bFAaGiYPzwWhOE7s5VEEC9
VmUCuZUOad77VTzuLLqf
=xzhN
-----END PGP SIGNATURE-----

--ftQmbtOmUf2cr8rB--

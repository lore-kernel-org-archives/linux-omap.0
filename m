From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: dts: DRA74x: fix DSS PLL2 addresses
Date: Tue, 7 Jun 2016 09:31:38 +0300
Message-ID: <57566A4A.4020102@ti.com>
References: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8727722595271376404=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8727722595271376404==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JU4VBHbP4WD1pkN3vbvti95nG2gSbdJhS"

--JU4VBHbP4WD1pkN3vbvti95nG2gSbdJhS
Content-Type: multipart/mixed; boundary="Gjp6k4DxWxbXIkHf5Gh2SiqL4MPmV32s9"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <57566A4A.4020102@ti.com>
Subject: Re: [PATCH] ARM: dts: DRA74x: fix DSS PLL2 addresses
References: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>

--Gjp6k4DxWxbXIkHf5Gh2SiqL4MPmV32s9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 20/05/16 13:13, Tomi Valkeinen wrote:
> DSS's 'pll2_clkctrl' and 'pll2' have wrong addresses in the dra74x.dtsi=

> file. Video PLL2 has not been used so wrong addresses went unnoticed.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/dra74x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.d=
tsi
> index 4220eeffc65a..5e06020f450b 100644
> --- a/arch/arm/boot/dts/dra74x.dtsi
> +++ b/arch/arm/boot/dts/dra74x.dtsi
> @@ -107,8 +107,8 @@
>  	reg =3D <0x58000000 0x80>,
>  	      <0x58004054 0x4>,
>  	      <0x58004300 0x20>,
> -	      <0x58005054 0x4>,
> -	      <0x58005300 0x20>;
> +	      <0x58009054 0x4>,
> +	      <0x58009300 0x20>;
>  	reg-names =3D "dss", "pll1_clkctrl", "pll1",
>  		    "pll2_clkctrl", "pll2";
> =20
>=20

Ping on this.

 Tomi


--Gjp6k4DxWxbXIkHf5Gh2SiqL4MPmV32s9--

--JU4VBHbP4WD1pkN3vbvti95nG2gSbdJhS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVmpLAAoJEPo9qoy8lh71F5oP/3p2DHfBdlow8XxxO2gUxRrL
H4P8n+6hTbw49YWllzkpWNijhtPLsbgZyEuaa18c/abHw12myz4zbTgUYY5tbmOE
CDu/oJd/g2Acusn62WZLaVfKC/t9E0kg4fqFTFqxQ3Wwq4SWKFBOEvlqjkX6Xcao
6B547sVSdEJKEz1xYkVct57JSgsMVHEurip7osjHadr4AOpct7bazbADJSP7aWoW
2eYLYvA8E7X3hkcQ2ehskAMhU63vZKDF2gCUZ/30f4ZYCEh0mfp7tg2p5UzYoLYX
JkRPV3OQDP3O3fTpnhyN/kmrVxYEPST/rWVgt/hEuZbhkmf/HYDNoSODuJRhffEy
8eN5Ro6TtOnygqcfwnljaEFnFBnYxIOmWse8M9DYuWMOFamgZgdObE3LfSv+nHPF
7iMf2GXPMHTobWnNlp8AwAks/bAzhKaCeVejSPCfs8ae5GVEdjNX65bvh37AkbtZ
8TPYkZtOfx7f03fOG/e9QOY9lNe0g/8/i64Mon8vkBR1MRfUoggh3k4FPqHs80uO
GXp2mE4ye/PbWcFBaKI5O4l5B6qZ9Uh2ageJc52plg0XOFyOAnV6qIfP0Wi3dsqf
PgA6LwLPmkJe/0lb41LhWdflKKAM6LKd2AGbQxmZ14gyLxFocN0Dx6OhBYgSgjLw
oKCF8ri1CedQ/anBvUNz
=oXTN
-----END PGP SIGNATURE-----

--JU4VBHbP4WD1pkN3vbvti95nG2gSbdJhS--


--===============8727722595271376404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8727722595271376404==--

From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv12 00/49] ARM: TI SoC clock DT conversion
Date: Fri, 20 Dec 2013 14:06:49 -0600
Message-ID: <20131220200649.GE3380@saruman.home>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51542 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab3LTUH4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 15:07:56 -0500
Content-Disposition: inline
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 06:34:19PM +0200, Tero Kristo wrote:
> Hi,
>=20
> Hopefully final post of this series. At least this is going to be the last
> post this year as I will be going to x-mas vacation and won't be back bef=
ore
> Jan 2nd. This time I just sent the patches that have changes in them,
> the missing ones are exactly the same as in v11.
>=20
> Changes done:
>  - most of the patches:
>    * Some cosmetic documentation fixes
>  - patch 06:
>    * Changed register pointer types from 'u32 __iomem *' to 'void __iomem=
 *'
>  - patch 07,08,09:
>    * Added check for clk->ll_ops being NULL (happens with statically built
>      clock data), fixes the boot time crash issue noticed by Tony
>  - patch 11:
>    * Moved __clk_of_table extern declaration to clk-provider.h header fil=
e...
>      Got flamed about this enough times now. :)
>    * Type for the declaration changed also from array to single entry,
>      and address for this used in code. This prevents compile time error:
>      "array type has incomplete element type". Can't use pointer here eit=
her
>      as this messes the address of the table.
>    * ti_clk_retry_init() now has int return type, and checks for kzalloc
>      failure
>  - patch 12, 14, 23:
>    * Added cleanup in case ti_clk_retry_init() fails
>  - patch 17:
>    * Fixed potential memory leak in failed init detected by sparse
>  - patch 18:
>    * Modified commit message to add some details about clockdomains
>  - patch 43:
>    * Changed register pointer types from 'u32 *' to 'void __iomem *'
>=20
> Testing done:
> - omap3-beagle: boot, suspend/resume (ret), suspend/resume (off)
> - omap4-panda-es: boot, suspend/resume (ret)
> - omap5-uevm: boot
> - am335x-bone: boot
> - dra7-evm: boot
>=20
> Branches available at https://github.com/t-kristo/linux-pm.git:
> - branch: 3.13-rc4-dt-clks-v12 : contains everything, shall me merged last
> - branch: 3.13-rc4-dt-clks-v12-for-mike : drivers/clk changes
> - branch: 3.13-rc4-dt-clks-v11-for-benoit : DT data only (from v11, no ch=
anges)

Still fails to build OMAP5-only defconfig:

drivers/built-in.o: In function `of_ti_composite_interface_clk_setup':
drivers/clk/ti/gate.c:190: undefined reference to `clkhwops_iclk_wait'
make: *** [vmlinux] Error 1

--=20
balbi

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJStKNZAAoJEIaOsuA1yqREeOUP+gJbPHDEEtGR6tDuUoq7gX/X
RStYT7TwAZi0aO64WgKYMabPZb7kfz9o2gQubnwkFzmJTDihUH/P0RLsmG/qv6WH
Ke+yl5Rl6f+7teJT5gn7iaVUS/cyZrsMOTRavZ+1QGJVzL9KhHbzjUyB1WCzGaUL
D1dEsvUxSmkffWrES8v+y+QYYgmC+ZurD+k2zsr69dG6GJTUnHSYaIUuFUHlFxfh
u3pkIQbeFc0PTr6i7/yzQlxoc6TnNtSViXKh+kJK5g5AwSsAnPkCSczJAJdZvhcE
bxfpkfWCVaQHqXt5BicbNdGLWEDJnY8rPlHA4OZvoofq/uhk/RGAZ4g/SOV3RDlK
pNQJt9Ev013MaXJRj5njIgOFNm/X3XI2nB5KgVVddCCwS9uprP3v9w6eKgaj/usq
QC/UZw1c70ggqQBxZGrwOXsFKS7ZOmUe0IuyRYEqZem/Ds8Kqu3if35g1Lpz1KEa
JzNMcmdGgcpUtDgmolqBD8qIhj2V0yfrkTTbNSBHbPhHGJjhVbVl2Szbw9aAisNK
JHdN1zKMIu/qy7IKzvwFtx4DJTO2Spdo368BfgG/eVVMBrQntKhl8226rj+KlZhJ
83+Rh9pMXWzvyLzO3+EKiIZ1VRBvdvMIV/Mzo9iJCwCnihOBOZ4vgJkYFVlsIpx4
SGOIDvWIG8MsQ/QhrLvU
=6rUt
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--

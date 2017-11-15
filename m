From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v4 01/16] dt-bindings: mtd: gpmc-onenand: Update
 properties description
Date: Wed, 15 Nov 2017 14:43:39 +0100
Message-ID: <20171115134339.jnvu6asy2srxsuko@earth>
References: <20171111211656.neoypp7gdyfasteg@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1564479448489881104=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111211656.neoypp7gdyfasteg@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============1564479448489881104==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tnecwij25oa4n76i"
Content-Disposition: inline


--tnecwij25oa4n76i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:16:56PM +0100, Ladislav Michl wrote:
> Compatible property is required for OMAP2+ mtd driver. Also
> add R/B pin gpio description and delete unused dma-channel
> property.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  -v4: new patch
>=20
>  Documentation/devicetree/bindings/mtd/gpmc-onenand.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Doc=
umentation/devicetree/bindings/mtd/gpmc-onenand.txt
> index b6e8bfd024f4..9d7b1409deab 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> @@ -9,13 +9,14 @@ Documentation/devicetree/bindings/memory-controllers/om=
ap-gpmc.txt
> =20
>  Required properties:
> =20
> + - compatible:		"ti,omap2-onenand"

I suggest to also add more specific compatible values (i.e.
"ti,omap3-onenand") in case it is needed later. They don't
hurt much and may prevent ugly hacks in the future.

>   - reg:			The CS line the peripheral is connected to
> - - gpmc,device-width	Width of the ONENAND device connected to the GPMC
> + - gpmc,device-width:	Width of the ONENAND device connected to the GPMC
>  			in bytes. Must be 1 or 2.
> =20
>  Optional properties:
> =20
> - - dma-channel:		DMA Channel index
> + - rb-gpios:		GPIO specifier for the ready/busy# pin.
> =20
>  For inline partition table parsing (optional):
> =20
> @@ -35,6 +36,7 @@ Example for an OMAP3430 board:
>  		#size-cells =3D <1>;
> =20
>  		onenand@0 {
> +			compatible =3D "ti,omap2-onenand";
>  			reg =3D <0 0 0>; /* CS0, offset 0 */
>  			gpmc,device-width =3D <2>;
> =20

-- Sebastian

--tnecwij25oa4n76i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMRIgACgkQ2O7X88g7
+pp2NQ/9ERKVONXl3dzp49r1/8EzE5dyNdDx8xfyRMRfyxqIAtoHzMbN2B55ZGvU
7imkrZntGH+Ba8tkGN5oA2dxwbj3Lo1nURNzeAuU4jLwI50nouZkP9DmIi3nBqu0
zSfxwq074+xbaQhI9I1SOsmzh8T/Vem+T1aJNAEDg6Mgnj4LK1/rF/BSR6IPuXpy
bBPoFlQ5/Cvi07SbR5kCYiLXtLtep/1Juuf1Pya/YysphNKE5FCZcqPAEV+Z8MmB
e4gNiOqk56TMm0xZc/iSrjj2uBXVqpsm4vLHhji9Zcpb5V+/0YQBR8eaBbUR0GNY
Ge6ODx+GeuD6nuP9jD11VzFr/1Zq0iSe/RqKN2RrgrnqOHG3MPSaO3pfH5BIZJGU
3VaAjyWHPHJ9Y/KREb1L1B9Hd5r+EvVyJiN8QvQsac0/zcRgJ/wsveLPOQzyB9aI
JNJd4EDm8JdEw16a8lRna6ITwqXthJco2aKMCZXom9MpypM6rnLiz+aFP3ousaj+
ds3ozqmH7BqZIkyV4ItaccguvdSDE6d7iV620O2g/1T/ZmfZ19fYbwdPdPP8DiHU
RXaKh+HV+qDGvO3xM0MfDEEh894bsdC4YpB940hLx0lPbl/gx2l37NrJ8hcx7WfT
s6uL8BbjLC70eyMyB1eckcREpvzAIdKFnCWqEHrnVvgr7eRcQJE=
=tP6F
-----END PGP SIGNATURE-----

--tnecwij25oa4n76i--


--===============1564479448489881104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1564479448489881104==--

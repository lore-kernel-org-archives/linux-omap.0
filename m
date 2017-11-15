From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 01/16] dt-bindings: mtd: gpmc-onenand: Update
 properties description
Date: Wed, 15 Nov 2017 16:42:11 +0100
Message-ID: <20171115154210.i3nbt2czpma6hi2w@earth>
References: <20171111211656.neoypp7gdyfasteg@lenoch>
 <20171115134339.jnvu6asy2srxsuko@earth>
 <20171115151206.g76k75lwq2jlezki@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5245291102160865442=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171115151206.g76k75lwq2jlezki@lenoch>
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


--===============5245291102160865442==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="myco2e2365k2z6mh"
Content-Disposition: inline


--myco2e2365k2z6mh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 15, 2017 at 04:12:06PM +0100, Ladislav Michl wrote:
> On Wed, Nov 15, 2017 at 02:43:39PM +0100, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Sat, Nov 11, 2017 at 10:16:56PM +0100, Ladislav Michl wrote:
> > > Compatible property is required for OMAP2+ mtd driver. Also
> > > add R/B pin gpio description and delete unused dma-channel
> > > property.
> > >=20
> > > Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> > > ---
> > >  Changes:
> > >  -v4: new patch
> > >=20
> > >  Documentation/devicetree/bindings/mtd/gpmc-onenand.txt | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b=
/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > > index b6e8bfd024f4..9d7b1409deab 100644
> > > --- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > > +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> > > @@ -9,13 +9,14 @@ Documentation/devicetree/bindings/memory-controller=
s/omap-gpmc.txt
> > > =20
> > >  Required properties:
> > > =20
> > > + - compatible:		"ti,omap2-onenand"
> >=20
> > I suggest to also add more specific compatible values (i.e.
> > "ti,omap3-onenand") in case it is needed later. They don't
> > hurt much and may prevent ugly hacks in the future.
>=20
> We tried hard to avoid anything omap3 specific (it was present in earlier
> versions of this patchset). And NAND driver is also okay with "ti,omap3-n=
and"
> (I know it is a poor argument). So far all OMAP2/3 differences seems to c=
ome
> from both devices unavailable to the person who did the code change.
>=20
> While I agree it is in general good idea, I have personal problem with th=
at
> as there are devices in field with "ti,omap2-onenand" compatible and OMAP=
3530.
>=20
> See this function:
> http://git.denx.de/?p=3Du-boot.git;a=3Dblob;f=3Dboard/isee/igep00x0/igep0=
0x0.c;h=3D5c7f2567118a1e17bdb6f76f29a7161628776bf7;hb=3DHEAD#l158
> Board comes either with NAND or OneNAND, bootloader detects that and
> enables proper node. Updating bootloader is potentially dangerous, so I'd
> like to avoid that.
>=20
> However, if you insist on idea above, I'm okay with keeping some of tree
> patches for a while...

The best practice for DT bindings is to have a specific compatible
and a generic fallback. Something like

compatible =3D "ti,omap3-onenand", "ti,omap2-onenand";

You can just ignore the "ti,omap3-onenand" in the driver for now.
Just add it to the bindings and the DTS files. Then it is there in
case it is needed at some point.

-- Sebastian

> > >   - reg:			The CS line the peripheral is connected to
> > > - - gpmc,device-width	Width of the ONENAND device connected to the GP=
MC
> > > + - gpmc,device-width:	Width of the ONENAND device connected to the G=
PMC
> > >  			in bytes. Must be 1 or 2.
> > > =20
> > >  Optional properties:
> > > =20
> > > - - dma-channel:		DMA Channel index
> > > + - rb-gpios:		GPIO specifier for the ready/busy# pin.
> > > =20
> > >  For inline partition table parsing (optional):
> > > =20
> > > @@ -35,6 +36,7 @@ Example for an OMAP3430 board:
> > >  		#size-cells =3D <1>;
> > > =20
> > >  		onenand@0 {
> > > +			compatible =3D "ti,omap2-onenand";
> > >  			reg =3D <0 0 0>; /* CS0, offset 0 */
> > >  			gpmc,device-width =3D <2>;
> > > =20
> >=20
> > -- Sebastian
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--myco2e2365k2z6mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMYFAACgkQ2O7X88g7
+pqi4g//Rh3PZvaqWjJ4VqMBRVaI4Ix+PyUGPQhCWRUpK+Ql75E5TPJnB2Vtik1O
deXXAPqqzxAkHq2Lv+xHchTl4ZL/PGosKt/FjHx14kD/0Cwk5DLNL+FZI3u2laGn
A00QAo5dFdPUzMNDp+l6mUiandBkYWMJfnDOA1/H0MIK+uAC9WlWTKecT4Z66Aom
N0mD8HK72KOVY3h2GNmY42sjbWf8tt1XUkMdWsOzRsNsx1+6QlFv0IpIKPveu4lc
vEd3G1rmZkzDM6lW+OP2r7MhFSie/hhViixZtmR4faGV2Ro6d/NH2Sm/gKmFHFGr
CMLhJMMQ4rP6MY4KB0wqpINOLACpWAnOQXRwYZnZYnK/zNqzs7CoRwMok6o2HUPt
jHf8kPIVNbOLM5yj3oehu1szUP1b+ljtIxwMtV+yITUiiaPXHSG/F0zBlikE+HnU
5k2I/h9LudoLH4ahVNh83VjFONnR0/0IxTXctY4kvh7Em+o8Z4WKK0FFuMEzSzfQ
3fImgqeDF/aXEKhr97eMJIRPVhyVJPHlRH6/Xw11qU1qARfRqdgRzKaiaHjipN0u
IiD91vQTA7E/Z+NsFnG8k0OXhHVANfv3cYNdiQCyDdN3ujrsG95cvcDt1uYnEk06
ue0f0QRaAzwjY5Ov9AKwoCg8Engj9+3oGE3oidS0+wekr5eUSIE=
=m+mh
-----END PGP SIGNATURE-----

--myco2e2365k2z6mh--


--===============5245291102160865442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============5245291102160865442==--

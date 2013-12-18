From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/6] net: cpsw: Support for am335x chip MACIDs
Date: Wed, 18 Dec 2013 11:08:18 -0600
Message-ID: <20131218170818.GR4970@saruman.home>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <52B1D4C7.6030004@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8989432659920951822=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52B1D4C7.6030004@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: devicetree@vger.kernel.org, kernel@pengutronix.de, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Markus Pargmann <mpa@pengutronix.de>, linux-omap@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8989432659920951822==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="87MiR7gHvrw39A9h"
Content-Disposition: inline

--87MiR7gHvrw39A9h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2013 at 10:30:55PM +0530, Mugunthan V N wrote:
> On Wednesday 18 December 2013 10:17 PM, Markus Pargmann wrote:
> > Hi,
> >
> > This series introduces a driver to read and use the MACIDs stored in th=
e am335x
> > control module. These are read-only registers for a unique MACID. At th=
e moment
> > the MACIDs are generated randomly or they are set by the bootloader.
> >
> > A device node is added in am33xx dtsi and used by the cpsw slaves in th=
e bone
> > board files.
> >
> > Regards,
> >
> > Markus
> >
> >
> > Markus Pargmann (6):
> >   DT doc: net: cpsw mac-address is optional
> >   net: cpsw: header, Add missing include
> >   net: cpsw: Add control-module macid driver
> >   net: cpsw: Use cpsw-ctrl-macid driver
> >   arm: dts: am33xx, Add device node for cpsw-ctrl-macid
> >   arm: dts: am335x beagle bone use processor macids
> >
> >  .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  31 +++++
> >  Documentation/devicetree/bindings/net/cpsw.txt     |   7 +-
> >  arch/arm/boot/dts/am335x-bone.dts                  |   8 ++
> >  arch/arm/boot/dts/am335x-boneblack.dts             |   8 ++
> >  arch/arm/boot/dts/am33xx.dtsi                      |   7 ++
> >  drivers/net/ethernet/ti/Kconfig                    |   8 ++
> >  drivers/net/ethernet/ti/Makefile                   |   1 +
> >  drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++++=
++++++++
> >  drivers/net/ethernet/ti/cpsw.c                     |  18 ++-
> >  drivers/net/ethernet/ti/cpsw.h                     |   3 +
> >  10 files changed, 224 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-mac=
id.txt
> >  create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c
> >
> Mac ID is to be filled by U-Boot and this kind of approach is already
> rejected in linux-omap list.
>=20
> If proper ethaddr/eth*addr is populated in U-boot environment variable
> then mac-address dt property in ethernet* device nodes will be populated
> before boot kernel in U-boot. So I don't think this patch series is
> required.

but will u-boot read MACID from control module ?

--=20
balbi

--87MiR7gHvrw39A9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSsdaCAAoJEIaOsuA1yqREKB0QAI4AHJBsRiJ/EWIM7SSLcSRa
mgorgqzNjSJ4Ftx+28+fOWNDrTSm8XJsgC/cgdzJ8mpSiLWPEvafDnkYzFgZWwwx
RW+Z0GvhVs2bxzq7i6D0BGUpMVe7aaTHATCIx7gTriPBVvpztFQmJysfoaOewoR4
LDqSbvwiTikfNuE8YVei+WylEbQ2OWw6UbT1C669rpnfajULi/UQt4dWEUGrCvLj
IPa4me+D66CheFAbaa1v931b+/1bobSweF+y46IPEkphbqLZpDk+x0S0DLiE2YUH
GLvM59UPZc0lXhcKfM/wp6kV2O/VXl8L1WT7PGUcB4823Wkx7Q0sC0upl8dfvbSN
On+ggBk0N8gromYISuAavorrMPwykx3eTt/aBs2lRsoYc5uDzxMxrhnFci7rCbfc
UMBR8Z6M1i9cchX1p7iTaQ36FzDHzsrJQp3DIjvVyOazOiYxmO/9jn0UFz6Rn/k6
jzAoUTM+NSv47xSxGcQdu91EchPtSesEHevjUeFOHqMrSWGfaF9EAGMsdtwbXkd1
D2sAn6BSqTjJTAcMGFIoYjOnvgIVO/IZo2MPmc00+O1ukjVpuHxO7Qb+iTf64/ry
8rKRctmrFq0Y+OKGcw1URd35CKX3TXO+a25FQZyaxm1fXTMWjcrB8etIkgl0rQ9A
F8sRppbysQ2tWkPh/NUz
=OZxG
-----END PGP SIGNATURE-----

--87MiR7gHvrw39A9h--


--===============8989432659920951822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8989432659920951822==--

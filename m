From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] ARM/dts: omap5: Update UART with address space and
 interrupts
Date: Mon, 22 Oct 2012 15:31:41 +0300
Message-ID: <20121022123141.GX14033@arwen.pp.htv.fi>
References: <1350901328-3525-1-git-send-email-s-guiriec@ti.com>
 <1350901328-3525-4-git-send-email-s-guiriec@ti.com>
 <50852AF9.10703@ti.com>
 <5085348C.60105@ti.com>
 <508536EA.4020808@ti.com>
 <50853B94.4060308@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PtV1LuJoEDsm7sfb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34143 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab2JVMhW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 08:37:22 -0400
Content-Disposition: inline
In-Reply-To: <50853B94.4060308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav <sourav.poddar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

--PtV1LuJoEDsm7sfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 22, 2012 at 05:57:00PM +0530, Sourav wrote:
> Hi Benoit,
> On Monday 22 October 2012 05:37 PM, Benoit Cousson wrote:
> >On 10/22/2012 01:57 PM, Benoit Cousson wrote:
> >>Hi Sourav,
> >>
> >>On 10/22/2012 01:16 PM, Sourav wrote:
> >>>Hi Sebastien,
> >>>On Monday 22 October 2012 03:52 PM, Sebastien Guiriec wrote:
> >>>>Add base address and interrupt line inside Device Tree data for
> >>>Incomplete sentence!
> >>>>Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
> >>>>---
> >>>>   arch/arm/boot/dts/omap5.dtsi |   16 ++++++++++++++--
> >>>>   1 file changed, 14 insertions(+), 2 deletions(-)
> >>>>
> >>>>diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.d=
tsi
> >>>>index 6c22e1b..413df94 100644
> >>>>--- a/arch/arm/boot/dts/omap5.dtsi
> >>>>+++ b/arch/arm/boot/dts/omap5.dtsi
> >>>>@@ -237,36 +237,48 @@
> >>>>             uart1: serial@4806a000 {
> >>>>               compatible =3D "ti,omap4-uart";
> >>>>+            reg =3D <0x4806a000 0x100>;
> >>>>+            interrupts =3D <0 72 0x4>;
> >>>>               ti,hwmods =3D "uart1";
> >>>>               clock-frequency =3D <48000000>;
> >>>>           };
> >>>>             uart2: serial@4806c000 {
> >>>>               compatible =3D "ti,omap4-uart";
> >>>>+            reg =3D <0x4806c000 0x100>;
> >>>>+            interrupts =3D <0 73 0x4>;
> >>>>               ti,hwmods =3D "uart2";
> >>>>               clock-frequency =3D <48000000>;
> >>>>           };
> >>>>             uart3: serial@48020000 {
> >>>>               compatible =3D "ti,omap4-uart";
> >>>>+            reg =3D <0x48020000 0x100>;
> >>>>+            interrupts =3D <0 74 0x4>;
> >>>>               ti,hwmods =3D "uart3";
> >>>>               clock-frequency =3D <48000000>;
> >>>>           };
> >>>>             uart4: serial@4806e000 {
> >>>>               compatible =3D "ti,omap4-uart";
> >>>>+            reg =3D <0x4806e000 0x100>;
> >>>>+            interrupts =3D <0 70 0x4>;
> >>>>               ti,hwmods =3D "uart4";
> >>>>               clock-frequency =3D <48000000>;
> >>>>           };
> >>>>             uart5: serial@48066000 {
> >>>>-            compatible =3D "ti,omap5-uart";
> >>>>+            compatible =3D "ti,omap4-uart";
> >>>>+            reg =3D <0x48066000 0x100>;
> >>>>+            interrupts =3D <0 105 0x4>;
> >>>In Omap5 TRM, the interrupt number mentioned for uart5 is 138. How is
> >>>105 coming?
> >>It is from hwmod and thus from the HW spec. It looks like the TRM is
> >>wrong... or the HW spec :-)
> >>
> >>>>               ti,hwmods =3D "uart5";
> >>>>               clock-frequency =3D <48000000>;
> >>>>           };
> >>>>             uart6: serial@48068000 {
> >>>>-            compatible =3D "ti,omap6-uart";
> >>>>+            compatible =3D "ti,omap4-uart";
> >>>>+            reg =3D <0x48068000 0x100>;
> >>>>+            interrupts =3D <0 106 0x4>;
> >>>Same here, TRM shows this number to be 139 ?
> >In fact, even the TRM (ES1.0 NDA vM) is aligned with these data.
> >Where did you see 138 and 139?
> I looked at Page 6300 of the above TRM, Figure 24-60. Is this place

correct page is 6366

--=20
balbi

--PtV1LuJoEDsm7sfb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhTytAAoJEIaOsuA1yqRETaMP/0fqhtT/6L3UJEQhlDkbfN4E
civSHHB+xldoM0tm7kE/8PXyh6ARfQHux8KQMbTaQ+DM6CZlt51v6t16o3DQAXnh
eUqD94LwHnVyWd2+ykXjVHWN7Wa8cwVpDMgX9+eFyiwlErakXEyvA2RX8QsN9qK5
B5irGSC3EuHmlAuuwn3Q8uG7oyP1rZ/pd5Mf0GOWvvj3H+jV9++pFc4V7DfmWQgv
2JUZfdyvQ2dl/A03gtWu8tIFKiFNULwsGQH6lil1NfgcPWF7IXtkEphXkxFbScY0
JqnQ77WubxWCz2E3+O4Z5220LjW6qyKF4D+8xxtwa1EFnHx13uO0KnP0AMxHJzCk
PAhYmduG//07dIWRkn2jgRgNBjto6v8aSKOGGiozsVb/sQzvyLJ8OMwipuK+46+w
qsYvr5hhY91ttb3ruEHp/iiy0/F1c2WsHEzUacXNtBw+eZDbNiVdVyWMXC7zPRgJ
tQL9W4ek3wpmJwcLosRxESEbBEfAWKWg8rvUFUZIORwZLZ9t1rtIWoZOqvXkd+sb
D53agFrEyz3GDcHHLh+O+H28rx9FsR/kCuaexqQ8qpVoUL8R2NlgK5AWzKCPgtWn
FTkZ+2sYKdmJm0xwc4Ya6a8GZ6e4CNmzIYP7HG8nqUVxwyFJ6rOINozgy+DJ34C4
JWMicqZLsXNcptX2i9XT
=qw1I
-----END PGP SIGNATURE-----

--PtV1LuJoEDsm7sfb--

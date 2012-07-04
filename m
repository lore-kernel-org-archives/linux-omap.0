From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: temporarily remove data for the
 usb_host_fs and aess IP blocks
Date: Wed, 4 Jul 2012 03:06:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040303240.6760@utopia.booyaka.com>
References: <alpine.DEB.2.00.1206292151290.2338@utopia.booyaka.com> <4FF2A5CC.80400@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-958410874-1341392801=:6760"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52820 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab2GDJGm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 05:06:42 -0400
In-Reply-To: <4FF2A5CC.80400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-958410874-1341392801=:6760
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Jul 2012, Benoit Cousson wrote:

> On 06/30/2012 05:53 AM, Paul Walmsley wrote:
>=20
> > The OMAP4 usb_host_fs (OHCI) and AESS IP blocks require some special
> > programming for them to enter idle.  Without this programming, they
> > will prevent the rest of the chip from entering full chip idle.
> >=20
> > To implement the idle programming cleanly, this will take some
> > coordination between maintainers.  This is likely to take some time,
> > so it is probably best to leave this for 3.6 or 3.7.  So, in the
> > meantime, simply remove this data.
>=20
> I'd rather keep the data and comment the ocp_if entry.
> We can even add a disclaimer on top to explain the reason.
>=20
> It will be less confusing for the driver folks that are currently working=
 on
> the AESS support.
>=20
> It will as well minimize the churn.

Well I'm not a big fan of adding __maybe_unused to this data, but I guess
changing the approach doesn't matter that much to me.  Updated patch=20
below.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Fri, 29 Jun 2012 17:10:41 -0600
Subject: [PATCH] ARM: OMAP4: hwmod data: temporarily comment out data for t=
he
 usb_host_fs and aess IP blocks

The OMAP4 usb_host_fs (OHCI) and AESS IP blocks require some special
programming for them to enter idle.  Without this programming, they
will prevent the rest of the chip from entering full chip idle.

To implement the idle programming cleanly, this will take some
coordination between maintainers.  This is likely to take some time,
so it is probably best to leave this for 3.6 or 3.7.  So, in the
meantime, prevent these IP blocks from being registered.

Later, once the appropriate support is available, this patch can be
reverted.

This second version comments out the IP block data since Beno=EEt didn't
like removing it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index f30e861..0a1b247 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3864,7 +3864,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_m=
ain_2 =3D {
 };
=20
 /* usb_host_fs -> l3_main_2 */
-static struct omap_hwmod_ocp_if omap44xx_usb_host_fs__l3_main_2 =3D {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_usb_host_fs__l3_ma=
in_2 =3D {
 =09.master=09=09=3D &omap44xx_usb_host_fs_hwmod,
 =09.slave=09=09=3D &omap44xx_l3_main_2_hwmod,
 =09.clk=09=09=3D "l3_div_ck",
@@ -3922,7 +3922,7 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__l3_m=
ain_3 =3D {
 };
=20
 /* aess -> l4_abe */
-static struct omap_hwmod_ocp_if omap44xx_aess__l4_abe =3D {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_aess__l4_abe =3D {
 =09.master=09=09=3D &omap44xx_aess_hwmod,
 =09.slave=09=09=3D &omap44xx_l4_abe_hwmod,
 =09.clk=09=09=3D "ocp_abe_iclk",
@@ -4013,7 +4013,7 @@ static struct omap_hwmod_addr_space omap44xx_aess_add=
rs[] =3D {
 };
=20
 /* l4_abe -> aess */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess =3D {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess =3D {
 =09.master=09=09=3D &omap44xx_l4_abe_hwmod,
 =09.slave=09=09=3D &omap44xx_aess_hwmod,
 =09.clk=09=09=3D "ocp_abe_iclk",
@@ -4031,7 +4031,7 @@ static struct omap_hwmod_addr_space omap44xx_aess_dma=
_addrs[] =3D {
 };
=20
 /* l4_abe -> aess (dma) */
-static struct omap_hwmod_ocp_if omap44xx_l4_abe__aess_dma =3D {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess_dma =
=3D {
 =09.master=09=09=3D &omap44xx_l4_abe_hwmod,
 =09.slave=09=09=3D &omap44xx_aess_hwmod,
 =09.clk=09=09=3D "ocp_abe_iclk",
@@ -5857,7 +5857,7 @@ static struct omap_hwmod_addr_space omap44xx_usb_host=
_fs_addrs[] =3D {
 };
=20
 /* l4_cfg -> usb_host_fs */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_fs =3D {
+static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_cfg__usb_host_f=
s =3D {
 =09.master=09=09=3D &omap44xx_l4_cfg_hwmod,
 =09.slave=09=09=3D &omap44xx_usb_host_fs_hwmod,
 =09.clk=09=09=3D "l4_div_ck",
@@ -6014,13 +6014,13 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp=
_ifs[] __initdata =3D {
 =09&omap44xx_iva__l3_main_2,
 =09&omap44xx_l3_main_1__l3_main_2,
 =09&omap44xx_l4_cfg__l3_main_2,
-=09&omap44xx_usb_host_fs__l3_main_2,
+=09/* &omap44xx_usb_host_fs__l3_main_2, */
 =09&omap44xx_usb_host_hs__l3_main_2,
 =09&omap44xx_usb_otg_hs__l3_main_2,
 =09&omap44xx_l3_main_1__l3_main_3,
 =09&omap44xx_l3_main_2__l3_main_3,
 =09&omap44xx_l4_cfg__l3_main_3,
-=09&omap44xx_aess__l4_abe,
+=09/* &omap44xx_aess__l4_abe, */
 =09&omap44xx_dsp__l4_abe,
 =09&omap44xx_l3_main_1__l4_abe,
 =09&omap44xx_mpu__l4_abe,
@@ -6029,8 +6029,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_i=
fs[] __initdata =3D {
 =09&omap44xx_l4_cfg__l4_wkup,
 =09&omap44xx_mpu__mpu_private,
 =09&omap44xx_l4_cfg__ocp_wp_noc,
-=09&omap44xx_l4_abe__aess,
-=09&omap44xx_l4_abe__aess_dma,
+=09/* &omap44xx_l4_abe__aess, */
+=09/* &omap44xx_l4_abe__aess_dma, */
 =09&omap44xx_l3_main_2__c2c,
 =09&omap44xx_l4_wkup__counter_32k,
 =09&omap44xx_l4_cfg__ctrl_module_core,
@@ -6136,7 +6136,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_i=
fs[] __initdata =3D {
 =09&omap44xx_l4_per__uart2,
 =09&omap44xx_l4_per__uart3,
 =09&omap44xx_l4_per__uart4,
-=09&omap44xx_l4_cfg__usb_host_fs,
+=09/* &omap44xx_l4_cfg__usb_host_fs, */
 =09&omap44xx_l4_cfg__usb_host_hs,
 =09&omap44xx_l4_cfg__usb_otg_hs,
 =09&omap44xx_l4_cfg__usb_tll_hs,
--=20
1.7.10

--155748971-958410874-1341392801=:6760--

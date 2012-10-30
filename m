From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv2 12/12] ARM: OMAP4: hwmod data: do not enable or reset
 the McPDM during kernel init
Date: Tue, 30 Oct 2012 04:05:11 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210300403170.12697@utopia.booyaka.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004626.20034.42995.stgit@dusk> <4FD5C04F.2040509@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-458350754-1351569911=:12697"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47224 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab2J3EFM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 00:05:12 -0400
In-Reply-To: <4FD5C04F.2040509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-458350754-1351569911=:12697
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Mon, 11 Jun 2012, Cousson, Benoit wrote:

> On 6/11/2012 2:46 AM, Paul Walmsley wrote:
>
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > index 3613054..86fc513 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -2091,6 +2091,18 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod =
=3D {
> >   =09.name=09=09=3D "mcpdm",
> >   =09.class=09=09=3D &omap44xx_mcpdm_hwmod_class,
> >   =09.clkdm_name=09=3D "abe_clkdm",
> > +=09/*
> > +=09 * It's suspected that the McPDM requires an off-chip main
> > +=09 * functional clock, controlled via I2C.
>=20
> Nit: Is it not suspected, it is a fact. The clock tree clearly indicate t=
hat
> the mcpdm fclk is generated from the pad_clks.
> The IP is a custom link for the Audio IC control / data. using the Audio =
IC as
> a source clock is standard. Since that IP is done only for that purpose, =
there
> is no optional clock path from the PRCM like it is the case for the McASP=
 /
> McBSP.
>=20
> >  This IP block is
> > +=09 * currently reset very early during boot, before I2C is
> > +=09 * available, so it doesn't seem that we have any choice in
> > +=09 * the kernel other than to avoid resetting it.  XXX This is
> > +=09 * really a hardware issue workaround: every IP block should
> > +=09 * be able to source its main functional clock from either
> > +=09 * on-chip or off-chip sources.  McPDM seems to be the only
> > +=09 * current exception.
>=20
> I do not think this is the right place to put some complaint about the HW=
 :-).
> I guess we should just describe the facts.
>=20
> > +=09 */
> > +=09.flags=09=09=3D HWMOD_EXT_OPT_MAIN_CLK,

I've updated this one to take your comments into account for 3.7-rc fixes. =
=20
But...

> Could you please update the hints for this IP in the autogen scripts?
> I added a comment attribute to add a custom comment on top of the flags e=
ntry.
> The latest branch is "omap5430_for_3.6".

=2E.. could you please take care of updating the autogen side?  Updated=20
patch is below.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 29 Oct 2012 22:02:14 -0600
Subject: [PATCH] ARM: OMAP4: hwmod data: do not enable or reset the McPDM
 during kernel init
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Resolve this kernel boot message:

omap_hwmod: mcpdm: cannot be enabled for reset (3)

The McPDM on OMAP4 can only receive its functional clock from an
off-chip source.  This source is not guaranteed to be present on the
board, and when present, it is controlled by I2C.  This would
introduce a board dependency to the early hwmod code which it was not
designed to handle.  Also, neither the driver for this off-chip clock
provider nor the I2C code is available early in boot when the hwmod
code is attempting to enable and reset IP blocks.  This effectively
makes it impossible to enable and reset this device during hwmod init.

At its core, this patch is a workaround for an OMAP hardware problem.
It should be possible to configure the OMAP to provide any IP block's
functional clock from an on-chip source.  (This is true for almost
every IP block on the chip.  As far as I know, McPDM is the only
exception.)  If the kernel cannot reset and configure IP blocks, it
cannot guarantee a sane SoC state.  Relying on an optional off-chip
clock also creates a board dependency which is beyond the scope of the
early hwmod code.

This patch works around the issue by marking the McPDM hwmod record
with the HWMOD_EXT_OPT_MAIN_CLK flag.  This prevents the hwmod
code from touching the device early during boot.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: P=C3=A9ter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-oma=
p2/omap_hwmod_44xx_data.c
index 652d028..7bddfa5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2125,6 +2125,14 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod =3D {
 =09.name=09=09=3D "mcpdm",
 =09.class=09=09=3D &omap44xx_mcpdm_hwmod_class,
 =09.clkdm_name=09=3D "abe_clkdm",
+=09/*
+=09 * It's suspected that the McPDM requires an off-chip main
+=09 * functional clock, controlled via I2C.  This IP block is
+=09 * currently reset very early during boot, before I2C is
+=09 * available, so it doesn't seem that we have any choice in
+=09 * the kernel other than to avoid resetting it.
+=09 */
+=09.flags=09=09=3D HWMOD_EXT_OPT_MAIN_CLK,
 =09.mpu_irqs=09=3D omap44xx_mcpdm_irqs,
 =09.sdma_reqs=09=3D omap44xx_mcpdm_sdma_reqs,
 =09.main_clk=09=3D "mcpdm_fck",
--=20
1.7.10.4

--843723315-458350754-1351569911=:12697--

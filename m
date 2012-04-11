From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits
 are reprogrammed after a reset
Date: Wed, 11 Apr 2012 14:15:43 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204111401480.29473@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053657.16278.76132.stgit@dusk> <CAB-zwWhAa3PprwDLzWLkBFUHPeJO3HN3M9mAZF=ohGTvP43jYA@mail.gmail.com> <alpine.DEB.2.00.1203150024260.7269@utopia.booyaka.com>
 <CAB-zwWh3tcz5xUkzthH_AAsmeXfMieUW-SCQnAaXyfSg8khqvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-5498708-1334175343=:29473"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53784 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab2DKUPo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 16:15:44 -0400
In-Reply-To: <CAB-zwWh3tcz5xUkzthH_AAsmeXfMieUW-SCQnAaXyfSg8khqvg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-5498708-1334175343=:29473
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 15 Mar 2012, Ramirez Luna, Omar wrote:

> On Thu, Mar 15, 2012 at 1:25 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Wed, 14 Mar 2012, Ramirez Luna, Omar wrote:
> >
> >> If we reached here the reset lines will be asserted, and then the code
> >> below touches sysc registers on a module under reset.
> >
> > Do you know of any case where this would be a problem? =A0Seems like it
> > would only affect IP blocks that have both hard reset lines and SYSCONF=
IG
> > registers, and as far as I know, we don't have any of those defined?
>=20
> MMU (not yet mainlined) has both, a reset line and a sysconfig.

Thanks, I've updated this patch with this fix, included below; rebased=20
the series on v3.4-rc2 (the branch is now "hwmod_code_cleanup_3.5"); and=20
will ask Tony to re-pull it.

> I have been holding the hwmod for some time, but now that
> rpmsg/remoteproc is going to mainline it could make use of it along
> with omap3isp, however now I need to define functions to handle the
> reset lines (although I was fine with hwmod handling it).

OK.

> AFAIKnew, hwmod handling the reset line was fine (IMHO), the only 2 thing=
s were:
> - For the drivers to somehow make use of shutdown/enable if they
> needed they hwmod under reset and out.
> - The annoying: hwmod XX failed to hardreset because of the wrong
> reset sequence but causing no functional issues.

Thanks for the feedback.  Apparently the OMAP4 DSP/ISS people had some=20
issues with the old sequence, although I haven't heard anything from them=
=20
directly, so it's unclear what exactly is going on with their code.
=20
Anyway, please don't hesitate to let us know if you find any other issues=
=20
with the updated behavior.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Mon, 27 Feb 2012 15:23:56 -0700
Subject: [PATCH] ARM: OMAP2+: hwmod: update OCP_SYSCONFIG registers after a
 custom reset

Since OCP_SYSCONFIG bits are cleared during reset, they should be
reprogrammed unless the IP block is being left in reset.  (The only IP
blocks that are left in reset are IP blocks with hardreset lines and
no custom reset function.)  If the IP block is left in reset, then it
is inaccessible to the MPU, and an access to the OCP_SYSCONFIG
register will cause an abort.

This version incorporates comments from Omar Ramirez Luna
<omar.ramirez@ti.com> to skip the OCP_SYSCONFIG access after asserting
hardreset lines.  This allows the MMU (IOMMU) IP block, which has
both hardreset lines and an OCP_SYSCONFIG register.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   39 ++++++++++++++++++++++------------=
----
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index fed805c..451e865 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1480,10 +1480,10 @@ dis_opt_clks:
  * IVA) have idiosyncratic reset sequences.  So for these relatively
  * rare cases, custom reset code can be supplied in the struct
  * omap_hwmod_class .reset function pointer.  Passes along the return
- * value from either _reset() or the custom reset function - these
- * must return -EINVAL if the hwmod cannot be reset this way or if the
- * hwmod is in the wrong state, -ETIMEDOUT if the module did not reset
- * in time, or 0 upon success.
+ * value from either _ocp_softreset() or the custom reset function -
+ * these must return -EINVAL if the hwmod cannot be reset this way or
+ * if the hwmod is in the wrong state, -ETIMEDOUT if the module did
+ * not reset in time, or 0 upon success.
  */
 static int _reset(struct omap_hwmod *oh)
 {
@@ -1491,22 +1491,29 @@ static int _reset(struct omap_hwmod *oh)
=20
 =09pr_debug("omap_hwmod: %s: resetting\n", oh->name);
=20
-=09if (oh->class->reset)
-=09=09return oh->class->reset(oh);
-
-=09if (!oh->rst_lines_cnt) {
-=09=09r =3D _ocp_softreset(oh);
-=09=09if (oh->class->sysc) {
-=09=09=09_update_sysc_cache(oh);
-=09=09=09_enable_sysc(oh);
+=09if (oh->class->reset) {
+=09=09r =3D oh->class->reset(oh);
+=09} else {
+=09=09if (oh->rst_lines_cnt > 0) {
+=09=09=09for (i =3D 0; i < oh->rst_lines_cnt; i++)
+=09=09=09=09_assert_hardreset(oh, oh->rst_lines[i].name);
+=09=09=09return 0;
+=09=09} else {
+=09=09=09r =3D _ocp_softreset(oh);
 =09=09}
-=09=09return r;
 =09}
=20
-=09for (i =3D 0; i < oh->rst_lines_cnt; i++)
-=09=09_assert_hardreset(oh, oh->rst_lines[i].name);
+=09/*
+=09 * OCP_SYSCONFIG bits need to be reprogrammed after a
+=09 * softreset.  The _enable() function should be split to avoid
+=09 * the rewrite of the OCP_SYSCONFIG register.
+=09 */
+=09if (oh->class->sysc) {
+=09=09_update_sysc_cache(oh);
+=09=09_enable_sysc(oh);
+=09}
=20
-=09return 0;
+=09return r;
 }
=20
 /**
--=20
1.7.9.5

--155748971-5498708-1334175343=:29473--

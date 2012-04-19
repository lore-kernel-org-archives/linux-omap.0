From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 5/8] ARM: OMAP2+: hwmod: ensure that SYSCONFIG bits
 are reprogrammed after a reset
Date: Thu, 19 Apr 2012 02:21:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204190219190.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk> <20120228053657.16278.76132.stgit@dusk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1787689136-1334823667=:29048"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56084 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226Ab2DSIVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Apr 2012 04:21:08 -0400
In-Reply-To: <20120228053657.16278.76132.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1787689136-1334823667=:29048
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Mon, 27 Feb 2012, Paul Walmsley wrote:

> Move the code that reprograms the OCP_SYSCONFIG bits into the _reset()
> function to ensure that it is called after every reset.  The code was
> previously in the _setup() function.  So, before this patch, if
> _reset() was called from another function, the SYSCONFIG register
> won't be reprogrammed.

As mentioned earlier, the _reset() changes previously in patch 3 have been=
=20
rolled into this patch, as follows.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 19 Apr 2012 00:49:09 -0600
Subject: [PATCH] ARM: OMAP2+: hwmod: revise the IP block reset process

Revise the IP block reset process.  This patch ensures that the
OCP_SYSCONFIG registers are reloaded after a custom reset.  Since
OCP_SYSCONFIG bits are cleared during reset, they should be
reprogrammed unless the IP block is being left in reset.  (The only IP
blocks that are left in reset are IP blocks with hardreset lines and
no custom reset function.)  If the IP block is left in reset, then it
is inaccessible to the MPU, and an access to the OCP_SYSCONFIG
register will cause an abort.

This version incorporates comments from Omar Ramirez Luna
<omar.ramirez@ti.com> to skip the OCP_SYSCONFIG access after asserting
hardreset lines.  This allows the MMU (IOMMU) IP block, which has
both hardreset lines and an OCP_SYSCONFIG register.

Also, ignore _ocp_softreset() errors if the IP block doesn't include a
softreset bit.  This is needed since a subsequent patch will start
taking the return value of the _reset() function seriously.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   69 +++++++++++++++++++++++++---------=
----
 1 file changed, 46 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hw=
mod.c
index 4997c1a..5b07ad0 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2,7 +2,7 @@
  * omap_hwmod implementation for OMAP2/3/4
  *
  * Copyright (C) 2009-2011 Nokia Corporation
- * Copyright (C) 2011 Texas Instruments, Inc.
+ * Copyright (C) 2011-2012 Texas Instruments, Inc.
  *
  * Paul Walmsley, Beno=EEt Cousson, Kevin Hilman
  *
@@ -1382,9 +1382,9 @@ static int _read_hardreset(struct omap_hwmod *oh, con=
st char *name)
  * @oh: struct omap_hwmod *
  *
  * Resets an omap_hwmod @oh via the OCP_SYSCONFIG bit.  hwmod must be
- * enabled for this to work.  Returns -EINVAL if the hwmod cannot be
- * reset this way or if the hwmod is in the wrong state, -ETIMEDOUT if
- * the module did not reset in time, or 0 upon success.
+ * enabled for this to work.  Returns -ENOENT if the hwmod cannot be
+ * reset this way, -EINVAL if the hwmod is in the wrong state,
+ * -ETIMEDOUT if the module did not reset in time, or 0 upon success.
  *
  * In OMAP3 a specific SYSSTATUS register is used to get the reset status.
  * Starting in OMAP4, some IPs do not have SYSSTATUS registers and instead
@@ -1401,7 +1401,7 @@ static int _ocp_softreset(struct omap_hwmod *oh)
=20
 =09if (!oh->class->sysc ||
 =09    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET))
-=09=09return -EINVAL;
+=09=09return -ENOENT;
=20
 =09/* clocks must be on for this operation */
 =09if (oh->_state !=3D _HWMOD_STATE_ENABLED) {
@@ -1462,37 +1462,60 @@ dis_opt_clks:
  * _reset - reset an omap_hwmod
  * @oh: struct omap_hwmod *
  *
- * Resets an omap_hwmod @oh.  The default software reset mechanism for
- * most OMAP IP blocks is triggered via the OCP_SYSCONFIG.SOFTRESET
- * bit.  However, some hwmods cannot be reset via this method: some
- * are not targets and therefore have no OCP header registers to
- * access; others (like the IVA) have idiosyncratic reset sequences.
- * So for these relatively rare cases, custom reset code can be
- * supplied in the struct omap_hwmod_class .reset function pointer.
- * Passes along the return value from either _reset() or the custom
- * reset function - these must return -EINVAL if the hwmod cannot be
- * reset this way or if the hwmod is in the wrong state, -ETIMEDOUT if
- * the module did not reset in time, or 0 upon success.
+ * Resets an omap_hwmod @oh.  If the module has a custom reset
+ * function pointer defined, then call it to reset the IP block, and
+ * pass along its return value to the caller.  Otherwise, if the IP
+ * block has an OCP_SYSCONFIG register with a SOFTRESET bitfield
+ * associated with it, call a function to reset the IP block via that
+ * method, and pass along the return value to the caller.  Finally, if
+ * the IP block has some hardreset lines associated with it, assert
+ * all of those, but do _not_ deassert them. (This is because driver
+ * authors have expressed an apparent requirement to control the
+ * deassertion of the hardreset lines themselves.)
+ *
+ * The default software reset mechanism for most OMAP IP blocks is
+ * triggered via the OCP_SYSCONFIG.SOFTRESET bit.  However, some
+ * hwmods cannot be reset via this method.  Some are not targets and
+ * therefore have no OCP header registers to access.  Others (like the
+ * IVA) have idiosyncratic reset sequences.  So for these relatively
+ * rare cases, custom reset code can be supplied in the struct
+ * omap_hwmod_class .reset function pointer.  Passes along the return
+ * value from either _ocp_softreset() or the custom reset function -
+ * these must return -EINVAL if the hwmod cannot be reset this way or
+ * if the hwmod is in the wrong state, -ETIMEDOUT if the module did
+ * not reset in time, or 0 upon success.
  */
 static int _reset(struct omap_hwmod *oh)
 {
-=09int ret;
+=09int i, r;
=20
 =09pr_debug("omap_hwmod: %s: resetting\n", oh->name);
=20
+=09if (oh->class->reset) {
+=09=09r =3D oh->class->reset(oh);
+=09} else {
+=09=09if (oh->rst_lines_cnt > 0) {
+=09=09=09for (i =3D 0; i < oh->rst_lines_cnt; i++)
+=09=09=09=09_assert_hardreset(oh, oh->rst_lines[i].name);
+=09=09=09return 0;
+=09=09} else {
+=09=09=09r =3D _ocp_softreset(oh);
+=09=09=09if (r =3D=3D -ENOENT)
+=09=09=09=09r =3D 0;
+=09=09}
+=09}
+
 =09/*
-=09 * XXX We're not resetting modules with hardreset lines
-=09 * automatically here.  Should we do this also, or just expect
-=09 * those modules to define custom reset functions?
+=09 * OCP_SYSCONFIG bits need to be reprogrammed after a
+=09 * softreset.  The _enable() function should be split to avoid
+=09 * the rewrite of the OCP_SYSCONFIG register.
 =09 */
-=09ret =3D (oh->class->reset) ? oh->class->reset(oh) : _ocp_softreset(oh);
-
 =09if (oh->class->sysc) {
 =09=09_update_sysc_cache(oh);
 =09=09_enable_sysc(oh);
 =09}
=20
-=09return ret;
+=09return r;
 }
=20
 /**
--=20
1.7.10

--155748971-1787689136-1334823667=:29048--

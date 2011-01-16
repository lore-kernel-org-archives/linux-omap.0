From: Paul Walmsley <paul@pwsan.com>
Subject: Re: State of SDP4430 platform
Date: Sat, 15 Jan 2011 23:06:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101152255100.13225@utopia.booyaka.com>
References: <20110116010936.GA21795@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1379586749-1295157792=:13225"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49409 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab1APGGr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Jan 2011 01:06:47 -0500
In-Reply-To: <20110116010936.GA21795@n2100.arm.linux.org.uk>
Content-ID: <alpine.DEB.2.00.1101152303450.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1379586749-1295157792=:13225
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1101152303451.13225@utopia.booyaka.com>

On Sun, 16 Jan 2011, Russell King - ARM Linux wrote:

> It's probably best if I just quote the boot log, and people see about=20
> fixing the masses of WARN_ON()s.  Notice that it completely obliterates=
=20
> the early part of the boot log due to the number of WARN_ON()s=20
> triggered.

These come from the clockdomain code, which is missing quite a bit of=20
OMAP4 implementation.  Some patches to add that code in have been posted=20
for the 2.6.39 timeframe[1][2], so it should be reasonable to use=20
something like the following patch for 2.6.38, which converts those=20
backtraces to pr_err()s.

> Other stuff that shows in this boot log:

=2E..

> - Bunch of regulators are returning errors (is this a problem?)
> - I2C timeouts which add quite a bit to the boot-time

These two are probably related.  Looks like something is wrong with=20
communication with the TWL/TPS PMIC on that board.  Those problems don't=20
show up on the OMAP4430ES2 Panda here, so they are probably=20
4430SDP-specific.


- Paul


1. Nayak, Rajendra. _[PATCH 0/5] Clockdomain split series_.  Posted to the
   linux-omap@vger.kernel.org mailing list on 5 January 2011.
   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41748.html

2. Nayak, Rajendra. _[RFC 0/3] OMAP4 static dependency support_.  Posted=20
   to the linux-omap@vger.kernel.org mailing list on 12 January 2011.
   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42222.html

---

[PATCH] OMAP4: clockdomain: bypass unimplemented wake-up dependency functio=
ns on OMAP4

Clockdomain functions that manipulate wake-up dependencies are not
implemented yet on OMAP4 for 2.6.38.  This patch bypasses the OMAP2/3
functions on OMAP4, which in turn avoids the warnings when the
functions would attempt to call the underlying OMAP2/3 PRCM functions.

A clockdomain wake-up and sleep dependency implementation for OMAP4
from Rajendra should be possible to merge during the 2.6.39 merge
window:

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41748.html

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42222.html


Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c |   30 ++++++++++++++++++++++++++----
 1 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockd=
omain.c
index e20b986..58e42f7 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -423,6 +423,12 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct=
 clockdomain *clkdm2)
 {
 =09struct clkdm_dep *cd;
=20
+=09if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
+=09=09pr_err("clockdomain: %s/%s: %s: not yet implemented\n",
+=09=09       clkdm1->name, clkdm2->name, __func__);
+=09=09return -EINVAL;
+=09}
+
 =09if (!clkdm1 || !clkdm2)
 =09=09return -EINVAL;
=20
@@ -458,6 +464,12 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct=
 clockdomain *clkdm2)
 {
 =09struct clkdm_dep *cd;
=20
+=09if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
+=09=09pr_err("clockdomain: %s/%s: %s: not yet implemented\n",
+=09=09       clkdm1->name, clkdm2->name, __func__);
+=09=09return -EINVAL;
+=09}
+
 =09if (!clkdm1 || !clkdm2)
 =09=09return -EINVAL;
=20
@@ -500,6 +512,12 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struc=
t clockdomain *clkdm2)
 =09if (!clkdm1 || !clkdm2)
 =09=09return -EINVAL;
=20
+=09if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
+=09=09pr_err("clockdomain: %s/%s: %s: not yet implemented\n",
+=09=09       clkdm1->name, clkdm2->name, __func__);
+=09=09return -EINVAL;
+=09}
+
 =09cd =3D _clkdm_deps_lookup(clkdm2, clkdm1->wkdep_srcs);
 =09if (IS_ERR(cd)) {
 =09=09pr_debug("clockdomain: hardware cannot set/clear wake up of "
@@ -527,6 +545,12 @@ int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
 =09struct clkdm_dep *cd;
 =09u32 mask =3D 0;
=20
+=09if (!cpu_is_omap24xx() && !cpu_is_omap34xx()) {
+=09=09pr_err("clockdomain: %s: %s: not yet implemented\n",
+=09=09       clkdm->name, __func__);
+=09=09return -EINVAL;
+=09}
+
 =09if (!clkdm)
 =09=09return -EINVAL;
=20
@@ -830,8 +854,7 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 =09 * dependency code and data for OMAP4.
 =09 */
 =09if (cpu_is_omap44xx()) {
-=09=09WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
-=09=09=09  "support is not yet implemented\n");
+=09=09pr_err("clockdomain: %s: OMAP4 wakeup/sleep dependency support: not =
yet implemented\n", clkdm->name);
 =09} else {
 =09=09if (atomic_read(&clkdm->usecount) > 0)
 =09=09=09_clkdm_add_autodeps(clkdm);
@@ -872,8 +895,7 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
 =09 * dependency code and data for OMAP4.
 =09 */
 =09if (cpu_is_omap44xx()) {
-=09=09WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
-=09=09=09  "support is not yet implemented\n");
+=09=09pr_err("clockdomain: %s: OMAP4 wakeup/sleep dependency support: not =
yet implemented\n", clkdm->name);
 =09} else {
 =09=09if (atomic_read(&clkdm->usecount) > 0)
 =09=09=09_clkdm_del_autodeps(clkdm);
--=20
1.7.2.3
--155748971-1379586749-1295157792=:13225--

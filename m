From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v4 1/7] OMAP2+: clockdomain: Add an api to read idle
 mode
Date: Fri, 8 Jul 2011 18:06:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107081756190.15984@utopia.booyaka.com>
References: <1309555626-22608-1-git-send-email-b-cousson@ti.com> <1309555626-22608-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1982801894-1310169968=:15984"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60742 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab1GIAGJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 20:06:09 -0400
In-Reply-To: <1309555626-22608-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Todd Poynor <toddpoynor@google.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1982801894-1310169968=:15984
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Rajendra Nayak <rnayak@ti.com>
>=20
> Add a clockdomain api to check if hardware supervised
> idle transitions are enabled on a clockdomain.
>=20
> Thanks to Todd Poynor <toddpoynor@google.com> for a
> better function name suggestion.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Todd Poynor <toddpoynor@google.com>

I've been looking at this patch and the subsequent one.  Two thoughts=20
occurred to me.

The first is that clkdm_allows_idle() shouldn't need to touch the CM=20
hardware at all, since all clockdomain auto-idle mode changes should go=20
through the clockdomain code.  So we can just keep an in-memory flag in=20
the struct clockdomain and avoid the slow CM register access.

The second is that the name 'clkdm_allows_idle', while a better name=20
than the original, still doesn't seem right.  Na=EFvely, I'd expect a=20
function with that name to reveal whether the clockdomain supports=20
auto-idle mode, not to test its current state.  So this function has been=
=20
renamed to 'clkdm_in_hwsup'.  This name seems slightly uglier, but more=20
accurate.

Updated patch below, queued for 3.1 at git://git.pwsan.com/linux-2.6 in=20
the 'clockdomain_a_3.1' branch.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 7 Jul 2011 22:55:08 -0600
Subject: [PATCH] OMAP2+: clockdomain: add clkdm_in_hwsup()

Add a new function, clkdm_in_hwsup(), that returns true if a clockdomain
is configured for hardware-supervised idle.  It does not actually read the
hardware; rather, it checks an internal flag in the struct clockdomain, whi=
ch
is changed when the clockdomain is switched in and out of hardware-supervis=
ed
idle.  This should be safe, since all changes to the idle mode should
pass through the clockdomain code.

Based on a set of patches by Rajendra Nayak <rnayak@ti.com> which do
the same thing by checking the hardware bits.  This approach should be
faster and more compact.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Todd Poynor <toddpoynor@google.com>
Cc: Beno=EEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |   30 ++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/clockdomain.h |    6 ++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockd=
omain.c
index 5a57de5..239b558 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3/4 clockdomain framework functions
  *
- * Copyright (C) 2008-2010 Texas Instruments, Inc.
- * Copyright (C) 2008-2010 Nokia Corporation
+ * Copyright (C) 2008-2011 Texas Instruments, Inc.
+ * Copyright (C) 2008-2011 Nokia Corporation
  *
  * Written by Paul Walmsley and Jouni H=F6gander
  * Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.com>
@@ -704,6 +704,8 @@ int clkdm_sleep(struct clockdomain *clkdm)
=20
 =09pr_debug("clockdomain: forcing sleep on %s\n", clkdm->name);
=20
+=09clkdm->_flags &=3D ~_CLKDM_FLAG_HWSUP_ENABLED;
+
 =09return arch_clkdm->clkdm_sleep(clkdm);
 }
=20
@@ -732,6 +734,8 @@ int clkdm_wakeup(struct clockdomain *clkdm)
=20
 =09pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
=20
+=09clkdm->_flags &=3D ~_CLKDM_FLAG_HWSUP_ENABLED;
+
 =09return arch_clkdm->clkdm_wakeup(clkdm);
 }
=20
@@ -762,6 +766,8 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
 =09pr_debug("clockdomain: enabling automatic idle transitions for %s\n",
 =09=09 clkdm->name);
=20
+=09clkdm->_flags |=3D _CLKDM_FLAG_HWSUP_ENABLED;
+
 =09arch_clkdm->clkdm_allow_idle(clkdm);
 =09pwrdm_clkdm_state_switch(clkdm);
 }
@@ -792,9 +798,29 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
 =09pr_debug("clockdomain: disabling automatic idle transitions for %s\n",
 =09=09 clkdm->name);
=20
+=09clkdm->_flags &=3D ~_CLKDM_FLAG_HWSUP_ENABLED;
+
 =09arch_clkdm->clkdm_deny_idle(clkdm);
 }
=20
+/**
+ * clkdm_in_hwsup - is clockdomain @clkdm have hardware-supervised idle en=
abled?
+ * @clkdm: struct clockdomain *
+ *
+ * Returns true if clockdomain @clkdm currently has
+ * hardware-supervised idle enabled, or false if it does not or if
+ * @clkdm is NULL.  It is only valid to call this function after
+ * clkdm_init() has been called.  This function does not actually read
+ * bits from the hardware; it instead tests an in-memory flag that is
+ * changed whenever the clockdomain code changes the auto-idle mode.
+ */
+bool clkdm_in_hwsup(struct clockdomain *clkdm)
+{
+=09if (!clkdm)
+=09=09return false;
+
+=09return (clkdm->_flags & _CLKDM_FLAG_HWSUP_ENABLED) ? true : false;
+}
=20
 /* Clockdomain-to-clock/hwmod framework interface code */
=20
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockd=
omain.h
index 8e0da64..8782a5c 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -83,6 +83,9 @@ struct clkdm_dep {
 =09const struct omap_chip_id omap_chip;
 };
=20
+/* Possible flags for struct clockdomain._flags */
+#define _CLKDM_FLAG_HWSUP_ENABLED=09=09BIT(0)
+
 /**
  * struct clockdomain - OMAP clockdomain
  * @name: clockdomain name
@@ -90,6 +93,7 @@ struct clkdm_dep {
  * @clktrctrl_reg: CLKSTCTRL reg for the given clock domain
  * @clktrctrl_mask: CLKTRCTRL/AUTOSTATE field mask in CM_CLKSTCTRL reg
  * @flags: Clockdomain capability flags
+ * @_flags: Flags for use only by internal clockdomain code
  * @dep_bit: Bit shift of this clockdomain's PM_WKDEP/CM_SLEEPDEP bit
  * @prcm_partition: (OMAP4 only) PRCM partition ID for this clkdm's regist=
ers
  * @cm_inst: (OMAP4 only) CM instance register offset
@@ -114,6 +118,7 @@ struct clockdomain {
 =09} pwrdm;
 =09const u16 clktrctrl_mask;
 =09const u8 flags;
+=09u8 _flags;
 =09const u8 dep_bit;
 =09const u8 prcm_partition;
 =09const s16 cm_inst;
@@ -178,6 +183,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm=
);
=20
 void clkdm_allow_idle(struct clockdomain *clkdm);
 void clkdm_deny_idle(struct clockdomain *clkdm);
+bool clkdm_in_hwsup(struct clockdomain *clkdm);
=20
 int clkdm_wakeup(struct clockdomain *clkdm);
 int clkdm_sleep(struct clockdomain *clkdm);
--=20
1.7.5.4

--155748971-1982801894-1310169968=:15984--

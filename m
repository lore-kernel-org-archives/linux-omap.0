From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4 clock domain: Add check for avoiding dependency
 related update.
Date: Wed, 10 Feb 2010 17:13:56 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002101711170.28188@utopia.booyaka.com>
References: <1265789523-6413-1-git-send-email-abhijitpagare@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-112664399-1265847236=:28188"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35394 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756477Ab0BKAN5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 19:13:57 -0500
In-Reply-To: <1265789523-6413-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhijit Pagare <abhijitpagare@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-112664399-1265847236=:28188
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Abhijit,

On Wed, 10 Feb 2010, Abhijit Pagare wrote:

> A check is added for avoiding the sleep/wakeup dependency updates
> for OMAP4 as the structures for the dependencies are currently absent.
>=20
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, I've made the following changes to the patch to try to ensure that=
=20
this doesn't slip through the cracks, and queued it for 2.6.34.  If you=20
have any comments on the revised patch, please let me know.


- Paul

From: Abhijit Pagare <abhijitpagare@ti.com>
Date: Wed, 10 Feb 2010 13:42:03 +0530
Subject: [PATCH] ARM: OMAP4 clock domain: Add check for avoiding dependency=
 related update.

A check is added for avoiding the sleep/wakeup dependency updates
for OMAP4 as the structures for the dependencies are currently absent.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
[paul@pwsan.com: added warnings, explanatory comment, copyright update]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomain.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockd=
omain.c
index a38a615..de4278c 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1,8 +1,8 @@
 /*
  * OMAP2/3/4 clockdomain framework functions
  *
- * Copyright (C) 2008-2009 Texas Instruments, Inc.
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2010 Texas Instruments, Inc.
+ * Copyright (C) 2008-2010 Nokia Corporation
  *
  * Written by Paul Walmsley and Jouni H=F6gander
  * Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti.com>
@@ -891,8 +891,17 @@ void omap2_clkdm_allow_idle(struct clockdomain *clkdm)
 =09pr_debug("clockdomain: enabling automatic idle transitions for %s\n",
 =09=09 clkdm->name);
=20
-=09if (atomic_read(&clkdm->usecount) > 0)
-=09=09_clkdm_add_autodeps(clkdm);
+=09/*
+=09 * XXX This should be removed once TI adds wakeup/sleep
+=09 * dependency code and data for OMAP4.
+=09 */
+=09if (cpu_is_omap44xx()) {
+=09=09WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
+=09=09=09  "support is not yet implemented\n");
+=09} else {
+=09=09if (atomic_read(&clkdm->usecount) > 0)
+=09=09=09_clkdm_add_autodeps(clkdm);
+=09}
=20
 =09_omap2_clkdm_set_hwsup(clkdm, 1);
=20
@@ -924,8 +933,17 @@ void omap2_clkdm_deny_idle(struct clockdomain *clkdm)
=20
 =09_omap2_clkdm_set_hwsup(clkdm, 0);
=20
-=09if (atomic_read(&clkdm->usecount) > 0)
-=09=09_clkdm_del_autodeps(clkdm);
+=09/*
+=09 * XXX This should be removed once TI adds wakeup/sleep
+=09 * dependency code and data for OMAP4.
+=09 */
+=09if (cpu_is_omap44xx()) {
+=09=09WARN_ONCE(1, "clockdomain: OMAP4 wakeup/sleep dependency "
+=09=09=09  "support is not yet implemented\n");
+=09} else {
+=09=09if (atomic_read(&clkdm->usecount) > 0)
+=09=09=09_clkdm_del_autodeps(clkdm);
+=09}
 }
=20
=20
--=20
1.6.6.GIT

--155748971-112664399-1265847236=:28188--

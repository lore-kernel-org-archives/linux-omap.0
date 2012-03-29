From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap2+: pm: fix compilation break.
Date: Thu, 29 Mar 2012 09:33:10 -0700
Message-ID: <20120329163309.GW9859@atomide.com>
References: <1333015762-476-1-git-send-email-govindraj.raja@ti.com>
 <20120329151128.GT9859@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18612 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758958Ab2C2QdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 12:33:13 -0400
Content-Disposition: inline
In-Reply-To: <20120329151128.GT9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>

* Tony Lindgren <tony@atomide.com> [120329 08:14]:
> * Govindraj.R <govindraj.raja@ti.com> [120329 03:12]:
> > From: "Govindraj.R" <govindraj.raja@ti.com>
> >=20
> > Fix the compilation break observed on latest mainline.
> >=20
> > Fixes below compilation break:
> >=20
> > arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
> > arch/arm/mach-omap2/pm.c:239: error: implicit declaration of functi=
on 'disable_hlt'
> > arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
> > arch/arm/mach-omap2/pm.c:247: error: implicit declaration of functi=
on 'enable_hlt'
>=20
> Care to mention which commit broke the compile?

Seems like it was 9f97da78 (Disintegrate asm/system.h for ARM),
and also needs to be fixed for omap1 too. Using the updated
patch below.

Tony


=46rom: Govindraj.R <govindraj.raja@ti.com>
Date: Thu, 29 Mar 2012 09:30:28 -0700
Subject: [PATCH] ARM: OMAP: pm: fix compilation break
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

=46ix the compilation break observed on latest mainline caused
by 9f97da78 (Disintegrate asm/system.h for ARM):

arch/arm/mach-omap1/pm.c: In function =E2=80=98omap_pm_prepare=E2=80=99=
:
arch/arm/mach-omap1/pm.c:587: error: implicit declaration of function =E2=
=80=98disable_hlt=E2=80=99
arch/arm/mach-omap1/pm.c: In function =E2=80=98omap_pm_finish=E2=80=99:
arch/arm/mach-omap1/pm.c:624: error: implicit declaration of function =E2=
=80=98enable_hlt=E2=80=99
arch/arm/mach-omap1/pm.c: In function =E2=80=98omap_pm_init=E2=80=99:
arch/arm/mach-omap1/pm.c:681: error: =E2=80=98arm_pm_idle=E2=80=99 unde=
clared (first use in this function)
=2E..

arch/arm/mach-omap2/pm.c: In function 'omap_pm_begin':
arch/arm/mach-omap2/pm.c:239: error: implicit declaration of function '=
disable_hlt'
arch/arm/mach-omap2/pm.c: In function 'omap_pm_end':
arch/arm/mach-omap2/pm.c:247: error: implicit declaration of function '=
enable_hlt'

Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
[tony@atomide.com: updated to fix omap1 too]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 306beac..f66c329 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -44,6 +44,7 @@
 #include <linux/io.h>
 #include <linux/atomic.h>
=20
+#include <asm/system_misc.h>
 #include <asm/irq.h>
 #include <asm/mach/time.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index a7bdec6..d0c1c96 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -17,6 +17,8 @@
 #include <linux/export.h>
 #include <linux/suspend.h>
=20
+#include <asm/system_misc.h>
+
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 #include "common.h"
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

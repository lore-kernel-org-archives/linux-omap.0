From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [PATCH] ARM: OMAP2+: Fix prm2xxx_3xxx.c INT_34XX_PRCM_MPU_IRQ build
 error
Date: Thu, 9 Feb 2012 20:01:09 +0100
Message-ID: <4F3417F5.2090901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60621 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab2BITBM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Feb 2012 14:01:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kristo, Tero" <t-kristo@ti.com>

If CONFIG_OF is not defined, the following error will happen.

arch/arm/mach-omap2/prm2xxx_3xxx.c:41:11: error:
 =91INT_34XX_PRCM_MPU_IRQ=92 undeclared here (not in a function)

This is due to some hidden headers path from linux/of.h to plat/irqs.h
already reported by Russell for prm4xxx.c.

Add the #include <plat/irqs.h> in prm2xxx_3xxx.c to avoid depending
of that hidden dependency that should probably not exist in theory.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/p=
rm2xxx_3xxx.c
index c1c4d86..09e2916 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -18,6 +18,7 @@
=20
 #include "common.h"
 #include <plat/cpu.h>
+#include <plat/irqs.h>
 #include <plat/prcm.h>
=20
 #include "vp.h"
--=20
1.7.5.4



--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

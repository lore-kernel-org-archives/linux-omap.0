From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP3 clock: update OMAP34xx clock definition credits
Date: Thu, 03 Apr 2008 19:09:42 -0600
Message-ID: <20080404012634.096965908@pwsan.com>
References: <20080404010941.510844152@pwsan.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49316 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758026AbYDDB2B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 21:28:01 -0400
Content-Disposition: inline; filename=add_clock34xx_credits.patch
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Ensure that people who have contributed several bug fixes to the=20
34xx clock framework are appropriately credited.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock34xx.h |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2008-03-28 00:40:23=
=2E000000000 -0600
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2008-03-28 00:41:40.0000=
00000 -0600
@@ -1,16 +1,21 @@
 /*
  * OMAP3 clock framework
  *
- * Virtual clocks are introduced as a convenient tools.
- * They are sources for other clocks and not supposed
- * to be requested from drivers directly.
- *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
  * Copyright (C) 2007-2008 Nokia Corporation
  *
  * Written by Paul Walmsley
+ * With many device clock fixes by Kevin Hilman and Jouni H=C3=B6gande=
r
+ * DPLL bypass clock support added by Roman Tereshonkov
+ *
  */
=20
+/*
+ * Virtual clocks are introduced as convenient tools.
+ * They are sources for other clocks and not supposed
+ * to be requested from drivers directly.
+ */
+
 #ifndef __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
 #define __ARCH_ARM_MACH_OMAP2_CLOCK34XX_H
=20

--=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

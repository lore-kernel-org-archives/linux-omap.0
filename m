From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH]DSPBRIDGE:Cleanup unused  success codes
Date: Fri, 26 Mar 2010 01:37:35 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB31@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47201 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702Ab0CYUHx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:07:53 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From 6ee4200fd19d0a2a41ad90df2af015c2d08438a7 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Wed, 24 Mar 2010 15:54:33 -0600
Subject: [PATCH] DSPBRIDGE: Remove unused success codes.

This patch removes unused success codes.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index d60a179..90059bc 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -46,24 +46,12 @@
 /* The DSP is already asleep. */
 #define DSP_SALREADYASLEEP          (DSP_SBASE + 3)
 
-/* The DSP is already awake. */
-#define DSP_SALREADYAWAKE           (DSP_SBASE + 4)
-
-/* TRUE */
-#define DSP_STRUE                   (DSP_SBASE + 5)
-
-/* FALSE */
-#define DSP_SFALSE                  (DSP_SBASE + 6)
-
 /* A library contains no dependent library references */
 #define DSP_SNODEPENDENTLIBS        (DSP_SBASE + 7)
 
 /* A persistent library is already loaded by the dynamic loader */
 #define DSP_SALREADYLOADED          (DSP_SBASE + 8)
 
-/* Some error occured, but it is OK to continue */
-#define DSP_OKTO_CONTINUE          (DSP_SBASE + 9)
-
 /* FAILURE Codes */
 
 /* During enumeration a change in the number or properties of the objects
-- 
1.6.0.4


From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 2/19] DSPBRIDGE: Cleanup custom error code
 (DSP_ECORRUPTFILE ->EBADF)
Date: Fri, 26 Mar 2010 01:36:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB1E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47125 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579Ab0CYUGW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:06:22 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From e7bc198d031784db9eae9cfbca1afac63e3b0453 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 09:27:38 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code(DSP_ECORRUPTFILE ->EBADF)

This patch replaces DSP_ECORRUPTFILE with EBADF.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/rmgr/nldr.c                 |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index a2fa786..81fc1b1 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -76,9 +76,6 @@
  * has occurred. */
 #define DSP_ECHANGEDURINGENUM       (DSP_EBASE + 3)
 
-/* An error occurred while parsing the DSP executable file */
-#define DSP_ECORRUPTFILE            (DSP_EBASE + 4)
-
 /* A failure occurred during a delete operation */
 #define DSP_EDELETE                 (DSP_EBASE + 5)
 
diff --git a/drivers/dsp/bridge/rmgr/nldr.c b/drivers/dsp/bridge/rmgr/nldr.c
index c23deda..aa5b0c3 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -521,7 +521,7 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
 		/* Parse memory segment data */
 		dload_segs = (u16) (*((u32 *) psz_coff_buf));
 		if (dload_segs > MAXMEMSEGS)
-			status = DSP_ECORRUPTFILE;
+			status = EBADF;
 	}
 	/* Parse dynamic load memory segments */
 	if (DSP_SUCCEEDED(status) && dload_segs > 0) {
-- 
1.6.0.4


From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 2/19] DSPBRIDGE: Cleanup custom error code
 (DSP_ECORRUPTFILE ->-EBADF)
Date: Sat, 27 Mar 2010 07:57:07 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE08@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41890 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533Ab0C0C1N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 22:27:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2R2R9Fw028737
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 21:27:12 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2R2R9v1026487
	for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 07:57:09 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From ca52a733142bba7f132a314b93d1489a89c4574b Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 09:27:38 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_ECORRUPTFILE ->-EBADF)

This patch replaces DSP_ECORRUPTFILE with -EBADF.

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
index c23deda..2d79b37 100644
--- a/drivers/dsp/bridge/rmgr/nldr.c
+++ b/drivers/dsp/bridge/rmgr/nldr.c
@@ -521,7 +521,7 @@ dsp_status nldr_create(OUT struct nldr_object **phNldr,
 		/* Parse memory segment data */
 		dload_segs = (u16) (*((u32 *) psz_coff_buf));
 		if (dload_segs > MAXMEMSEGS)
-			status = DSP_ECORRUPTFILE;
+			status = -EBADF;
 	}
 	/* Parse dynamic load memory segments */
 	if (DSP_SUCCEEDED(status) && dload_segs > 0) {
-- 
1.6.0.4


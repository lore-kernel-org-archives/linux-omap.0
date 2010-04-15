From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 12/13] DSPBRIDGE: Cleanup custom error code
 (REG_E_NOMOREITEMS  -> -ENODATA)
Date: Fri, 16 Apr 2010 02:48:12 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FE4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51998 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757223Ab0DOVSQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:18:16 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLIDw4008833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:18:15 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLID3h011166
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:48:13 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From a70cecfb7c889d75492241110a547bc4ef0b5ee4 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 12:11:58 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (REG_E_NOMOREITEMS  -> -ENODATA)

This patch replaces REG_E_NOMOREITEMS with -ENODATA

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/rmgr/dbdcd.c                |    2 +-
 drivers/dsp/bridge/services/regsup.c           |    2 +-
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 60f902c..0ae64fa 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -344,9 +344,6 @@
 /* Invalid entry parameter. */
 #define REG_E_INVALIDENTRY          (REG_EBASE + 0x01)
 
-/* No more registry values. */
-#define REG_E_NOMOREITEMS           (REG_EBASE + 0x02)
-
 /* Insufficient space to hold data in registry value. */
 #define REG_E_MOREDATA              (REG_EBASE + 0x03)
 
diff --git a/drivers/dsp/bridge/rmgr/dbdcd.c b/drivers/dsp/bridge/rmgr/dbdcd.c
index 21333fc..a80b726 100644
--- a/drivers/dsp/bridge/rmgr/dbdcd.c
+++ b/drivers/dsp/bridge/rmgr/dbdcd.c
@@ -281,7 +281,7 @@ dsp_status dcd_enumerate_object(IN s32 cIndex, IN enum dsp_dcdobjtype obj_type,
 			enum_refs++;
 
 			status = DSP_SOK;
-		} else if (status == REG_E_NOMOREITEMS) {
+		} else if (status == -ENODATA) {
 			/* At the end of enumeration. Reset enum_refs. */
 			enum_refs = 0;
 
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index eca9bb2..d69960b 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -201,7 +201,7 @@ dsp_status regsup_enum_value(IN u32 dw_index, IN CONST char *pstrKey,
 	}
 
 	if (count && DSP_FAILED(ret))
-		ret = REG_E_NOMOREITEMS;
+		ret = -ENODATA;
 
 	dev_dbg(bridge, "REG: enum Key %s, Value %s, status = 0x%x",
 		pstrKey, pstrValue, ret);
-- 
1.6.0.4


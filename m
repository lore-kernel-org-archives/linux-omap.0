From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC] [PATCH 11/13] DSPBRIDGE: Cleanup custom error code
 (REG_E_INVALIDSUBKEY -> -ENOKEY)
Date: Fri, 16 Apr 2010 02:48:08 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136FE3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40858 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223Ab0DOVSN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 17:18:13 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3FLIAcj031020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 16:18:12 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o3FLIAVP011162
	for <linux-omap@vger.kernel.org>; Fri, 16 Apr 2010 02:48:10 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 5ee78a0e44159548400b1727b9dc3e127e8b8406 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Fri, 9 Apr 2010 12:05:01 -0500
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (REG_E_INVALIDSUBKEY -> -ENOKEY)

This patch replaces REG_E_INVALIDSUBKEY with -ENOKEY

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/services/regsup.c           |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 679bb59..60f902c 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -341,9 +341,6 @@
 /* FAILURE Codes : REG */
 #define REG_EBASE                   (DSP_COMP_EBASE + 0x800)
 
-/* Invalid subkey parameter. */
-#define REG_E_INVALIDSUBKEY         (REG_EBASE + 0x00)
-
 /* Invalid entry parameter. */
 #define REG_E_INVALIDENTRY          (REG_EBASE + 0x01)
 
diff --git a/drivers/dsp/bridge/services/regsup.c b/drivers/dsp/bridge/services/regsup.c
index 275d91c..eca9bb2 100644
--- a/drivers/dsp/bridge/services/regsup.c
+++ b/drivers/dsp/bridge/services/regsup.c
@@ -172,7 +172,7 @@ dsp_status regsup_enum_value(IN u32 dw_index, IN CONST char *pstrKey,
 			     IN OUT char *pstrValue, IN OUT u32 * pdwValueSize,
 			     IN OUT char *pstrData, IN OUT u32 * pdwDataSize)
 {
-	dsp_status ret = REG_E_INVALIDSUBKEY;
+	dsp_status ret = -ENOKEY;
 	struct reg_value *rv = (struct reg_value *)lst_first(reg_key_list);
 	u32 dw_key_len;
 	u32 count = 0;
-- 
1.6.0.4


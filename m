From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH v1 3/19] DSPBRIDGE: Cleanup custom error code
 (DSP_EFILE ->-ENOENT)
Date: Sat, 27 Mar 2010 07:57:15 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEE09@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41892 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010Ab0C0C1U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 22:27:20 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2R2RHwh028747
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 21:27:20 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2R2RHEr026505
	for <linux-omap@vger.kernel.org>; Sat, 27 Mar 2010 07:57:17 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From abf0989e50ae07724253136d88a6b679f8f1da39 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 09:32:41 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EFILE ->-ENOENT)

This patch replaces error code DSP_EFILE with -ENOENT.

Signed-off-by: Shivananda Hebbar <x0hebbar@ti.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |    3 ---
 drivers/dsp/bridge/rmgr/proc.c                 |    2 +-
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index 81fc1b1..30d13f9 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -90,9 +90,6 @@
 /* A general failure occurred */
 #define DSP_EFAIL                   (DSP_EBASE + 8)
 
-/* The specified executable file could not be found. */
-#define DSP_EFILE                   (DSP_EBASE + 9)
-
 /* The specified handle is invalid. */
 #define DSP_EHANDLE                 (DSP_EBASE + 0xa)
 
diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index d664f96..42f4734 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -239,7 +239,7 @@ static dsp_status get_exec_file(struct cfg_devnode *dev_node_obj,
 			return DSP_SOK;
 		}
 	}
-	return DSP_EFILE;
+	return -ENOENT;
 }
 
 /*
-- 
1.6.0.4


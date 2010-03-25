From: "Hebbar, Shivananda" <x0hebbar@ti.com>
Subject: [RFC][PATCH 3/19] DSPBRIDGE: Cleanup custom error code (DSP_EFILE
 ->ENOENT)
Date: Fri, 26 Mar 2010 01:36:18 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DEBEB1F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36982 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754658Ab0CYUGY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Mar 2010 16:06:24 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2PK6K3S005780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 25 Mar 2010 15:06:23 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2PK6KWr027564
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 01:36:20 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From 26285ce4fad4381fc340a91cfb47dc1b22c376b1 Mon Sep 17 00:00:00 2001
From: Shivananda Hebbar <x0hebbar@ti.com>
Date: Tue, 23 Mar 2010 09:32:41 -0600
Subject: [PATCH] DSPBRIDGE: Cleanup custom error code (DSP_EFILE ->ENOENT)

This patch replaces error code DSP_EFILE with ENOENT.

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
index d664f96..b154102 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -239,7 +239,7 @@ static dsp_status get_exec_file(struct cfg_devnode *dev_node_obj,
 			return DSP_SOK;
 		}
 	}
-	return DSP_EFILE;
+	return ENOENT;
 }
 
 /*
-- 
1.6.0.4


From: "Ramirez Luna, Omar" <x00omar@ti.com>
Subject: [PATCH 7/7][OMAP 3/4+] BRIDGE: set 0 for phys_mempool_* as default
Date: Fri, 12 Sep 2008 23:20:45 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A5344A4F050@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49094 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbYIMEUv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Sep 2008 00:20:51 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m8D4KkqD003663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 23:20:51 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m8D4Kke3014659
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 23:20:46 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 12 Sep 2008 22:09:45 -0500
Subject: [PATCH] BRIDGE: set 0 for phys_mempool_* as default

The default values of these parameters shouldn't expect a
certain amount of ram size and its reservation, otherwise
it will result in kernel crash.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 64fdba4..effc9df 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -146,8 +146,8 @@ static char *base_img;
 char *iva_img;
 static char *num_procs = "C55=1";
 static s32 shm_size = 0x400000;	/* 4 MB */
-static u32 phys_mempool_base = 0x87000000;
-static u32 phys_mempool_size = 0x600000;
+static u32 phys_mempool_base;
+static u32 phys_mempool_size;
 
 #if !defined(CONFIG_ARCH_OMAP2430) && !defined(CONFIG_ARCH_OMAP3430)
 static int tc_wordswapon = 1;	/* Default value is always TRUE */
-- 
1.5.5.4


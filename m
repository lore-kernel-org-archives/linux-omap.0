From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 4/7] DSPBRIDGE: Shared memory size increased to 5MB
Date: Wed, 17 Jun 2009 12:36:09 -0500
Message-ID: <1245260172-23008-5-git-send-email-omar.ramirez@ti.com>
References: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-2-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-3-git-send-email-omar.ramirez@ti.com>
 <1245260172-23008-4-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58462 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758969AbZFQRbl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2009 13:31:41 -0400
In-Reply-To: <1245260172-23008-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Increase the shared memory size to 5MB, bridge
initialization should reserve 5MB of shared memory
by default.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index f41e153..eaac89d 100644
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -129,7 +129,7 @@ static s32 driver_minor = DRIVER_MINOR;
 static char *base_img;
 char *iva_img;
 static char *num_procs = "C55=1";
-static s32 shm_size = 0x400000;	/* 4 MB */
+static s32 shm_size = 0x500000;	/* 5 MB */
 static u32 phys_mempool_base;
 static u32 phys_mempool_size;
 static int tc_wordswapon;	/* Default value is always false */
-- 
1.6.2.4


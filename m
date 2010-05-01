From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC/PATCH 1/6] DSPBRIDGE: add memory_map_info to PROC
Date: Sat,  1 May 2010 23:44:26 +0300
Message-ID: <1272746671-13423-2-git-send-email-ohad@wizery.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:55289 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab0EAUru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 16:47:50 -0400
Received: by fg-out-1718.google.com with SMTP id d23so560447fga.1
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 13:47:48 -0700 (PDT)
In-Reply-To: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Add the memory_map_info structure which will be used to maintain
mapping and page information. Every memory mapping requested by the
MM application will be remembered and kept in a linked list
inside the proc object.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 drivers/dsp/bridge/rmgr/proc.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 1f7dd09..95a194a 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -17,6 +17,8 @@
  */
 
 /* ------------------------------------ Host OS */
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <dspbridge/host_os.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
@@ -102,6 +104,20 @@ struct proc_object {
 	struct bridge_drv_interface *intf_fxns;	/* Function interface to WMD */
 	char *psz_last_coff;
 	struct list_head proc_list;
+
+	/* memory mapping information */
+	struct list_head maps;
+	spinlock_t maps_lock;
+};
+
+/* used to cache memory mapping information */
+struct memory_map_info {
+	struct list_head node;
+	struct page **pages;
+	u32 mpu_addr;
+	u32 dsp_addr;
+	u32 size;
+	u32 num_usr_pgs;
 };
 
 static u32 refs;
-- 
1.6.3.3


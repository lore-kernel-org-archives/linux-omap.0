From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [RFC/PATCH 3/6] DSPBRIDGE: remove mapping information in proc_unmap
Date: Sat,  1 May 2010 23:44:28 +0300
Message-ID: <1272746671-13423-4-git-send-email-ohad@wizery.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:55289 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab0EAUrz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 16:47:55 -0400
Received: by fg-out-1718.google.com with SMTP id d23so560447fga.1
        for <linux-omap@vger.kernel.org>; Sat, 01 May 2010 13:47:55 -0700 (PDT)
In-Reply-To: <1272746671-13423-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Guzman Lugo Fernando <x0095840@ti.com>, Menon Nishanth <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Clean up all mapping information resources whenever
a buffer is unmapped.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
If you want, you can also reach me at <  ohadb at ti dot com  >.

 drivers/dsp/bridge/rmgr/proc.c |   43 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index b03232f..ebb11b1 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -169,6 +169,46 @@ static struct memory_map_info *add_mapping_info(struct proc_object *pr_obj,
 	return map_info;
 }
 
+static int match_exact_map_info(struct memory_map_info *map_info,
+					u32 dsp_addr, u32 size)
+{
+	return map_info->dsp_addr == dsp_addr &&
+		map_info->size == size;
+}
+
+static void remove_mapping_information(struct proc_object *pr_obj,
+					u32 dsp_addr, u32 size)
+{
+	struct memory_map_info *map_info;
+	struct list_head *iter;
+
+	pr_debug("%s: looking for virt 0x%x size 0x%x\n", __func__,
+							dsp_addr, size);
+
+	spin_lock(&pr_obj->maps_lock);
+	list_for_each(iter, &pr_obj->maps) {
+		map_info = list_entry(iter, struct memory_map_info, node);
+		pr_debug("%s: candidate: mpu_addr 0x%x virt 0x%x size 0x%x\n",
+						__func__,
+						map_info->mpu_addr,
+						map_info->dsp_addr,
+						map_info->size);
+
+		if (match_exact_map_info(map_info, dsp_addr, size)) {
+			pr_debug("%s: match, deleting map info\n", __func__);
+			list_del(&map_info->node);
+			kfree(map_info->pages);
+			kfree(map_info);
+			goto out;
+		}
+		pr_debug("%s: candidate didn't match\n", __func__);
+	}
+
+	pr_err("%s: failed to find given map info\n", __func__);
+out:
+	spin_unlock(&pr_obj->maps_lock);
+}
+
 /*
  *  ======== proc_attach ========
  *  Purpose:
@@ -1508,6 +1548,9 @@ dsp_status proc_un_map(void *hprocessor, void *map_addr,
 		status = (*p_proc_object->intf_fxns->pfn_brd_mem_un_map)
 		    (p_proc_object->hwmd_context, va_align, size_align);
 	}
+
+	remove_mapping_information(p_proc_object, va_align, size_align);
+
 	mutex_unlock(&proc_lock);
 	if (DSP_FAILED(status))
 		goto func_end;
-- 
1.6.3.3


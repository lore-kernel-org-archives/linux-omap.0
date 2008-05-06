From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] DSPGW: Fix build error with n800_defconfig
Date: Tue,  6 May 2008 13:42:41 +0300
Message-ID: <1210070561-2275-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19454 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbYEFKmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 06:42:50 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m46AgjDR010896
	for <linux-omap@vger.kernel.org>; Tue, 6 May 2008 13:42:47 +0300
Received: from oreo.research.nokia.com (esdhcp04066.research.nokia.com [172.21.40.66])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m46Agf0T008008
	for <linux-omap@vger.kernel.org>; Tue, 6 May 2008 13:42:41 +0300
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

"3c18ddd160d1fcd46d1131d9ad6c594dd8e9af99" removed "->nopage()" from "vm_ops".

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/dsp/dspgateway/task.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/dspgateway/task.c b/drivers/dsp/dspgateway/task.c
index e5ee8e0..e3a0a02 100644
--- a/drivers/dsp/dspgateway/task.c
+++ b/drivers/dsp/dspgateway/task.c
@@ -1311,16 +1311,15 @@ static void dsp_task_mmap_close(struct vm_area_struct *vma)
  * On demand page allocation is not allowed. The mapping area is defined by
  * corresponding DSP tasks.
  */
-static struct page *dsp_task_mmap_nopage(struct vm_area_struct *vma,
-					 unsigned long address, int *type)
+static int dsp_task_mmap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 {
-	return NOPAGE_SIGBUS;
+	return VM_FAULT_NOPAGE;
 }
 
 static struct vm_operations_struct dsp_task_vm_ops = {
 	.open = dsp_task_mmap_open,
 	.close = dsp_task_mmap_close,
-	.nopage = dsp_task_mmap_nopage,
+	.fault = dsp_task_mmap_fault,
 };
 
 static int dsp_task_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
1.5.4.3


From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH][OMAPZOOM]OMAP3ISP: Remove double mutex unlock
Date: Tue, 18 Nov 2008 15:18:38 -0600
Message-ID: <A24693684029E5489D1D202277BE89441522FE3B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55186 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbYKRVSp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 16:18:45 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAILIeXk026257
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 15:18:45 -0600
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAILIdMI020399
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 15:18:39 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP3ISP: Remove double mutex unlock

This patch removes a double mutex_unlock possibility on errors in
vidioc_default.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/omap34xxcam.c |    1 -
 1 file changed, 1 deletion(-)

Index: omapkernel-android/drivers/media/video/omap34xxcam.c
===================================================================
--- omapkernel-android.orig/drivers/media/video/omap34xxcam.c
+++ omapkernel-android/drivers/media/video/omap34xxcam.c
@@ -1201,7 +1201,6 @@ static int vidioc_default(struct file *f
 		rval = isp_handle_private(cmd, arg);
 	}
 out:
-	mutex_unlock(&vdev->mutex);
 	return rval;
 }

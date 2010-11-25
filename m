From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC/PATCH v3 4/7] v4l: Include linux/videodev2.h in media/v4l2-ctrls.h
Date: Thu, 25 Nov 2010 03:54:35 +0100
Message-ID: <1290653678-15556-5-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53700 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677Ab0KYCyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 21:54:33 -0500
In-Reply-To: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sakari.ailus@maxwell.research.nokia.com

The later makes extensive use of structures defined in the former.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/media/v4l2-ctrls.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index 9b7bea9..3b133b7 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -23,6 +23,7 @@
 
 #include <linux/list.h>
 #include <linux/device.h>
+#include <linux/videodev2.h>
 
 /* forward references */
 struct v4l2_ctrl_handler;
-- 
1.7.2.2


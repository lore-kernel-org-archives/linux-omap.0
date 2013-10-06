From: Varun B Patil <varun.basavaraj.patil@gmail.com>
Subject: [PATCH] omapdce : clear transaction if engine_open rpsend fails
Date: Sun,  6 Oct 2013 18:38:45 +0530
Message-ID: <1381064927-3798-1-git-send-email-varun.basavaraj.patil@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:37634 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3JFNJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Oct 2013 09:09:05 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so6006198pbc.1
        for <linux-omap@vger.kernel.org>; Sun, 06 Oct 2013 06:09:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Varun B Patil <varun.basavaraj.patil@gmail.com>

The next time the same transaction structure is used, when the req_id's
wrap around, it should be completely cleared (memset) to avoid corruption.

Signed-off-by: Varun B Patil <varun.basavaraj.patil@gmail.com>
---
 drivers/staging/omapdce/dce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/omapdce/dce.c b/drivers/staging/omapdce/dce.c
index 1d9b75c..2dbb24e9 100644
--- a/drivers/staging/omapdce/dce.c
+++ b/drivers/staging/omapdce/dce.c
@@ -754,7 +754,7 @@ static int ioctl_engine_open(struct drm_device *dev, void *data,
 		strncpy(req.name, arg->name, sizeof(req.name));
 		ret = rpsend(priv, &arg->token, hdr(&req), sizeof(req));
 		if (ret)
-			return ret;
+			return rpabort(hdr(&req), ret);
 	}
 
 	/* then wait for reply, which is interruptible */
-- 
1.8.1.2


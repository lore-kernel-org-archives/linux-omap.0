From: Varun B Patil <varun.basavaraj.patil@gmail.com>
Subject: [PATCH] omapdce : fix bug in ioctl_codec_process
Date: Sun,  6 Oct 2013 18:38:46 +0530
Message-ID: <1381064927-3798-2-git-send-email-varun.basavaraj.patil@gmail.com>
References: <1381064927-3798-1-git-send-email-varun.basavaraj.patil@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:51955 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3JFNJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Oct 2013 09:09:06 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so5946298pbc.36
        for <linux-omap@vger.kernel.org>; Sun, 06 Oct 2013 06:09:06 -0700 (PDT)
In-Reply-To: <1381064927-3798-1-git-send-email-varun.basavaraj.patil@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Varun B Patil <varun.basavaraj.patil@gmail.com>

Do not send already free'd pointer to rpabort when rpsend fails.

Signed-off-by: Varun B Patil <varun.basavaraj.patil@gmail.com>
---
 drivers/staging/omapdce/dce.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/omapdce/dce.c b/drivers/staging/omapdce/dce.c
index 2a7cbef..1d9b75c 100644
--- a/drivers/staging/omapdce/dce.c
+++ b/drivers/staging/omapdce/dce.c
@@ -1318,15 +1318,17 @@ static int ioctl_codec_process(struct drm_device *dev, void *data,
 
 		ret = rpsend(priv, &arg->token, hdr(req), ptr - (void *)req);
 rpsend_out:
-		kfree(req);
 		if (ret) {
 			/* if input buffer is already locked, unlock it now so we
 			 * don't have a leak:
 			 */
 			if (input_id)
 				codec_unlockbuf(priv, arg->codec_handle, input_id);
-			return rpabort(hdr(req), ret);
+			ret = rpabort(hdr(req), ret);
+			kfree(req);
+			return ret;
 		}
+		kfree(req);
 	}
 
 	/* then wait for reply, which is interruptible */
-- 
1.8.1.2


From: Varun B Patil <varun.basavaraj.patil@gmail.com>
Subject: [PATCH] omapdce : fix transaction corruption due to wrong request id
Date: Sun,  6 Oct 2013 18:38:47 +0530
Message-ID: <1381064927-3798-3-git-send-email-varun.basavaraj.patil@gmail.com>
References: <1381064927-3798-1-git-send-email-varun.basavaraj.patil@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:46324 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab3JFNJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Oct 2013 09:09:10 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so5998389pbb.28
        for <linux-omap@vger.kernel.org>; Sun, 06 Oct 2013 06:09:09 -0700 (PDT)
In-Reply-To: <1381064927-3798-1-git-send-email-varun.basavaraj.patil@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Varun B Patil <varun.basavaraj.patil@gmail.com>

ioctl_codec_process was calling get_paddr() with a wrong pointer as
argument which resulted in wrong req_id being used to get the transaction
inside get_paddr().

Signed-off-by: Varun B Patil <varun.basavaraj.patil@gmail.com>
---
 drivers/staging/omapdce/dce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/omapdce/dce.c b/drivers/staging/omapdce/dce.c
index 87a45fa..2a7cbef 100644
--- a/drivers/staging/omapdce/dce.c
+++ b/drivers/staging/omapdce/dce.c
@@ -1296,7 +1296,7 @@ static int ioctl_codec_process(struct drm_device *dev, void *data,
 
 		codec_get_quirks(priv, arg->codec_handle, &quirks);
 
-		ret = PTR_RET(get_paddr(priv, hdr(&req), &req->out_args, arg->out_args_bo));
+		ret = PTR_RET(get_paddr(priv, hdr(req), &req->out_args, arg->out_args_bo));
 		if (ret)
 			return rpabort(hdr(req), ret);
 
-- 
1.8.1.2


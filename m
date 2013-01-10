From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: [PATCH 1/5] staging: tidspbridge: fix potential array out of bounds write
Date: Thu, 10 Jan 2013 03:36:58 -0600
Message-ID: <1357810622-1709-2-git-send-email-omar.ramirez@copitl.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:46063 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab3AJJhS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 04:37:18 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so333691obc.15
        for <linux-omap@vger.kernel.org>; Thu, 10 Jan 2013 01:37:18 -0800 (PST)
In-Reply-To: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chen Gang <gang.chen@asianux.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>

The name of the firmware (drv_datap->base_img) could potentially
become equal to 255 valid characters (size of exec_file), this
will result in an out of bounds write, given that the 255 chars
along with a '\0' terminator will be copied into an array of
255 chars.

Produce an error on this cases, because the driver expects the NULL
ending to be among the 255 char limit.

Reported-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
---
 drivers/staging/tidspbridge/rmgr/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/tidspbridge/rmgr/proc.c
index 5e43938..ac016ed 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -394,7 +394,7 @@ static int get_exec_file(struct cfg_devnode *dev_node_obj,
 		if (!drv_datap || !drv_datap->base_img)
 			return -EFAULT;
 
-		if (strlen(drv_datap->base_img) > size)
+		if (strlen(drv_datap->base_img) >= size)
 			return -EINVAL;
 
 		strcpy(exec_file, drv_datap->base_img);
-- 
1.7.4.4


From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: [PATCH 2/5] staging: tidspbridge: fix memory corruption on long string names
Date: Thu, 10 Jan 2013 03:36:59 -0600
Message-ID: <1357810622-1709-3-git-send-email-omar.ramirez@copitl.com>
References: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34056 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab3AJJhU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jan 2013 04:37:20 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so331872obb.5
        for <linux-omap@vger.kernel.org>; Thu, 10 Jan 2013 01:37:19 -0800 (PST)
In-Reply-To: <1357810622-1709-1-git-send-email-omar.ramirez@copitl.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chen Gang <gang.chen@asianux.com>, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, Omar Ramirez Luna <omar.ramirez@copitl.com>

The value allocated doesn't match the one that is meant to be
stored, resulting in corruption of memory for longer strings
that can't be held in such space.

Fix by allocating the correct byte value for the string meant to
be stored.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@copitl.com>
---
 drivers/staging/tidspbridge/rmgr/dbdcd.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/dbdcd.c b/drivers/staging/tidspbridge/rmgr/dbdcd.c
index 9d52c3c..3d2a26f 100644
--- a/drivers/staging/tidspbridge/rmgr/dbdcd.c
+++ b/drivers/staging/tidspbridge/rmgr/dbdcd.c
@@ -852,8 +852,7 @@ int dcd_register_object(struct dsp_uuid *uuid_obj,
 				goto func_end;
 			}
 
-			dcd_key->path = kmalloc(strlen(sz_reg_key) + 1,
-								GFP_KERNEL);
+			dcd_key->path = kmalloc(dw_path_size, GFP_KERNEL);
 
 			if (!dcd_key->path) {
 				kfree(dcd_key);
-- 
1.7.4.4


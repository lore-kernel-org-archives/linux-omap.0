Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A06C433DB
	for <linux-omap@archiver.kernel.org>; Mon, 22 Mar 2021 10:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CBB61983
	for <linux-omap@archiver.kernel.org>; Mon, 22 Mar 2021 10:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCVKxP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 22 Mar 2021 06:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhCVKxL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 22 Mar 2021 06:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B10661983;
        Mon, 22 Mar 2021 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616410391;
        bh=4U0eak1ORtelSunJ9eE7hPB3yqAxnqQRBSFUlGf+63c=;
        h=From:To:Cc:Subject:Date:From;
        b=RgVbcb5GDL09XMuNQ6ApRvSec2jt7qHQUtsB2qr0geekYNbvLm3amzMeHiPM946Uf
         Cx+8jLIVhr+YZxrmgmMTIGIK6bysN08+ys+ORnyf3sDus3Iyd2ziWZKI/bhctiXAfs
         Q/MXso1NWbkvBHfvVVZPv5XDYGuGq/aWV0534Qe4ljZHiFeYnyYz3fV/4vuI6FDzfS
         7n4r6bbscyZZk8UJSFtvJPIlNUkx+Eglq3PM5ikRJEi/VzThTl1lTNdiriwlZ5tTj4
         QZ2ZrJLUtkAYEvlxqhW2ssKRjo+eNWLSXpyZCuAu6X+CTxJzGI9JQ0jfNtmxL6/Blo
         TiIiMRucxsIew==
From:   Arnd Bergmann <arnd@kernel.org>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fbdev: omapfb: avoid -Wempty-body warning
Date:   Mon, 22 Mar 2021 11:52:59 +0100
Message-Id: <20210322105307.1291840-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' shows a few harmless warnings:

drivers/video/fbdev/omap2/omapfb/omapfb-main.c: In function 'omapfb_calc_addr':
drivers/video/fbdev/omap2/omapfb/omapfb-main.c:823:56: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  823 |                     var->xoffset, var->yoffset, offset);
      |                                                        ^
drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c: In function 'omapfb_ioctl':
drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:911:45: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  911 |                 DBG("ioctl failed: %d\n", r);

Avoid these by using no_printk(), which adds format string checking as
well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/omap2/omapfb/omapfb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb.h b/drivers/video/fbdev/omap2/omapfb/omapfb.h
index d27abccb37bc..1c1b5201c8b6 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb.h
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb.h
@@ -29,7 +29,7 @@ extern bool omapfb_debug;
 			printk(KERN_DEBUG "OMAPFB: " format, ## __VA_ARGS__); \
 	} while (0)
 #else
-#define DBG(format, ...)
+#define DBG(format, ...) no_printk(format, ## __VA_ARGS__)
 #endif
 
 #define FB2OFB(fb_info) ((struct omapfb_info *)(fb_info->par))
-- 
2.29.2


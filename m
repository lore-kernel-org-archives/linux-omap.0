From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 2/5] davinci: fb: remove duplicated #include
Date: Sun, 27 Sep 2009 11:15:07 +0800
Message-ID: <1254021307-3060-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:36981 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZI0DPH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Sep 2009 23:15:07 -0400
Received: by pxi32 with SMTP id 32so2723922pxi.4
        for <linux-omap@vger.kernel.org>; Sat, 26 Sep 2009 20:15:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: imre.deak@nokia.com
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  drivers/video/da8xx-fb.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 drivers/video/da8xx-fb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 42e1005..d065894 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -26,7 +26,6 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
-#include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <video/da8xx-fb.h>
-- 
1.6.1.3


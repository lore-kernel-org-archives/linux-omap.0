From: Kevin Hilman <khilman@linaro.org>
Subject: [PATCH] mfd: twl-core: convert to module_init()
Date: Fri, 31 May 2013 13:56:34 -0700
Message-ID: <1370033794-5357-1-git-send-email-khilman@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61698 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909Ab3EaU4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 May 2013 16:56:38 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so2827928pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 31 May 2013 13:56:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, open list <linux-kernel@vger.kernel.org>

There's no reason for twl-core to be subsys_inicall anymore.  Anything
using twl that early needs a rethink, or deferred probe changes.

Boot tested and RTC wake tested (via TWL RTC) on OMAP platforms:
3530/Beagle, 3730/Beagle-xM, 3530/Overo, 3730/Overo-STORM, 4430/Panda,
4460/Panda-ES.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 89ab4d9..7749b9e 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1309,7 +1309,7 @@ static int __init twl_init(void)
 {
 	return i2c_add_driver(&twl_driver);
 }
-subsys_initcall(twl_init);
+module_init(twl_init);
 
 static void __exit twl_exit(void)
 {
-- 
1.8.2


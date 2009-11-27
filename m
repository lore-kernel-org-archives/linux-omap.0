From: Daniel J Blueman <daniel.blueman@gmail.com>
Subject: [patch] fix OMAP HDQ build failure...
Date: Fri, 27 Nov 2009 12:24:11 +0000
Message-ID: <6278d2220911270424qd7f2f0diacdf1bd7f9c2652b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:56189 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZK0MYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 07:24:06 -0500
Received: by ey-out-2122.google.com with SMTP id 25so122204eya.5
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 04:24:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Fix TI OMAP HDQ driver build failure, from missing include.

Signed-off-by: Daniel J Blueman <daniel.blueman@gmaill.com>

diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
index 0d92969..29d0556 100644
--- a/drivers/w1/masters/omap_hdq.c
+++ b/drivers/w1/masters/omap_hdq.c
@@ -10,6 +10,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/err.h>
-- 
Daniel J Blueman

From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Fix compile omap3 boards if CONFIG_PM is not set
Date: Mon, 20 Apr 2009 10:15:55 -0700
Message-ID: <20090420171553.GH27304@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64074 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbZDTRQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Apr 2009 13:16:00 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a minimal build fix, please queue.

Regards,

Tony

--9amGYk9869ThD9tj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="musb-fix-compile-no-pm.patch"

>From 4b1d3e9c32fb21056a1a8a20374be82e1d97d2c0 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 20 Apr 2009 10:06:35 -0700
Subject: [PATCH] musb_hdrc: Fix compile omap3 boards if CONFIG_PM is not set

Otherwise we'll get:

drivers/usb/musb/musb_core.c:2206: error: 'musb_resume_early' undeclared
here (not in a function)

CONFIG_PM is not merged yet to mainline three for omap3.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 0112353..6c1cc8e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2192,6 +2192,7 @@ static int musb_resume_early(struct platform_device *pdev)
 #else
 #define	musb_suspend	NULL
 #define	musb_resume	NULL
+#define	musb_resume_early	NULL
 #endif
 
 static struct platform_driver musb_driver = {

--9amGYk9869ThD9tj--

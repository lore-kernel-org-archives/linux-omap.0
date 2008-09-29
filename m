From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 17/22] Move I2C driver model init earlier in the boot sequence
Date: Mon, 29 Sep 2008 16:14:34 +0300
Message-ID: <1222694079-16289-18-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-12-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-13-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-14-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-15-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-16-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-17-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29681 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbYI2NP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:26 -0400
In-Reply-To: <1222694079-16289-17-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

This avoids oopsing in statically linked systems when some
subsystems register I2C drivers in subsys_initcall() code,
but those subsystems are linked (and initialized) before I2C.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/i2c-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index b346a68..f520108 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -978,7 +978,7 @@ static void __exit i2c_exit(void)
 	bus_unregister(&i2c_bus_type);
 }
 
-subsys_initcall(i2c_init);
+postcore_initcall(i2c_init);
 module_exit(i2c_exit);
 
 /* ----------------------------------------------------
-- 
1.6.0.2.307.gc427


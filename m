From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 16/23] Move I2C driver model init earlier in the boot sequence
Date: Tue, 30 Sep 2008 13:05:53 +0300
Message-ID: <1222769160-31615-17-git-send-email-felipe.balbi@nokia.com>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-2-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-3-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-4-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-5-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-6-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-7-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-8-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-9-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-10-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-11-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-12-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-13-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-14-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-15-git-send-email-felipe.balbi@nokia.com>
 <1222769160-31615-16-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58458 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbYI3KHC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 06:07:02 -0400
In-Reply-To: <1222769160-31615-16-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

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


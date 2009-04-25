From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] regulator core: fix double-free in regulator_register()
 error path
Date: Sat, 25 Apr 2009 05:28:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49231 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbZDYL2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Apr 2009 07:28:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net


During regulator registration, any error after device_register() will 
cause a double-free on the struct regulator_dev 'rdev'.  The bug is in 
drivers/regulator/core.c:regulator_register():

...
scrub:
	device_unregister(&rdev->dev);
clean:
	kfree(rdev);                           <---
	rdev = ERR_PTR(ret);
	goto out;
...

device_unregister() calls regulator_dev_release() which frees rdev.  The 
subsequent kfree corrupts memory and causes some OMAP3 systems to oops on 
boot in regulator_get().

Applies against 2.6.30-rc3.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/regulator/core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 01f7702..fabd2e0 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2080,6 +2080,10 @@ out:
 
 scrub:
 	device_unregister(&rdev->dev);
+	/* device core frees rdev */
+	rdev = ERR_PTR(ret);
+	goto out;
+
 clean:
 	kfree(rdev);
 	rdev = ERR_PTR(ret);
-- 
1.6.3.rc1.51.gea0b7


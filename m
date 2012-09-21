From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2] PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE, even when disabled
Date: Fri, 21 Sep 2012 15:47:34 -0700
Message-ID: <1348267654-30697-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60845 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758328Ab2IUWrh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 18:47:37 -0400
Received: by pbbrr4 with SMTP id rr4so3553225pbb.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 15:47:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, Alan Stern <stern@rowland.harvard.edu>

From: Kevin Hilman <khilman@ti.com>

There are several drivers where the return value of
pm_runtime_get_sync() is used to decide whether or not it is safe to
access hardware and that don't provide .suspend() callbacks for system
suspend (but may use late/noirq callbacks.)  If such a driver happens
to call pm_runtime_get_sync() during system suspend, after the core
has disabled runtime PM, it will get the error code and will decide
that the hardware should not be accessed, although this may be a wrong
conclusion, depending on the state of the device when runtime PM was
disabled.

Drivers might work around this problem by using a test like:

   ret = pm_runtime_get_sync(dev);
   if (!ret || (ret == -EACCES && driver_private_data(dev)->suspended)) {
      /* access hardware */
   }

where driver_private_data(dev)->suspended is a flag set by the
driver's .suspend() method (that would have to be added for this
purpose).  However, that potentially would need to be done by multiple
drivers which means quite a lot of duplicated code and bloat.

To avoid that we can use the observation that the core sets
dev->power.is_suspended before disabling runtime PM and use that
instead of the driver's private flag.  Still, potentially many drivers
would need to repeat that same check in quite a few places, so it's
better to let the core do it.

Then we can be a bit smarter and check whether or not runtime PM was
disabled by the core only (disable_depth == 1) or by someone else in
addition to the core (disable_depth > 1).  In the former case
rpm_resume() can return 1 if the runtime PM status is RPM_ACTIVE,
because it means the device was active when the core disabled runtime
PM.  In the latter case it should still return -EACCES, because it
isn't clear why runtime PM has been disabled.

Tested on AM3730/Beagle-xM where a wakeup IRQ firing during the late
suspend phase triggers runtime PM activity in the I2C driver since the
wakeup IRQ is on an I2C-connected PMIC.

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
v2: 
- major changelog rewrite, based largely on input from Rafael 
- add check for disable_depth == 1 and move to separate if statement,
  both suggested by Alan Stern
    

 drivers/base/power/runtime.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7d9c1cb..d43856b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -509,6 +509,9 @@ static int rpm_resume(struct device *dev, int rpmflags)
  repeat:
 	if (dev->power.runtime_error)
 		retval = -EINVAL;
+	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
+		 && dev->power.runtime_status == RPM_ACTIVE)
+		retval = 1;
 	else if (dev->power.disable_depth > 0)
 		retval = -EACCES;
 	if (retval)
-- 
1.7.9.2


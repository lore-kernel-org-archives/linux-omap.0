From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH RESEND] PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE, even when disabled
Date: Thu, 20 Sep 2012 14:29:02 -0700
Message-ID: <1348176542-28983-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46417 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2ITV3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 17:29:04 -0400
Received: by pbbrr4 with SMTP id rr4so1077991pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 20 Sep 2012 14:29:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>

From: Kevin Hilman <khilman@ti.com>

When runtime PM is disabled, what we want is for callbacks not to be
called from then on.  However, currently, when runtime PM is disabled,
operations such as 'get' will also fail even if the device is
currently active.

Since calling 'get' on a device that is already RPM_ACTIVE does not
involve calling the callbacks, it should be allowed to succeed, even
if runtime PM is disabled.

This is particularily useful in runtime PM enabled drivers that are
used during system suspend.  Because runtime PM is disabled during
system suspend, currently any driver's use of pm_runtime_get* will
fail with -EACCES.  This is expected if the device was already runtime
suspended, but if the device is actually active (due to recent usage,
autosuspend timeout not expired, or pm_runtime_resume() called in
->suspend() method), the pm_runtime_get*() call should actually
succeed.

To permit the usage described above, add a check to rpm_resume() so
that success is returned in the case where a driver is suspended (it's
->suspend callback has been called) but is still RPM_ACTIVE.

This patch was developed in close collaboration with Rafael J. Wysocki
<rjw@sisk.pl>

Tested on AM3730/Beagle-xM where wakeup IRQ firing during the late
suspend phase triggers runtime PM activity in the I2C driver since the
wakeup IRQ is on an I2C-connected PMIC.

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
This version is just a resend with the vger address for linux-pm.

 drivers/base/power/runtime.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7d9c1cb..dafa5ec 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -510,7 +510,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	if (dev->power.runtime_error)
 		retval = -EINVAL;
 	else if (dev->power.disable_depth > 0)
-		retval = -EACCES;
+		retval = dev->power.is_suspended && 
+			dev->power.runtime_status == RPM_ACTIVE ? 1 : -EACCES;
 	if (retval)
 		goto out;
 
-- 
1.7.9.2


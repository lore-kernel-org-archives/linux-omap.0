From: Kevin Hilman <khilman@ti.com>
Subject: Re: runtime PM usage_count during driver_probe_device()?
Date: Fri, 01 Jul 2011 07:44:19 -0700
Message-ID: <87d3hu6oxo.fsf@ti.com>
References: <87k4c3dktm.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:57782 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756621Ab1GAOoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 10:44:25 -0400
Received: by iwl42 with SMTP id 42so3199985iwl.38
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 07:44:22 -0700 (PDT)
In-Reply-To: <87k4c3dktm.fsf@ti.com> (Kevin Hilman's message of "Thu, 30 Jun
	2011 15:19:01 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@ti.com> writes:

[...]

>     If the device bus type's or driver's ->probe() or ->remove()
>     callback runs pm_runtime_suspend() or pm_runtime_idle() or their
>     asynchronous counterparts, they will fail returning -EAGAIN, because
>     the device's usage counter is incremented by the core before
>     executing ->probe() and ->remove().  Still, it may be desirable to
>     suspend the device as soon as ->probe() or ->remove() has finished,
>     so the PM core uses pm_runtime_idle_sync() to invoke the
>     subsystem-level idle callback for the device at that time.

[...]

> Another curiosity is that, contrary to the above documentation, there is
> no usage_count increment before the bus/driver ->remove() (although
> there is a _get_sync/_put_sync around the sysfs_remove and notifier just
> before the bus/driver->remove().

OK, so the ->probe() part has been explained and makes sense, but I
would expect ->remove() to be similarily protected (as the documentation
states.)  But that is not the case.  Is that a bug?  If so, patch below
makes the code match the documentation.

Kevin

>From eef73ab2feb203bacb57dc35862f2a9969b61593 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Fri, 1 Jul 2011 07:37:47 -0700
Subject: [PATCH] driver core: prevent runtime PM races with ->remove()

Runtime PM Documentation states that the runtime PM usage count is
incremented during driver ->probe() and ->remove().  This is designed
to prevent driver runtime PM races with subsystems which may initiate
runtime PM transitions before during and after drivers are loaded.

Current code increments the usage_count during ->probe() but not
during ->remove().  This patch fixes the ->remove() part and makes the
code match the documentation.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/base/dd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 6658da7..47e079d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -329,13 +329,13 @@ static void __device_release_driver(struct device *dev)
 			blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 						     BUS_NOTIFY_UNBIND_DRIVER,
 						     dev);
-
-		pm_runtime_put_sync(dev);
-
 		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
 			drv->remove(dev);
+
+		pm_runtime_put_sync(dev);
+
 		devres_release_all(dev);
 		dev->driver = NULL;
 		klist_remove(&dev->p->knode_driver);
-- 
1.7.4


From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq handlers
Date: Thu,  1 Sep 2011 11:12:02 -0700
Message-ID: <1314900722-10252-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:51777 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755404Ab1IASL3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 14:11:29 -0400
Received: by mail-gx0-f178.google.com with SMTP id 8so1927951gxk.23
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 11:11:28 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

The suspend/resume _noirq handlers were #ifdef'd out in the
!CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
struct.  Fix by defining them to NULL in the !CONFIG_SUSPEND case.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v3.1-rc4.

 arch/arm/plat-omap/omap_device.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9a6a538..02609ee 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -615,6 +615,9 @@ static int _od_resume_noirq(struct device *dev)
 
 	return pm_generic_resume_noirq(dev);
 }
+#else
+#define _od_suspend_noirq NULL
+#define _od_resume_noirq NULL
 #endif
 
 static struct dev_pm_domain omap_device_pm_domain = {
-- 
1.7.6


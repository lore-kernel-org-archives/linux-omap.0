From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/3] RTC: omap-rtc: enable for SOC_AM33XX
Date: Thu, 18 Oct 2012 17:53:49 +0200
Message-ID: <1350575631-15523-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:32969 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756251Ab2JRPyG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 11:54:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it, david-b@pacbell.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, koen@dominion.thruhere.net, Daniel Mack <zonque@gmail.com>

The same IP is found on AM33xx as well, so let users select it.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 19c03ab..5cb5be7 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -777,7 +777,7 @@ config RTC_DRV_IMXDI
 
 config RTC_DRV_OMAP
 	tristate "TI OMAP1"
-	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX
+	depends on ARCH_OMAP15XX || ARCH_OMAP16XX || ARCH_OMAP730 || ARCH_DAVINCI_DA8XX || SOC_AM33XX
 	help
 	  Say "yes" here to support the real time clock on TI OMAP1 and
 	  DA8xx/OMAP-L13x chips.  This driver can also be built as a
-- 
1.7.11.7


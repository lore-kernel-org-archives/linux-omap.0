From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 5/8] hwspinlock/omap: support AM33xx
Date: Thu, 10 Oct 2013 16:15:32 -0500
Message-ID: <1381439735-52888-6-git-send-email-s-anna@ti.com>
References: <1381439735-52888-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56665 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757299Ab3JJVQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Oct 2013 17:16:45 -0400
In-Reply-To: <1381439735-52888-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Kumar Gala <galak@codeaurora.org>, Paul Walmsley <paul@pwsan.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

AM33XX device family also supports hwspinlocks. The IP
is identical to that of OMAP4/OMAP5, except for the
number of locks.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 70637d2..34ff9cd 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -10,7 +10,7 @@ menu "Hardware Spinlock drivers"
 
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
-	depends on ARCH_OMAP4 || SOC_OMAP5
+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_AM33XX
 	select HWSPINLOCK
 	help
 	  Say y here to support the OMAP Hardware Spinlock device (firstly
-- 
1.8.4


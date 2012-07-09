From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: [PATCH v2 2/3] Watchdog: Omap: select watchdog core for framework change
Date: Mon, 9 Jul 2012 15:35:27 +0800
Message-ID: <1341819328-3514-3-git-send-email-zumeng.chen@windriver.com>
References: <1341819328-3514-1-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33291 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab2GIHgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 03:36:10 -0400
In-Reply-To: <1341819328-3514-1-git-send-email-zumeng.chen@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: shubhrajyoti@ti.com, hvaibhav@ti.com, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul.gortmaker@windriver.com, tony@atomide.com

Since the current watchdog framework depends on the watchdog core
so select it in Kconfig.

Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
---
 drivers/watchdog/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fe819b7..fb5b108 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -232,6 +232,7 @@ config EP93XX_WATCHDOG
 config OMAP_WATCHDOG
 	tristate "OMAP Watchdog"
 	depends on ARCH_OMAP16XX || ARCH_OMAP2PLUS
+	select WATCHDOG_CORE
 	help
 	  Support for TI OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog.  Say 'Y'
 	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430 watchdog timer.
-- 
1.7.5.4


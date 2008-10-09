From: Daniel Stone <daniel.stone@nokia.com>
Subject: [PATCH 1/2] Input: Touchscreen: Make TSC2005 depend on SPI
Date: Thu,  9 Oct 2008 12:52:13 +0300
Message-ID: <1223545934-18445-1-git-send-email-daniel.stone@nokia.com>
References: <20081009094224.GK6212@intune.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42637 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbYJIJtb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 05:49:31 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m999nI8w008744
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 04:49:29 -0500
Received: from intune.research.nokia.com (intune.research.nokia.com [172.21.50.54])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m999nMb1027821
	for <linux-omap@vger.kernel.org>; Thu, 9 Oct 2008 12:49:22 +0300
In-Reply-To: <20081009094224.GK6212@intune.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Make Kconfig reflect reality.

Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
---
 drivers/input/touchscreen/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index d33f450..84ba956 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -219,6 +219,7 @@ config TOUCHSCREEN_ATMEL_TSADCC
 
 config TOUCHSCREEN_TSC2005
 	tristate "TSC2005 touchscreen support"
+	depends on SPI_MASTER
 	help
 	  Say Y here for if you are using the touchscreen features of TSC2005.
 
-- 
1.5.6.3


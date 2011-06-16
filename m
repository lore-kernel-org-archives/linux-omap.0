From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] cbus: move cbus under drivers/Kconfig
Date: Thu, 16 Jun 2011 14:27:18 +0300
Message-ID: <1308223638-9634-4-git-send-email-balbi@ti.com>
References: <1308223638-9634-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:44133 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755456Ab1FPL1e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 07:27:34 -0400
Received: by mail-fx0-f51.google.com with SMTP id 5so270411fxm.38
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 04:27:33 -0700 (PDT)
In-Reply-To: <1308223638-9634-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

all drivers should appear under "Device Drivers"

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/Kconfig |    4 ----
 drivers/Kconfig  |    2 ++
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 037ecda..9adc278 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2031,10 +2031,6 @@ source "net/Kconfig"
 
 source "drivers/Kconfig"
 
-if ARCH_OMAP
-source "drivers/cbus/Kconfig"
-endif
-
 source "fs/Kconfig"
 
 source "arch/arm/Kconfig.debug"
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 3bb154d..e6c60d4 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -2,6 +2,8 @@ menu "Device Drivers"
 
 source "drivers/base/Kconfig"
 
+source "drivers/cbus/Kconfig"
+
 source "drivers/connector/Kconfig"
 
 source "drivers/mtd/Kconfig"
-- 
1.7.6.rc1


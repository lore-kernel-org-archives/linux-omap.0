From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: omap2plus_defconfig: EHCI driver is not stable, disable it
Date: Fri,  6 Jul 2012 11:20:28 -0700
Message-ID: <1341598828-31410-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:33578 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754180Ab2GFSUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 14:20:31 -0400
Received: by pbbrp12 with SMTP id rp12so16239774pbb.29
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 11:20:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The EHCI driver is not stable enough to be enabled by default.  In v3.5,
it has at least the following problems:

- warning dump during bootup
- hang during suspend
- prevents CORE powerdomain from entering retention during idle (even
  when no USB devices connected.)

This demonstrates that this driver has not been thoroughly tested and
therfore should not be enabled in the default defconfig.

In addition, the problems above cause new PM regressions which need be
addressed before this driver should be enabled in the default
defconfig.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, this applies to your current fixes branch.   Please queue up for v3.5-rc
so this PM regression is fixed in v3.5.  Thanks.

 arch/arm/configs/omap2plus_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9854ff4..11828e6 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -176,7 +176,6 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_SUSPEND=y
 CONFIG_USB_MON=y
-CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_LIBUSUAL=y
-- 
1.7.9.2


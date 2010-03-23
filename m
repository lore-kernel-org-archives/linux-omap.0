From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 3/3] DSPBRIDGE: auto select mailbox when compiling bridge
Date: Tue, 23 Mar 2010 16:48:30 -0600
Message-ID: <1269384510-1526-4-git-send-email-omar.ramirez@ti.com>
References: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com>
 <1269384510-1526-2-git-send-email-omar.ramirez@ti.com>
 <1269384510-1526-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53295 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719Ab0CWWdJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 18:33:09 -0400
In-Reply-To: <1269384510-1526-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Auto select mailbox when compiling bridgedriver.

If selected as module, first install:
arch/arm/plat-omap/mailbox.ko
arch/arm/mach-omap2/mailbox_mach.ko

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com
---
 drivers/dsp/bridge/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
index c721f40..a3251c3 100644
--- a/drivers/dsp/bridge/Kconfig
+++ b/drivers/dsp/bridge/Kconfig
@@ -5,6 +5,7 @@
 menuconfig MPU_BRIDGE
 	tristate "DSP Bridge driver"
 	default n
+	select OMAP_MBOX_FWK
 	help
 	  DSP/BIOS Bridge is designed for platforms that contain a GPP and
 	  one or more attached DSPs.  The GPP is considered the master or
-- 
1.6.2.4


From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/4] ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses omap-device.o target so add one entry
Date: Tue, 8 May 2012 20:32:41 +0530
Message-ID: <1336489364-19200-2-git-send-email-hvaibhav@ti.com>
References: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44641 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab2EHPGx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 11:06:53 -0400
In-Reply-To: <1336489364-19200-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

All OMAP2PLUS based devices, builds omap-device.o target;
so just add one entry so that there is no need to patch this file
for any future OMAP2+ devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index ed8605f..c5b5f05 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -10,9 +10,7 @@ obj-n :=
 obj-  :=
 
 # omap_device support (OMAP2+ only at the moment)
-obj-$(CONFIG_ARCH_OMAP2) += omap_device.o
-obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
-obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
+obj-$(CONFIG_ARCH_OMAP2PLUS) += omap_device.o
 
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
-- 
1.7.0.4


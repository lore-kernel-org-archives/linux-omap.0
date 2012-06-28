From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 1/3] ARM: OMAP2+: CLEANUP: All OMAP2PLUS uses omap-device.o target so add one entry
Date: Thu, 28 Jun 2012 20:29:25 +0530
Message-ID: <1340895567-22766-2-git-send-email-hvaibhav@ti.com>
References: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43551 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936Ab2F1O7q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:59:46 -0400
In-Reply-To: <1340895567-22766-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

All OMAP2PLUS based devices, builds omap-device.o target;
so just add one entry so that there is no need to patch this file
for any future OMAP2+ devices.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>

NOTE: No code change from last version.
---
 arch/arm/plat-omap/Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 6d87532..961bf85 100644
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


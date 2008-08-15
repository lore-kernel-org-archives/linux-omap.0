From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 01/10] TI DSP BRIDGE: Kconfig Entry
Date: Fri, 15 Aug 2008 09:46:55 +0300
Message-ID: <1218782824-12596-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54793 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYHOGrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 02:47:25 -0400
In-Reply-To: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, x00omar@ti.com, x0023949@ti.com, soni.trilok@gmail.com, felipe.contreras@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Initial port from omapzoom:
	http://omapzoom.org/gf/project/omapbridge

For details,
http://omapzoom.org/gf/project/omapbridge/docman/?subdir=3

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/Kconfig |    1 +
 drivers/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cbc8406..154e315 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1232,6 +1232,7 @@ source "drivers/uio/Kconfig"
 if ARCH_OMAP
 source "drivers/cbus/Kconfig"
 source "drivers/dsp/dspgateway/Kconfig"
+source "drivers/dsp/bridge/Kconfig"
 endif
 
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 39cfe40..409e31a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -40,6 +40,7 @@ obj-y				+= base/ block/ misc/ mfd/ net/ media/ cbus/
 obj-y				+= i2c/
 obj-y				+= cbus/
 obj-$(CONFIG_ARCH_OMAP)		+= dsp/dspgateway/
+obj-$(CONFIG_MPU_BRIDGE)	+= dsp/bridge/
 obj-$(CONFIG_NUBUS)		+= nubus/
 obj-$(CONFIG_ATM)		+= atm/
 obj-y				+= macintosh/
-- 
1.5.5.1.357.g1af8b


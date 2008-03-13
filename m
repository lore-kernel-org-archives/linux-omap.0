From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] ARM: OMAP: Fix missing makefile options
Date: Thu, 13 Mar 2008 17:45:16 +0200
Message-ID: <1205423119-22292-4-git-send-email-tony@atomide.com>
References: omap-fixes-2008-03-13
 <1205423119-22292-1-git-send-email-tony@atomide.com>
 <1205423119-22292-2-git-send-email-tony@atomide.com>
 <1205423119-22292-3-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:60597 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbYCMPpo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 11:45:44 -0400
In-Reply-To: <1205423119-22292-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Although audio and dsp drivers are not integrated yet,
allow compiling in mailbox and mcbsp to see any build
warnings.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/Makefile |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index ce17df3..8f56c25 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -14,9 +14,14 @@ obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 # OCPI interconnect support for 1710, 1610 and 5912
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
+obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
 obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
 obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
 obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
 obj-$(CONFIG_I2C_OMAP) += i2c.o
+
+# OMAP mailbox framework
+obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
+
-- 
1.5.3.6


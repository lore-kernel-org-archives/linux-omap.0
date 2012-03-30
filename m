From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 1/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to prcm-common header
Date: Fri, 30 Mar 2012 19:24:13 +0530
Message-ID: <1333115655-28530-2-git-send-email-hvaibhav@ti.com>
References: <1333115655-28530-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46639 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759966Ab2C3OFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 10:05:24 -0400
In-Reply-To: <1333115655-28530-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tom.leiming@gmail.com, Vaibhav Hiremath <hvaibhav@ti.com>, Felipe Balbi <balbi@ti.com>

Add missing idle_st bit for 32k-sync timer into the prcm-common
header file, required for hwmod data.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/prcm-common.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 5aa5435..29955d5 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -177,6 +177,8 @@
 /* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
 #define OMAP24XX_ST_GPIOS_SHIFT				2
 #define OMAP24XX_ST_GPIOS_MASK				(1 << 2)
+#define OMAP24XX_ST_32KSYNC_SHIFT			1
+#define OMAP24XX_ST_32KSYNC_MASK			(1 << 1)
 #define OMAP24XX_ST_GPT1_SHIFT				0
 #define OMAP24XX_ST_GPT1_MASK				(1 << 0)

@@ -307,6 +309,8 @@
 #define OMAP3430_ST_SR1_MASK				(1 << 6)
 #define OMAP3430_ST_GPIO1_SHIFT				3
 #define OMAP3430_ST_GPIO1_MASK				(1 << 3)
+#define OMAP3430_ST_32KSYNC_SHIFT			2
+#define OMAP3430_ST_32KSYNC_MASK			(1 << 2)
 #define OMAP3430_ST_GPT12_SHIFT				1
 #define OMAP3430_ST_GPT12_MASK				(1 << 1)
 #define OMAP3430_ST_GPT1_SHIFT				0
--
1.7.0.4


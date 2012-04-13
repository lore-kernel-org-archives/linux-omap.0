From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 1/3] ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to prcm-common header
Date: Fri, 13 Apr 2012 15:09:05 +0530
Message-ID: <1334309947-25214-2-git-send-email-hvaibhav@ti.com>
References: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46972 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab2DMJja (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 05:39:30 -0400
In-Reply-To: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Felipe Balbi <balbi@ti.com>

Add missing idle_st bit for 32k-sync timer into the prcm-common
header file, required for hwmod data.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
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


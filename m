From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 7/9] omap3: Add CHIP_GE_OMAP3430ES3 for HSUSB
Date: Thu,  6 Aug 2009 17:37:38 +0530
Message-ID: <1249560460-16306-7-git-send-email-ajay.gupta@ti.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-2-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-4-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-5-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-6-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51623 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755272AbZHFMNg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 08:13:36 -0400
In-Reply-To: <1249560460-16306-6-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

OMAP3 HSUSB ports can be individually programmed in PHY or TLL
mode in ES3.0 onwards whereas this is not supported in ES2.1
and earlier versions.

CHIP_GE_OMAP3430ES3 is added to program this behavior at runtime.

Also updated the existing macros to use the priviously defined
*_GE_* logic instead of repeating the same logic again.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/plat-omap/include/mach/cpu.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 285eaa3..5848717 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -428,10 +428,11 @@ IS_OMAP_TYPE(3430, 0x3430)
  * chips at ES2 and beyond, but not, for example, any OMAP lines after
  * OMAP3.
  */
-#define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
-					 CHIP_IS_OMAP3430ES3_0 | \
-					 CHIP_IS_OMAP3430ES3_1)
 #define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
+#define CHIP_GE_OMAP3430ES3		(CHIP_IS_OMAP3430ES3_0 | \
+					 CHIP_GE_OMAP3430ES3_1)
+#define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
+					 CHIP_GE_OMAP3430ES3)
 
 
 int omap_chip_is(struct omap_chip_id oci);
-- 
1.6.2.4


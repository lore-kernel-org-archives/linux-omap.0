From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH v2 1/9] ARM: OMAP2+: AM33XX: CM: Get rid of unnecessary header inclusions
Date: Tue, 29 Jan 2013 12:29:14 +0530
Message-ID: <1359442762-13697-2-git-send-email-vaibhav.bedia@ti.com>
References: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53196 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030Ab3A2G7p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jan 2013 01:59:45 -0500
In-Reply-To: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

cm33xx.h unnecessarily includes a lot of header files.
Get rid of these and directly include "iomap.h" which
is needed to keep things compiling.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
v2: Reword the changelog

 arch/arm/mach-omap2/cm33xx.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cm33xx.h b/arch/arm/mach-omap2/cm33xx.h
index 5fa0b62..8009e13 100644
--- a/arch/arm/mach-omap2/cm33xx.h
+++ b/arch/arm/mach-omap2/cm33xx.h
@@ -17,16 +17,11 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 #define __ARCH_ARM_MACH_OMAP2_CM_33XX_H
 
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/io.h>
-
 #include "common.h"
 
 #include "cm.h"
 #include "cm-regbits-33xx.h"
-#include "cm33xx.h"
+#include "iomap.h"
 
 /* CM base address */
 #define AM33XX_CM_BASE		0x44e00000
-- 
1.8.1


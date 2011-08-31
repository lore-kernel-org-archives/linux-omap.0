From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 11/14] omap: mcbsp: Update mcbsp.h include dependencies
Date: Wed, 31 Aug 2011 18:22:58 +0300
Message-ID: <1314804181-17260-12-git-send-email-jarkko.nikula@bitmer.com>
References: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:36925 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777Ab1HaPlo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 11:41:44 -0400
In-Reply-To: <1314804181-17260-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Jarkko Nikula <jarkko.nikula@bitmer.com>

hardware.h is not needed here and let the definition for struct clk to come
via linux/clk.h.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 9802055..5d657d9 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -25,9 +25,7 @@
 #define __ASM_ARCH_OMAP_MCBSP_H
 
 #include <linux/spinlock.h>
-
-#include <mach/hardware.h>
-#include <plat/clock.h>
+#include <linux/clk.h>
 
 /* macro for building platform_device for McBSP ports */
 #define OMAP_MCBSP_PLATFORM_DEVICE(port_nr)		\
-- 
1.7.5.4


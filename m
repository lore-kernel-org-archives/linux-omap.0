From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ARM: OMAP2+: Remove obsolete Makefile line
Date: Thu, 30 May 2013 13:20:23 +0200
Message-ID: <1369912823.23034.46.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:57214 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968083Ab3E3LU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 07:20:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The OMAP runtime PM implementation was removed in v3.0. But one Makefile
line, which was used to tweak CFLAGS, was overlooked. Remove it too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. This cleans up after commit 638080c37a ("OMAP2+ / PM: move
runtime PM implementation to use device power domains").

 arch/arm/mach-omap2/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55a9d67..7279fa8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -93,10 +93,6 @@ obj-$(CONFIG_POWER_AVS_OMAP_CLASS3)    += smartreflex-class3.o
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
-ifeq ($(CONFIG_PM_VERBOSE),y)
-CFLAGS_pm_bus.o				+= -DDEBUG
-endif
-
 endif
 
 ifeq ($(CONFIG_CPU_IDLE),y)
-- 
1.7.11.7


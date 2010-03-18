From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] DSPBRIDGE: Remove autoconf.h dependency from host_os header
Date: Thu, 18 Mar 2010 15:57:08 -0600
Message-ID: <1268949429-30368-2-git-send-email-omar.ramirez@ti.com>
References: <1268949429-30368-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39254 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383Ab0CRVmN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 17:42:13 -0400
In-Reply-To: <1268949429-30368-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

There shouldn't be any dependency on the definitions generated
by autoconf.h, besides it is automatically included by the
build system.

This solves the following warning:

In file included from arch/arm/plat-omap/include/dspbridge/host_os.h:20,
                 from arch/arm/mach-omap2/io.c:51:
include/linux/autoconf.h:165:1: warning: "CONFIG_DEFAULT_IOSCHED" redefined
In file included from <command-line>:0:
./include/generated/autoconf.h:172:1: warning: this is the location of the previous definition

Signed-off-by: Omar Ramirez Luna <omar.ramirez@hotmail.com>
---
 arch/arm/plat-omap/include/dspbridge/host_os.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/host_os.h b/arch/arm/plat-omap/include/dspbridge/host_os.h
index 00ea285..92b12de 100644
--- a/arch/arm/plat-omap/include/dspbridge/host_os.h
+++ b/arch/arm/plat-omap/include/dspbridge/host_os.h
@@ -17,7 +17,6 @@
 #ifndef _HOST_OS_H_
 #define _HOST_OS_H_
 
-#include <linux/autoconf.h>
 #include <asm/system.h>
 #include <asm/atomic.h>
 #include <linux/semaphore.h>
-- 
1.6.2.4


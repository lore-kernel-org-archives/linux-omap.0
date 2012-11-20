From: Constantine Shulyupin <const@MakeLinux.com>
Subject: [PATCH] fix compilation error in cm_common.c
Date: Tue, 20 Nov 2012 11:25:53 +0200
Message-ID: <1353403553-13525-1-git-send-email-const@MakeLinux.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:40631 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751528Ab2KTJ0Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Nov 2012 04:26:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Constantine Shulyupin <const@MakeLinux.com>

From: Constantine Shulyupin <const@MakeLinux.com>

Added required linux/errno.h

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 arch/arm/mach-omap2/cm_common.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 3246cef..3fafc27 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
-- 
1.7.9.5


From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 13/13] ARM: OMAP2+: clock/interface: remove some headers from clkt_iclk.c file
Date: Wed, 2 Jul 2014 11:47:47 +0300
Message-ID: <1404290867-6768-14-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39745 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122AbaGBIsQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 04:48:16 -0400
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Instead, copy the used constants from the header file to the source file.
This allows the code to be migrated under drivers folder where we don't
have access to the OMAP specific header files.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_iclk.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_iclk.c b/arch/arm/mach-omap2/clkt_iclk.c
index 333f0a6..55eb579 100644
--- a/arch/arm/mach-omap2/clkt_iclk.c
+++ b/arch/arm/mach-omap2/clkt_iclk.c
@@ -14,11 +14,11 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 
-
 #include "clock.h"
-#include "clock2xxx.h"
-#include "cm2xxx_3xxx.h"
-#include "cm-regbits-24xx.h"
+
+/* Register offsets */
+#define CM_AUTOIDLE			0x30
+#define CM_ICLKEN			0x10
 
 /* Private functions */
 
-- 
1.7.9.5


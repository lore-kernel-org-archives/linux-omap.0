From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/16] OMAP2+: remove unneeded #include omapfb.h
Date: Tue, 24 Jan 2012 12:00:20 +0200
Message-ID: <1327399231-20826-6-git-send-email-tomi.valkeinen@ti.com>
References: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:40828 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755910Ab2AXKAz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:00:55 -0500
In-Reply-To: <1327399231-20826-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/io.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3f174d5..7fee69c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -21,7 +21,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/clk.h>
-#include <linux/omapfb.h>
 
 #include <asm/tlb.h>
 
-- 
1.7.4.1


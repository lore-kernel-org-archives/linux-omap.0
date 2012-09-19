From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 18/29] ARM: OMAP1: Move board-voiceblue.h from plat to mach
Date: Wed, 19 Sep 2012 14:06:18 -0700
Message-ID: <20120919210617.28074.97081.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43811 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:19 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is only used by omap1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-voiceblue.c              |    2 +-
 arch/arm/mach-omap1/include/mach/board-voiceblue.h |    0 
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/{plat-omap/include/plat/board-voiceblue.h => mach-omap1/include/mach/board-voiceblue.h} (100%)

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index bd7b3fc..64289ea 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -31,7 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board-voiceblue.h>
+#include <mach/board-voiceblue.h>
 #include <plat/flash.h>
 #include <mach/mux.h>
 #include <plat/tc.h>
diff --git a/arch/arm/plat-omap/include/plat/board-voiceblue.h b/arch/arm/mach-omap1/include/mach/board-voiceblue.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/board-voiceblue.h
rename to arch/arm/mach-omap1/include/mach/board-voiceblue.h


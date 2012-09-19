From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 17/29] ARM: OMAP1: Move board-sx1.h from plat to mach
Date: Wed, 19 Sep 2012 14:06:16 -0700
Message-ID: <20120919210615.28074.75953.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26364 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVGR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:17 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is only used by omap1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-sx1-mmc.c          |    2 +-
 arch/arm/mach-omap1/board-sx1.c              |    2 +-
 arch/arm/mach-omap1/include/mach/board-sx1.h |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/{plat-omap/include/plat/board-sx1.h => mach-omap1/include/mach/board-sx1.h} (100%)

diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index b59f788..5932d56 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -17,7 +17,7 @@
 
 #include <mach/hardware.h>
 #include <plat/mmc.h>
-#include <plat/board-sx1.h>
+#include <mach/board-sx1.h>
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2f136ea..e5edabf 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -39,7 +39,7 @@
 #include <plat/irda.h>
 #include <plat/tc.h>
 #include <mach/keypad.h>
-#include <plat/board-sx1.h>
+#include <mach/board-sx1.h>
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/plat-omap/include/plat/board-sx1.h b/arch/arm/mach-omap1/include/mach/board-sx1.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/board-sx1.h
rename to arch/arm/mach-omap1/include/mach/board-sx1.h


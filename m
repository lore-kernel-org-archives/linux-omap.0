From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/29] ARM: OMAP2+: Make board-rx51.h local
Date: Wed, 19 Sep 2012 14:06:01 -0700
Message-ID: <20120919210601.28074.66797.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26179 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752044Ab2ISVGC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:02 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c  |    2 +-
 arch/arm/mach-omap2/board-rx51-video.c        |    2 +-
 arch/arm/mach-omap2/board-rx51.h              |    0 
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/mach-omap2/{include/mach/board-rx51.h => board-rx51.h} (100%)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 5b2edfe..bf78ad4 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -35,7 +35,7 @@
 #include <plat/gpmc-smc91x.h>
 #include <plat/omap-pm.h>
 
-#include <mach/board-rx51.h>
+#include "board-rx51.h"
 
 #include <sound/tlv320aic3x.h>
 #include <sound/tpa6130a2-plat.h>
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 2c1289b..6e5b196 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -19,7 +19,7 @@
 #include <plat/vram.h>
 #include <plat/mcspi.h>
 
-#include <mach/board-rx51.h>
+#include "board-rx51.h"
 
 #include "mux.h"
 
diff --git a/arch/arm/mach-omap2/include/mach/board-rx51.h b/arch/arm/mach-omap2/board-rx51.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/board-rx51.h
rename to arch/arm/mach-omap2/board-rx51.h


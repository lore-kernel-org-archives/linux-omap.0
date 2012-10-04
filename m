From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/16] ARM: OMAP2+: Make board-zoom.h local
Date: Thu, 04 Oct 2012 15:04:34 -0700
Message-ID: <20121004220434.26676.45714.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:27504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752291Ab2JDWEf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 18:04:35 -0400
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-3630sdp.c           |    2 +-
 arch/arm/mach-omap2/board-ldp.c               |    2 +-
 arch/arm/mach-omap2/board-zoom-debugboard.c   |    2 +-
 arch/arm/mach-omap2/board-zoom-display.c      |    2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |    2 +-
 arch/arm/mach-omap2/board-zoom.c              |    2 +-
 arch/arm/mach-omap2/board-zoom.h              |    0 
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/mach-omap2/{include/mach/board-zoom.h => board-zoom.h} (100%)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index fc224ad..f1df601 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -20,7 +20,7 @@
 #include "gpmc-smc91x.h"
 #include <plat/usb.h>
 
-#include <mach/board-zoom.h>
+#include "board-zoom.h"
 
 #include "board-flash.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ee8c3cf..4a784ef 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -36,7 +36,7 @@
 
 #include "common.h"
 #include <plat/gpmc.h>
-#include <mach/board-zoom.h>
+#include "board-zoom.h"
 #include <plat/usb.h>
 #include "gpmc-smsc911x.h"
 
diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index afb2278..36c8767 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -20,7 +20,7 @@
 #include <plat/gpmc.h>
 #include "gpmc-smsc911x.h"
 
-#include <mach/board-zoom.h>
+#include "board-zoom.h"
 
 #include "soc.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index b940ab2..230cb33 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -16,7 +16,7 @@
 #include <linux/spi/spi.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <video/omapdss.h>
-#include <mach/board-zoom.h>
+#include "board-zoom.h"
 
 #include "common.h"
 
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 67f8540..01bfba5 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -28,7 +28,7 @@
 #include "common.h"
 #include <plat/usb.h>
 
-#include <mach/board-zoom.h>
+#include "board-zoom.h"
 
 #include "mux.h"
 #include "hsmmc.h"
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index 4994438..cbfd9df 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -24,7 +24,7 @@
 #include "common.h"
 #include <plat/usb.h>
 
-#include <mach/board-zoom.h>
+#include "board-zoom.h"
 
 #include "board-flash.h"
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/board-zoom.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/board-zoom.h
rename to arch/arm/mach-omap2/board-zoom.h


From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 24/29] ARM: OMAP1: Move irda.h from plat to mach
Date: Wed, 19 Sep 2012 14:06:30 -0700
Message-ID: <20120919210630.28074.64108.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26570 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:31 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is only used by omap1.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-h2.c          |    2 +-
 arch/arm/mach-omap1/board-palmte.c      |    2 +-
 arch/arm/mach-omap1/board-palmtt.c      |    2 +-
 arch/arm/mach-omap1/board-palmz71.c     |    2 +-
 arch/arm/mach-omap1/board-sx1.c         |    2 +-
 arch/arm/mach-omap1/include/mach/irda.h |    0 
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/{plat-omap/include/plat/irda.h => mach-omap1/include/mach/irda.h} (100%)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 166f90c..69f1513 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -41,7 +41,7 @@
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
-#include <plat/irda.h>
+#include <mach/irda.h>
 #include <mach/keypad.h>
 #include <mach/flash.h>
 
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index cbe17fa..08e1912 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -38,7 +38,7 @@
 #include <mach/mux.h>
 #include <plat/tc.h>
 #include <plat/dma.h>
-#include <plat/irda.h>
+#include <mach/irda.h>
 #include <mach/keypad.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 5df8672..938eaff 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -38,7 +38,7 @@
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
-#include <plat/irda.h>
+#include <mach/irda.h>
 #include <mach/keypad.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index b087ba0..b4341d0 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -40,7 +40,7 @@
 #include <mach/mux.h>
 #include <plat/dma.h>
 #include <plat/tc.h>
-#include <plat/irda.h>
+#include <mach/irda.h>
 #include <mach/keypad.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 87637e7..50b8536 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -36,7 +36,7 @@
 #include <mach/flash.h>
 #include <mach/mux.h>
 #include <plat/dma.h>
-#include <plat/irda.h>
+#include <mach/irda.h>
 #include <plat/tc.h>
 #include <mach/keypad.h>
 #include <mach/board-sx1.h>
diff --git a/arch/arm/plat-omap/include/plat/irda.h b/arch/arm/mach-omap1/include/mach/irda.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/irda.h
rename to arch/arm/mach-omap1/include/mach/irda.h


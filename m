From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 20/29] OMAP3: PM: Fixed header paths in include statements
Date: Thu, 11 Sep 2008 15:34:04 +0300
Message-ID: <1221136453-16697-20-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-10-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-11-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-12-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-13-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-14-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-15-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-16-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-17-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-18-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19019 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756016AbYIKMfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:35:06 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BCZ0Ew018889
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 15:35:04 +0300
In-Reply-To: <1221136453-16697-19-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   14 +++++++-------
 arch/arm/mach-omap2/pm34xx.c      |    2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index b19d2eb..11ff573 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -23,13 +23,13 @@
  */
 
 #include <linux/cpuidle.h>
-#include <asm/arch/pm.h>
-#include <asm/arch/prcm.h>
-#include <asm/arch/powerdomain.h>
-#include <asm/arch/clockdomain.h>
-#include <asm/arch/gpio.h>
-#include <asm/arch/gpmc.h>
-#include <asm/arch/control.h>
+#include <mach/pm.h>
+#include <mach/prcm.h>
+#include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
+#include <mach/gpio.h>
+#include <mach/gpmc.h>
+#include <mach/control.h>
 #include <linux/sched.h>
 #include "cpuidle34xx.h"
 #include "cm.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d6acf6c..46b0b20 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -31,7 +31,7 @@
 #include <mach/powerdomain.h>
 #include <mach/common.h>
 #include <mach/sdrc.h>
-#include <mach/tlbflush.h>
+#include <asm/tlbflush.h>
 #include "sdrc.h"
 
 #include "cm.h"
-- 
1.6.0


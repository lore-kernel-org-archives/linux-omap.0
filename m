From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] ARM: OMAP: don't build hwspinlock in vain
Date: Sun,  4 Mar 2012 13:05:29 +0200
Message-ID: <1330859129-354-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60530 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab2CDLGD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Mar 2012 06:06:03 -0500
Received: by wejx9 with SMTP id x9so1824139wej.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Mar 2012 03:06:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>

Cleanup: don't build mach-omap2/hwspinlock.c if the OMAP hwspinlock
driver isn't configured.

This will both shorten build time and avoid registering a device
which isn't needed.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
Tony, it's probably better if you take it, to minimize omap merge conflicts.
Thanks!

 arch/arm/mach-omap2/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 00d7025..5bce3bd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -268,7 +268,9 @@ obj-y					+= $(smc91x-m) $(smc91x-y)
 
 smsc911x-$(CONFIG_SMSC911X)		:= gpmc-smsc911x.o
 obj-y					+= $(smsc911x-m) $(smsc911x-y)
-obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
+ifneq ($(CONFIG_HWSPINLOCK_OMAP),)
+obj-y					+= hwspinlock.o
+endif
 
 obj-y					+= common-board-devices.o twl-common.o
 
-- 
1.7.5.4


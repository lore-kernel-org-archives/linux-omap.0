From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH] arch/arm/plat-omap/clock.c: included linux/debugfs.h twice
Date: Thu, 16 Feb 2012 15:43:53 +0100
Message-ID: <1329403433-32327-1-git-send-email-danny.kukawka@bisect.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:43342 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751220Ab2BPOoC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 09:44:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Danny Kukawka <dkukawka@suse.de>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

arch/arm/plat-omap/clock.c: included 'linux/debugfs.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/plat-omap/clock.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 567e4b5..56b6f8b 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -20,7 +20,6 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 #include <linux/cpufreq.h>
-#include <linux/debugfs.h>
 #include <linux/io.h>
 
 #include <plat/clock.h>
-- 
1.7.8.3


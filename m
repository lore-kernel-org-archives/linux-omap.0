From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 1/4] omap1: remove duplicated #include
Date: Fri, 28 Jan 2011 22:04:38 +0800
Message-ID: <1296223478-728-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:45301 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab1A1OEz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 09:04:55 -0500
Received: by pxi15 with SMTP id 15so447162pxi.19
        for <linux-omap@vger.kernel.org>; Fri, 28 Jan 2011 06:04:55 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  arch/arm/mach-omap1/time.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-omap1/time.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index f83fc33..6885d2f 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -44,7 +44,6 @@
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/io.h>
-#include <linux/sched.h>
 
 #include <asm/system.h>
 #include <mach/hardware.h>
-- 
1.6.1.3


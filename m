From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 1/5] OMAP2: remove duplicated #include
Date: Sun, 13 Dec 2009 21:13:37 +0800
Message-ID: <1260710017-3804-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:39759 "HELO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752156AbZLMNNu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Dec 2009 08:13:50 -0500
Received: by pwj9 with SMTP id 9so1434723pwj.21
        for <linux-omap@vger.kernel.org>; Sun, 13 Dec 2009 05:13:49 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove duplicated #include('s) in
  arch/arm/mach-omap2/clock34xx.c
  arch/arm/mach-omap2/io.c

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/arm/mach-omap2/clock34xx.c |    1 -
 arch/arm/mach-omap2/io.c        |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index ded3236..d4217b9 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -34,7 +34,6 @@
 #include <asm/div64.h>
 #include <asm/clkdev.h>
 
-#include <plat/sdrc.h>
 #include "clock.h"
 #include "clock34xx.h"
 #include "sdrc.h"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index a8749e8..ac9ea60 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -33,7 +33,6 @@
 #include <plat/sdrc.h>
 #include <plat/gpmc.h>
 #include <plat/serial.h>
-#include <plat/mux.h>
 #include <plat/vram.h>
 
 #include "clock.h"
-- 
1.6.1.3


From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH][trivial] ARM, OMAP, timer: Remove duplicate inclusion of
 linux/sched.h from arch/arm/mach-omap1/time.c
Date: Thu, 3 Feb 2011 22:58:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102032255090.1369@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, trivial@kernel.org
List-Id: linux-omap@vger.kernel.org

arch/arm/mach-omap1/time.c includes linux/sched.h twice - it's enough to 
do it once. This removes the duplicate.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 time.c |    1 -
 1 file changed, 1 deletion(-)

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
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.

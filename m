From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: OMAP2+: timer: Remove obsolete inclusion of
 <asm/smp_twd.h>
Date: Thu, 15 Nov 2018 10:58:58 +0100
Message-ID: <20181115095858.17530-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

As of commit d1dabab2841d546f ("ARM: OMAP2+: Clean up
omap4_local_timer_init"), this header file is no longer used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-omap2/timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 98ed5ac073bc1fca..07bea84c5d6e4f2a 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -44,7 +44,6 @@
 #include <linux/sched_clock.h>
 
 #include <asm/mach/time.h>
-#include <asm/smp_twd.h>
 
 #include "omap_hwmod.h"
 #include "omap_device.h"
-- 
2.17.1

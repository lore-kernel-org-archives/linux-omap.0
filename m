From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: init section mismatch for omap2/timer-gp
Date: Tue,  5 Jun 2007 18:00:32 -0700
Message-ID: <11810916332938-git-send-email-khilman@mvista.com>
References: <11810916331121-git-send-email-khilman@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11810916331121-git-send-email-khilman@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 arch/arm/mach-omap2/timer-gp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 8f380a1..948d7ec 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -175,6 +175,6 @@ static void __init omap2_gp_timer_init(void)
 	omap2_gp_clocksource_init();
 }
 
-struct sys_timer omap_timer = {
+struct sys_timer omap_timer __initdata = {
 	.init	= omap2_gp_timer_init,
 };
-- 
1.5.2

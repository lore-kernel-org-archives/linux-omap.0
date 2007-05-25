From: "nishanth menon" <menon.nishanth@gmail.com>
Subject: [PATCH 1/2] OMAP:2430SDP: kill warning1: remove link to .init.text
Date: Fri, 25 May 2007 17:30:53 -0500
Message-ID: <782515bb0705251530g5f9c2b7cn5c36331526850cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

omap_timer refers to __init omap2_gp_timer_init function causing a warning
while the linking is done

Signed-off-by: Nishanth Menon <menon.nishanth@gmail.com>
---
 arch/arm/mach-omap2/timer-gp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 8f380a1..f4cf6fe 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -175,6 +175,6 @@ static void __init omap2_gp_timer_init(void)
 	omap2_gp_clocksource_init();
 }

-struct sys_timer omap_timer = {
-	.init	= omap2_gp_timer_init,
+struct sys_timer omap_timer __initdata = {
+	.init	 = omap2_gp_timer_init,
 };
-- 
1.5.0.6

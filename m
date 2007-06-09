From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 12/12] Move omap_timer to the initdata section.
Date: Sat, 9 Jun 2007 20:47:51 +0200
Message-ID: <20070609184751.GL1889@varda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch fixes a warning due to omap_timer not belonging to the __initdata
section as it should.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 arch/arm/mach-omap1/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 3705d20..0ba739c 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -289,6 +289,6 @@ static void __init omap_timer_init(void)
 	omap_init_clocksource(rate);
 }
 
-struct sys_timer omap_timer = {
+struct sys_timer omap_timer __initdata = {
 	.init		= omap_timer_init,
 };
-- 
1.5.1.3

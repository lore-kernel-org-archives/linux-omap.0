From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: [PATCH 1/1] ARM: OMAP2: Remove redundant check on osc refcount
Date: Fri, 04 May 2007 16:19:24 +0300
Message-ID: <1178284764.21647.27.camel@Dogbert.NOE.nokia.com>
References: <20070502182859.GK3520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070502182859.GK3520@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The usage of the external oscillator is handled already by
sleep_block and doesn't require any extra checking.
Incidentally this fixes a bug where N800 wouldn't enter retention
the first time the display would blank.

Signed-off-by: Klaus Pedersen <klaus.k.pedersen@nokia.com>

Signed-off-by: Igor Stoppa <igor.stoppa@nokia.com>
---
 arch/arm/mach-omap2/pm.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index b3a0d9d..63e380f 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -621,8 +621,6 @@ static int omap2_can_sleep(void)
 		return 0;
 	if (atomic_read(&sleep_block) > 0)
 		return 0;
-	if (clk_get_usecount(osc_ck) > 1)
-		return 0;
 	if (omap_dma_running())
 		return 0;
 
-- 
1.5.1.3

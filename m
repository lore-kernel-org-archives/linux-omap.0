From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc5-omap1-git] fix OMAP1 dmtimer build warning
Date: Mon, 2 Apr 2007 12:45:50 -0700
Message-ID: <200704021245.50935.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Remove the OMAP1 version of omap_dm_timer_get_fclk(), and its associated
compile-time warning.  It would only BUG() if called, while it's only
called on OMAP2.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -271,11 +271,6 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 
 #if defined(CONFIG_ARCH_OMAP1)
 
-struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
-{
-	BUG();
-}
-
 /**
  * omap_dm_timer_modify_idlect_mask - Check if any running timers use ARMXOR
  * @inputmask: current value of idlect mask

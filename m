From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.19-rc6-omap1] remove duplicate omap watchdog kconfig
 entry
Date: Mon, 27 Nov 2006 23:28:29 -0800
Message-ID: <20061128072829.6EFD61E1901@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

I suspect this dup joined us when the driver got merged upstream.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- osk2.orig/drivers/char/watchdog/Kconfig	2006-10-25 14:06:49.000000000 -0700
+++ osk2/drivers/char/watchdog/Kconfig	2006-11-24 10:24:42.000000000 -0800
@@ -750,11 +750,4 @@ config USBPCWATCHDOG
 
 	  Most people will say N.
 
-config OMAP_WATCHDOG
-	tristate "OMAP Watchdog"
-	depends on WATCHDOG && (ARCH_OMAP16XX || ARCH_OMAP24XX)
-	help
-	  Support for TI OMAP1610/OMAP1710/OMAP2420 watchdog. Say 'Y' here to enable the
-	  OMAP1610/OMAP1710 watchdog timer.
-
 endmenu

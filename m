From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: Kconfig cleanup: allow to compile on non-ARM
Date: Wed, 13 Jun 2007 17:57:16 -0700
Message-ID: <20070614005716.458634944@mvista.com>
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

Remove 'source' of non-existant drivers/ssi/Kconfig.  Having this
there results in a kernel with the OMAP patch not being able to
compile for other platforms.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 drivers/Kconfig |    2 --
 1 file changed, 2 deletions(-)

Index: dev/drivers/Kconfig
===================================================================
--- dev.orig/drivers/Kconfig
+++ dev/drivers/Kconfig
@@ -84,6 +84,4 @@ source "drivers/auxdisplay/Kconfig"
 
 source "drivers/kvm/Kconfig"
 
-source "drivers/ssi/Kconfig"
-
 endmenu
--

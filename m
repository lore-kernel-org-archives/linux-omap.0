From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc4-omap1] restore CONFIG_GENERIC_TIME
Date: Wed, 28 Mar 2007 13:21:20 -0700
Message-ID: <200703281321.20517.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Somehow this got lost in a merge ...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- osk2.orig/arch/arm/Kconfig	2007-03-17 21:00:14.000000000 -0700
+++ osk2/arch/arm/Kconfig	2007-03-17 21:41:09.000000000 -0700
@@ -363,6 +363,7 @@ config ARCH_LH7A40X
 config ARCH_OMAP
 	bool "TI OMAP"
 	select GENERIC_GPIO
+	select GENERIC_TIME
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 

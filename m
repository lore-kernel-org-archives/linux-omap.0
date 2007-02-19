From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC, PATCH 2/7] ARM: Kconfig support for GENERIC_CLOCKEVENTS
Date: Mon, 19 Feb 2007 13:47:21 -0800
Message-ID: <20070219214739.839906000@mvista.com>
References: <20070219214719.379287000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=arm-kconfig-clockevents.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: tglx@linutronix.de, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>

Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -25,6 +25,10 @@ config GENERIC_TIME
 	bool
 	default n
 
+config GENERIC_CLOCKEVENTS
+	bool
+	default n
+
 config MMU
 	bool
 	default y
@@ -480,6 +484,8 @@ endmenu
 
 menu "Kernel Features"
 
+source "kernel/time/Kconfig"
+
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && REALVIEW_MPCORE
@@ -539,6 +545,7 @@ config PREEMPT
 
 config NO_IDLE_HZ
 	bool "Dynamic tick timer"
+	depends on !GENERIC_CLOCKEVENTS
 	help
 	  Select this option if you want to disable continuous timer ticks
 	  and have them programmed to occur as required. This option saves

--

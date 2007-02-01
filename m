From: Kevin Hilman <khilman@mvista.com>
Subject: [patch 2.6.20-rc6-rt6 3/6] ARM Kconfig support for
	GENERIC_CLOCKEVENTS
Date: Wed, 31 Jan 2007 16:13:03 -0800
Message-ID: <20070201001316.776320000@mvista.com>
References: <20070201001300.820659000@mvista.com>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Index: linux-2.6/arch/arm/Kconfig
===================================================================
--- linux-2.6.orig/arch/arm/Kconfig
+++ linux-2.6/arch/arm/Kconfig
@@ -25,6 +25,10 @@ config GENERIC_CLOCKEVENTS
 	bool
 	default n
 
+config GENERIC_CLOCKEVENTS
+	bool
+	default n
+
 config MMU
 	bool
 	default y

--

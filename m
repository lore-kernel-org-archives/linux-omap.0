From: Kevin Hilman <khilman@mvista.com>
Subject: [RFC, PATCH 1/7] ARM: build fixups for hrtimers
Date: Mon, 19 Feb 2007 13:47:20 -0800
Message-ID: <20070219214739.523455000@mvista.com>
References: <20070219214719.379287000@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline; filename=arm-build-fixups.patch
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

Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -21,6 +21,8 @@
 #include <linux/sched.h>
 #include <linux/tick.h>
 
+#include <asm/irq_regs.h>
+
 #include "tick-internal.h"
 
 /*

--

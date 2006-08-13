From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Remove warnings in DSP code
Date: Sun, 13 Aug 2006 16:04:18 +0200
Message-ID: <44DF3162.2090700@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090904040704080704070008"
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

This is a multi-part message in MIME format.
--------------090904040704080704070008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Remove warnings:

arch/arm/plat-omap/dsp/dsp_common.c: In function
'dsp_cpustat_update':
arch/arm/plat-omap/dsp/dsp_common.c:317: warning: implicit
declaration of function 'enable_irq'
arch/arm/plat-omap/dsp/dsp_common.c:325: warning: implicit
declaration of function 'disable_irq'

arch/arm/plat-omap/dsp/task.c: In function 'dsp_task_write_bk':
arch/arm/plat-omap/dsp/task.c:1232: warning: implicit
declaration of function 'disable_irq'
arch/arm/plat-omap/dsp/task.c:1232: warning: implicit
declaration of function 'enable_irq'

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------090904040704080704070008
Content-Type: text/plain;
 name="dsp_warnings_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dsp_warnings_patch.txt"

--- ./arch/arm/plat-omap/dsp/dsp_common.c_orig	2006-08-13 15:55:45.000000000 +0200
+++ ./arch/arm/plat-omap/dsp/dsp_common.c	2006-08-13 15:58:51.000000000 +0200
@@ -32,6 +32,7 @@
 #include <linux/mm.h>
 #include <linux/clk.h>
 #include <linux/mutex.h>
+#include <linux/interrupt.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
 #include <asm/irq.h>
--- ./arch/arm/plat-omap/dsp/task.c_orig	2006-08-13 15:55:30.000000000 +0200
+++ ./arch/arm/plat-omap/dsp/task.c	2006-08-13 15:59:03.000000000 +0200
@@ -37,6 +37,7 @@
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/mutex.h>
+#include <linux/interrupt.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/signal.h>


--------------090904040704080704070008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090904040704080704070008--

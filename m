From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix missing workqueue include in board-h2.c
Date: Thu, 04 Jan 2007 16:30:09 +0100
Message-ID: <459D1D81.4020308@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060305030402000809080604"
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
--------------060305030402000809080604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix missing #include <linux/workqueue.h> in
board-h2.c resulting in

In file included from arch/arm/mach-omap1/board-h2.c:40:
include/asm/arch/irda.h:27: error: field 'gpio_expa' has
incomplete type

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------060305030402000809080604
Content-Type: text/plain;
 name="board_h2_compilation_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="board_h2_compilation_fix.txt"

Index: linux-osk/arch/arm/mach-omap1/board-h2.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-h2.c
+++ linux-osk/arch/arm/mach-omap1/board-h2.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/input.h>
+#include <linux/workqueue.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>


--------------060305030402000809080604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060305030402000809080604--

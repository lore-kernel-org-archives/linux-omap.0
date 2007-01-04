From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Add missing includes to board-nokia770
Date: Thu, 04 Jan 2007 17:14:15 +0100
Message-ID: <459D27D7.8060508@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070807050303080407000009"
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
--------------070807050303080407000009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Add missing includes to board-nokia770 to make it
compile again.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------070807050303080407000009
Content-Type: text/plain;
 name="board_n770_workqueue_changes.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="board_n770_workqueue_changes.txt"

Index: linux-osk/arch/arm/mach-omap1/board-nokia770.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/board-nokia770.c
+++ linux-osk/arch/arm/mach-omap1/board-nokia770.c
@@ -16,6 +16,8 @@
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/workqueue.h>
+#include <linux/delay.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>


--------------070807050303080407000009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070807050303080407000009--

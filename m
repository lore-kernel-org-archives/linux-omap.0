From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Add missing include to dsp/mblog.c
Date: Thu, 04 Jan 2007 17:16:26 +0100
Message-ID: <459D285A.7080009@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070407050305020800000209"
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
--------------070407050305020800000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Add missing include to dsp/mblog.c to make it
compile again.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------070407050305020800000209
Content-Type: text/plain;
 name="dsp_mblog_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dsp_mblog_fix.txt"

Index: linux-osk/arch/arm/plat-omap/dsp/mblog.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/mblog.c
+++ linux-osk/arch/arm/plat-omap/dsp/mblog.c
@@ -23,6 +23,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <asm/arch/mailbox.h>
 #include "dsp_mbcmd.h"
 #include "dsp.h"


--------------070407050305020800000209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070407050305020800000209--

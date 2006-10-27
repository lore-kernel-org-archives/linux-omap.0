From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in mach-omap2
Date: Fri, 27 Oct 2006 18:24:57 +0200
Message-ID: <454232D9.80106@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080101060901070809070601"
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
--------------080101060901070809070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warning

arch/arm/mach-omap2/timer-gp.c: In function
'omap2_gp_timer_init':
arch/arm/mach-omap2/timer-gp.c:70: warning: implicit
declaration of function 'setup_irq'

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>



--------------080101060901070809070601
Content-Type: text/plain;
 name="mach_omap2_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mach_omap2_warning_patch.txt"

Index: linux-osk/arch/arm/mach-omap2/timer-gp.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/timer-gp.c
+++ linux-osk/arch/arm/mach-omap2/timer-gp.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
 
 #include <asm/mach/time.h>
 #include <asm/arch/dmtimer.h>


--------------080101060901070809070601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080101060901070809070601--

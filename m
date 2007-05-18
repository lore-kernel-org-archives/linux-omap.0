From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in dsp_ctl_core.c
Date: Fri, 18 May 2007 09:13:20 +0200
Message-ID: <464D5210.6040001@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040208000806070105020702"
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
--------------040208000806070105020702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warning

arch/arm/plat-omap/dsp/dsp_ctl_core.c: In function 'dsp_ctl_core_open':
arch/arm/plat-omap/dsp/dsp_ctl_core.c:46: warning: ignoring return
value of 'mutex_lock_interruptible', declared with attribute
warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

--------------040208000806070105020702
Content-Type: text/plain;
 name="dsp_ctl_core_warning_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dsp_ctl_core_warning_fix.txt"

Index: linux-osk/arch/arm/plat-omap/dsp/dsp_ctl_core.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/dsp_ctl_core.c
+++ linux-osk/arch/arm/plat-omap/dsp/dsp_ctl_core.c
@@ -43,7 +43,8 @@ static int dsp_ctl_core_open(struct inod
 	static DEFINE_MUTEX(open_lock);
 	int ret = 0;
 
-	mutex_lock_interruptible(&open_lock);
+	if (mutex_lock_interruptible(&open_lock))
+		return -EINTR;
 	if (omap_dsp->initialized == 0) {
 		ret = dsp_late_init();
 		if (ret != 0) {


--------------040208000806070105020702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040208000806070105020702--

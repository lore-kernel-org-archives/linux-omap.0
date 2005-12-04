From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH] Fix warning in pm.c
Date: Sun, 04 Dec 2005 16:52:49 +0100
Message-ID: <439310D1.1050106@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020102030205070907060905"
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
--------------020102030205070907060905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Remove warning

arch/arm/mach-omap1/pm.c: In function `omap_pm_idle':
arch/arm/mach-omap1/pm.c:114: warning: unused variable `do_sleep'

if CONFIG_OMAP_MPU_TIMER is defined.

Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>


--------------020102030205070907060905
Content-Type: text/plain;
 name="pm_warning_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm_warning_fix.patch"

--- ./arch/arm/mach-omap1/pm.c_orig	2005-12-02 17:28:17.000000000 +0100
+++ ./arch/arm/mach-omap1/pm.c	2005-12-02 17:30:34.000000000 +0100
@@ -111,7 +111,9 @@ void omap_pm_idle(void)
 {
 	extern __u32 arm_idlect1_mask;
 	__u32 use_idlect1 = arm_idlect1_mask;
+#ifndef CONFIG_OMAP_MPU_TIMER
 	int do_sleep;
+#endif
 
 	local_irq_disable();
 	local_fiq_disable();


--------------020102030205070907060905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020102030205070907060905--

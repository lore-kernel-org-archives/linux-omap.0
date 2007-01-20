From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP2: Fix warning in pm.c
Date: Sat, 20 Jan 2007 08:04:59 +0100
Message-ID: <45B1BF1B.8080800@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070106030004050402080907"
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
--------------070106030004050402080907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP2: Fix warning in pm.c:

arch/arm/mach-omap2/pm.c: In function 'omap2_pm_init':
arch/arm/mach-omap2/pm.c:854: warning: ignoring return value
of 'subsys_create_file', declared with attribute
warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------070106030004050402080907
Content-Type: text/plain;
 name="omap2_pm_warning_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap2_pm_warning_fix"

Index: linux-osk/arch/arm/mach-omap2/pm.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/pm.c
+++ linux-osk/arch/arm/mach-omap2/pm.c
@@ -851,7 +851,9 @@ int __init omap2_pm_init(void)
 	pm_set_ops(&omap_pm_ops);
 	pm_idle = omap2_pm_idle;
 
-	subsys_create_file(&power_subsys, &sleep_while_idle_attr);
+	l = subsys_create_file(&power_subsys, &sleep_while_idle_attr);
+	if (l)
+		printk(KERN_ERR "subsys_create_file failed: %d\n", l);
 
 	return 0;
 }


--------------070106030004050402080907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070106030004050402080907--

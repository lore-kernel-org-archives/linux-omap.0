From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in mach-omap1
Date: Sat, 04 Nov 2006 16:49:15 +0100
Message-ID: <454CB67B.70706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090707060600010702020700"
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
--------------090707060600010702020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix warning

arch/arm/mach-omap1/pm.c: In function 'omap_pm_init':
arch/arm/mach-omap1/pm.c:765: warning: ignoring return value
of 'subsys_create_file', declared with attribute
warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------090707060600010702020700
Content-Type: text/plain;
 name="mach_omap1_warn_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mach_omap1_warn_patch.txt"

Index: linux-osk/arch/arm/mach-omap1/pm.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/pm.c
+++ linux-osk/arch/arm/mach-omap1/pm.c
@@ -706,6 +706,8 @@ static struct pm_ops omap_pm_ops ={
 
 static int __init omap_pm_init(void)
 {
+	int error;
+
 	printk("Power Management for TI OMAP.\n");
 
 	/*
@@ -762,7 +764,9 @@ static int __init omap_pm_init(void)
 	omap_pm_init_proc();
 #endif
 
-	subsys_create_file(&power_subsys, &sleep_while_idle_attr);
+	error = subsys_create_file(&power_subsys, &sleep_while_idle_attr);
+	if(error)
+		printk(KERN_ERR "subsys_create_file failed: %d\n", error);
 
 	if (cpu_is_omap16xx()) {
 		/* configure LOW_PWR pin */


--------------090707060600010702020700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090707060600010702020700--

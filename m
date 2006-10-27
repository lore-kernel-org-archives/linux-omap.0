From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in mach-omap1
Date: Fri, 27 Oct 2006 18:19:12 +0200
Message-ID: <45423180.30502@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080608080606080801080808"
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
--------------080608080606080801080808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix warning

arch/arm/mach-omap1/pm.c: In function 'omap_pm_init':
arch/arm/mach-omap1/pm.c:765: warning: ignoring return value
of 'subsys_create_file', declared with attribute
warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------080608080606080801080808
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
+	int error = 0;
+
 	printk("Power Management for TI OMAP.\n");
 
 	/*
@@ -762,13 +764,15 @@ static int __init omap_pm_init(void)
 	omap_pm_init_proc();
 #endif
 
-	subsys_create_file(&power_subsys, &sleep_while_idle_attr);
+	error = subsys_create_file(&power_subsys, &sleep_while_idle_attr);
+	if(unlikely(error != 0))
+		printk(KERN_ERR "subsys_create_file failed: %d\n", error);
 
 	if (cpu_is_omap16xx()) {
 		/* configure LOW_PWR pin */
 		omap_cfg_reg(T20_1610_LOW_PWR);
 	}
 
-	return 0;
+	return error;
 }
 __initcall(omap_pm_init);


--------------080608080606080801080808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080608080606080801080808--

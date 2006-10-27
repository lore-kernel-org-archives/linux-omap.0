From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warnings in plat-omap
Date: Fri, 27 Oct 2006 18:09:47 +0200
Message-ID: <45422F4B.6090906@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080501060900010408010908"
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
--------------080501060900010408010908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Fix warnings

arch/arm/plat-omap/dmtimer.c: In function
'omap_dm_timer_modify_idlect_mask':
arch/arm/plat-omap/dmtimer.c:317: warning: no return
statement in function returning non-void

arch/arm/plat-omap/mailbox.c: In function 'omap_mbox_init':
arch/arm/plat-omap/mailbox.c:231: warning: ignoring return
value of 'class_device_create_file', declared with attribute
warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------080501060900010408010908
Content-Type: text/plain;
 name="plat_omap_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="plat_omap_warning_patch.txt"

Index: linux-osk/arch/arm/plat-omap/mailbox.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/mailbox.c
+++ linux-osk/arch/arm/plat-omap/mailbox.c
@@ -228,7 +228,12 @@ static int omap_mbox_init(struct omap_mb
 	if (unlikely(ret))
 		return ret;
 
-	class_device_create_file(&mbox->class_dev, &class_device_attr_mbox);
+	ret = class_device_create_file(&mbox->class_dev, &class_device_attr_mbox);
+	if (unlikely(ret)) {
+		printk(KERN_ERR
+		       "class_device_create_file failed: %d\n", ret);
+		goto fail1;
+	}
 
 	ret = request_irq(mbox->irq, mbox_interrupt, SA_INTERRUPT,
 			  mbox->name, mbox);
Index: linux-osk/arch/arm/plat-omap/dmtimer.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dmtimer.c
+++ linux-osk/arch/arm/plat-omap/dmtimer.c
@@ -314,6 +314,8 @@ struct clk *omap_dm_timer_get_fclk(struc
 __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 {
 	BUG();
+
+	return 0;
 }
 
 #endif



--------------080501060900010408010908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080501060900010408010908--

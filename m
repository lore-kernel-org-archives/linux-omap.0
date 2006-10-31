From: Felipe Balbi <ext-felipe.lima@nokia.com>
Subject: [PATCH] [USB/CORE/USB.C] Fixes autosuspend and auto_pm fields
	missing
Date: Tue, 31 Oct 2006 16:00:28 -0400
Message-ID: <4547AB5C.4010801@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050402070908000605010009"
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
To: Linux OMAP Mailing List <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------050402070908000605010009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This small patch changes omap_h3_1710_defconfig to fix the bug.

The catch is: for struct usb_device to have the fields struct 
work_struct autosuspend and unsigned autopm:1 CONFIG_PM should be set "y".


make uImage
  CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  CC      drivers/usb/core/usb.o
drivers/usb/core/usb.c: In function 'usb_release_dev':
drivers/usb/core/usb.c:177: error: 'struct usb_device' has no member 
named 'autosuspend'
drivers/usb/core/usb.c: In function 'usb_autosuspend_work':
drivers/usb/core/usb.c:218: error: 'struct usb_device' has no member 
named 'auto_pm'
drivers/usb/core/usb.c:219: warning: statement with no effect
make[3]: *** [drivers/usb/core/usb.o] Error 1
make[2]: *** [drivers/usb/core] Error 2
make[1]: *** [drivers/usb] Error 2
make: *** [drivers] Error 2


-- 
Best Regards,

Felipe Balbi
ext-felipe.lima@nokia.com
OSMRC - INdT


--------------050402070908000605010009
Content-Type: text/x-patch;
 name="patch-autosuspend-auto_pm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-autosuspend-auto_pm.diff"

Index: linux-omap-2.6-dev/include/linux/usb.h
===================================================================
--- linux-omap-2.6-dev.orig/include/linux/usb.h	2006-10-31 14:16:01.000000000 -0400
+++ linux-omap-2.6-dev/include/linux/usb.h	2006-10-31 15:48:43.000000000 -0400
@@ -381,13 +381,13 @@ struct usb_device {
 	struct usb_device *children[USB_MAXCHILDREN];
 
 	int pm_usage_cnt;		/* usage counter for autosuspend */
-#ifdef CONFIG_PM
+/* #ifdef CONFIG_PM */
 	struct work_struct autosuspend;	/* for delayed autosuspends */
 	struct mutex pm_mutex;		/* protects PM operations */
 
 	unsigned auto_pm:1;		/* autosuspend/resume in progress */
 	unsigned do_remote_wakeup:1;	/* remote wakeup should be enabled */
-#endif
+/* #endif */
 };
 #define	to_usb_device(d) container_of(d, struct usb_device, dev)
 

--------------050402070908000605010009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050402070908000605010009--

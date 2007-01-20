From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warnings in musb_procfs.c
Date: Sat, 20 Jan 2007 08:10:10 +0100
Message-ID: <45B1C052.4020809@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030409080504020808000206"
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
--------------030409080504020808000206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix warnings in musb_procfs.c:

drivers/usb/musb/musb_procfs.c: In function 'musb_proc_write':
drivers/usb/musb/musb_procfs.c:651: warning: ignoring return
value of 'copy_from_user', declared with attribute
warn_unused_result
drivers/usb/musb/musb_procfs.c:725: warning: ignoring return
value of 'copy_from_user', declared with attribute
warn_unused_result

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------030409080504020808000206
Content-Type: text/plain;
 name="musb_procfs_warning_fix"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="musb_procfs_warning_fix"

Index: linux-osk/drivers/usb/musb/musb_procfs.c
===================================================================
--- linux-osk.orig/drivers/usb/musb/musb_procfs.c
+++ linux-osk/drivers/usb/musb/musb_procfs.c
@@ -648,7 +648,8 @@ static int musb_proc_write(struct file *
 
 	/* MOD_INC_USE_COUNT; */
 
-	copy_from_user(&cmd, buffer, 1);
+	if(unlikely(copy_from_user(&cmd, buffer, 1)))
+		return -EFAULT;
 	switch (cmd) {
 	case 'C':
 		if (pBase) {
@@ -722,7 +723,10 @@ static int musb_proc_write(struct file *
 				int i = 0, level = 0, sign = 1;
 				int len = min(count - 1, (unsigned long)8);
 
-				copy_from_user(&digits, &buffer[1], len);
+				if(unlikely(copy_from_user(&digits,
+							   &buffer[1],
+							   len)))
+					return -EFAULT;
 
 				/* optional sign */
 				if (*p == '-') {


--------------030409080504020808000206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030409080504020808000206--

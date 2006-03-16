From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] Fix warnings in innovator_ps2
Date: Thu, 16 Mar 2006 17:02:15 +0100
Message-ID: <44198C07.3050907@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010807060506060202020901"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------010807060506060202020901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix warnings in innovator_ps2:

drivers/input/keyboard/innovator_ps2.c:333: warning: 'block'
defined but not used
drivers/input/keyboard/innovator_ps2.c:338: warning:
'innovator_fpga_hid_lock' defined but not used
drivers/input/keyboard/innovator_ps2.c:339: warning:
'innovator_fpga_hid_busy' defined but not used
drivers/input/keyboard/innovator_ps2.c:383: warning:
'innovator_fpga_hid_clear_bits' defined but not used
drivers/input/keyboard/innovator_ps2.c:702: warning:
'verify_init' defined but not used
drivers/input/keyboard/innovator_ps2.c: In function
'innovator_ps2_resume':
drivers/input/keyboard/innovator_ps2.c:1176: warning:
'pmcomm' may be used uninitialized in this function
drivers/input/keyboard/innovator_ps2.c: In function
'innovator_ps2_suspend':
drivers/input/keyboard/innovator_ps2.c:1153: warning:
'pmcomm' may be used uninitialized in this function

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------010807060506060202020901
Content-Type: text/plain;
 name="innovator_ps_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="innovator_ps_patch.txt"

--- ./drivers/input/keyboard/innovator_ps2.c_orig	2006-03-16 16:51:45.000000000 +0100
+++ ./drivers/input/keyboard/innovator_ps2.c	2006-03-16 16:58:24.000000000 +0100
@@ -330,13 +330,10 @@ typedef struct _kdb_report_t {
 
 
 static u8 buffer[JUNO_BUFFER_SIZE];
-static u8 block[JUNO_BLOCK_SIZE];
 
 static void do_hid_tasklet(unsigned long);
 DECLARE_TASKLET(hid_tasklet, do_hid_tasklet, 0);
 static struct innovator_hid_dev *hid;
-static spinlock_t innovator_fpga_hid_lock = SPIN_LOCK_UNLOCKED;
-static atomic_t innovator_fpga_hid_busy = ATOMIC_INIT(0);
 
 struct innovator_hid_dev {
 	struct input_dev mouse, keyboard;
@@ -379,12 +376,6 @@ innovator_fpga_hid_set_bits(u8 x)
 }
 
 static void
-innovator_fpga_hid_clear_bits(u8 x)
-{
-	innovator_fpga_hid_frob(x, 0);
-}
-
-static void
 SS(int value)
 {
 	innovator_fpga_hid_frob(OMAP1510_FPGA_HID_nSS, value ? OMAP1510_FPGA_HID_nSS : 0);
@@ -697,13 +688,6 @@ report_async(void * p, int n)
 	return ret;
 }
 
-static int
-verify_init(u8 * p)
-{
-	return (((simple_t *)p)->cmd_code == 0x01) ? 0 : -1;
-}
-
-
 /*
  * Host command helper functions:
  */
@@ -1150,7 +1134,7 @@ static void innovator_ps2_device_release
 
 static int innovator_ps2_suspend(struct device *dev, pm_message_t state)
 {
-	u8 pmcomm;
+	u8 pmcomm = 0;
 
 	/*
 	 * Set SUS_STATE in REG_PM_COMM (Page 0 R0).  This will cause
@@ -1173,7 +1157,7 @@ static int innovator_ps2_suspend(struct 
 
 static int innovator_ps2_resume(struct device *dev)
 {
-	u8 pmcomm;
+	u8 pmcomm = 0;
 
 	/*
 	 * Clear SUS_STATE from REG_PM_COMM (Page 0 R0).



--------------010807060506060202020901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010807060506060202020901--

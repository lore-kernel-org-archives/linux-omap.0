From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix warning in omap-keypad
Date: Fri, 27 Oct 2006 18:29:21 +0200
Message-ID: <454233E1.7060909@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020407000700090903060703"
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
--------------020407000700090903060703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix warning

rivers/input/keyboard/omap-keypad.c: In function
'omap_kp_probe':
drivers/input/keyboard/omap-keypad.c:450: warning: 'row_idx'
is used uninitialized in this function
drivers/input/keyboard/omap-keypad.c:453: warning: 'col_idx'
is used uninitialized in this function

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------020407000700090903060703
Content-Type: text/plain;
 name="omap_keypad_warning_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_keypad_warning_patch.txt"

Index: linux-osk/drivers/input/keyboard/omap-keypad.c
===================================================================
--- linux-osk.orig/drivers/input/keyboard/omap-keypad.c
+++ linux-osk/drivers/input/keyboard/omap-keypad.c
@@ -317,7 +317,7 @@ static int __init omap_kp_probe(struct p
 	struct omap_kp *omap_kp;
 	struct input_dev *input_dev;
 	struct omap_kp_platform_data *pdata =  pdev->dev.platform_data;
-	int i, col_idx, row_idx, irq_idx, ret;
+	int i, col_idx = 0, row_idx = 0, irq_idx, ret;
 
 	if (!pdata->rows || !pdata->cols || !pdata->keymap) {
 		printk(KERN_ERR "No rows, cols or keymap from pdata\n");


--------------020407000700090903060703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020407000700090903060703--

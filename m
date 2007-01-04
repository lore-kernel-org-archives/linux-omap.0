From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Workqueue changes for board-h4.c
Date: Thu, 04 Jan 2007 16:54:16 +0100
Message-ID: <459D2328.7020000@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060405020902020400090203"
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
--------------060405020902020400090203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Workqueue changes for board-h4.c

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------060405020902020400090203
Content-Type: text/plain;
 name="board_h4_workqueue_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="board_h4_workqueue_fix.txt"

Index: linux-osk/arch/arm/mach-omap2/board-h4.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/board-h4.c
+++ linux-osk/arch/arm/mach-omap2/board-h4.c
@@ -164,9 +164,11 @@ static int h4_select_irda(struct device 
 	return err;
 }
 
-static void set_trans_mode(void *data)
+static void set_trans_mode(struct work_struct *work)
 {
-	int *mode = data;
+	struct omap_irda_config *irda_config =
+		container_of(work, struct omap_irda_config, gpio_expa.work);
+	int mode = irda_config->mode;
 	unsigned char expa;
 	int err = 0;
 
@@ -176,7 +178,7 @@ static void set_trans_mode(void *data)
 
 	expa &= ~0x01;
 
-	if (!(*mode & IR_SIRMODE)) { /* MIR/FIR */
+	if (!(mode & IR_SIRMODE)) { /* MIR/FIR */
 		expa |= 0x01;
 	}
 
@@ -189,9 +191,9 @@ static int h4_transceiver_mode(struct de
 {
 	struct omap_irda_config *irda_config = dev->platform_data;
 
+	irda_config->mode = mode;
 	cancel_delayed_work(&irda_config->gpio_expa);
-	PREPARE_WORK(&irda_config->gpio_expa, set_trans_mode, &mode);
-#error this is not permitted - mode is an argument variable
+	PREPARE_DELAYED_WORK(&irda_config->gpio_expa, set_trans_mode);
 	schedule_delayed_work(&irda_config->gpio_expa, 0);
 
 	return 0;


--------------060405020902020400090203
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060405020902020400090203--

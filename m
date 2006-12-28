From: "=?UTF-8?Q?Ragner_N_Magalh=C3=A3es?=" <ragner@users.sourceforge.net>
Subject: Fwd: [PATCH]: Workqueue changes for board-h3
Date: Thu, 28 Dec 2006 09:31:55 -0400
Message-ID: <25c21ceb0612280531u2c01acfase9a95e81e6d37cfe@mail.gmail.com>
References: <20061228132843.6403.qmail@web33710.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061228132843.6403.qmail@web33710.mail.mud.yahoo.com>
Content-Disposition: inline
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

---------- Forwarded message ----------
From: Felipe Balbi <felipe.lima@indt.org.br>
Date: Dec 28, 2006 9:28 AM
Subject: [PATCH]: Workqueue changes for board-h3
To: ragner.magalhaes@gmail.com

Hello all,


This patch fixes an error regarding workqueue changes on board-h3 file.]



=================== CUT HERE ==========================
Fixes a compile issue when using CONFIG_MACH_OMAP_H3 regarding workqueues.

Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
---

Index: linux-omap-2.6-dev/arch/arm/mach-omap1/board-h3.c
===================================================================
--- linux-omap-2.6-dev.orig/arch/arm/mach-omap1/board-h3.c
+++ linux-omap-2.6-dev/arch/arm/mach-omap1/board-h3.c
@@ -298,5 +298,5 @@ static int h3_select_irda(struct device

-static void set_trans_mode(void *data)
+static void set_trans_mode(struct work_struct *data)
 {
-	int *mode = data;
+	int *mode = (int *)data;
 	unsigned char expa;
@@ -321,3 +321,3 @@ static void set_trans_mode(void *data)

-static int h3_transceiver_mode(struct device *dev, int
 mode)
+static int h3_transceiver_mode(struct device *dev)
 {
@@ -326,4 +326,3 @@ static int h3_transceiver_mode(struct de
 	cancel_delayed_work(&irda_config->gpio_expa);
-	PREPARE_WORK(&irda_config->gpio_expa, set_trans_mode, &mode);
-#error this is not permitted - mode is an argument variable
+	PREPARE_WORK(&(irda_config->gpio_expa.work), set_trans_mode);
 	schedule_delayed_work(&irda_config->gpio_expa, 0);
Index: linux-omap-2.6-dev/include/asm-arm/arch-omap/irda.h
===================================================================
--- linux-omap-2.6-dev.orig/include/asm-arm/arch-omap/irda.h
+++ linux-omap-2.6-dev/include/asm-arm/arch-omap/irda.h
@@ -21,3 +21,3 @@ struct omap_irda_config {
 	int transceiver_cap;
-	int (*transceiver_mode)(struct device *dev, int mode);
+	int (*transceiver_mode)(struct device *dev);
 	int (*select_irda)(struct device *dev, int state);


Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 8127 0839

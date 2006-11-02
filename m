From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [PATCH] Fix some pt_regs users
Date: Thu, 02 Nov 2006 20:51:28 +0100
Message-ID: <85odrpiq4f.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
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

--=-=-=

Hi,

There are still some users of pt_regs in the -omap tree. This patch is
fixing only the one I've spotted, so it's possible that there are some
left.


Regards,
Arnaud Patard


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=irq_fixups.patch

There are still some users of pt_regs in the -omap tree. This patch fixes them.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

---
 drivers/bluetooth/brf6150.c |    5 	2 +	3 -	0 !
 drivers/cbus/retu.c         |    2 	1 +	1 -	0 !
 drivers/cbus/tahvo.c        |    2 	1 +	1 -	0 !
 3 files changed, 4 insertions(+), 5 deletions(-)

Index: linux-omap-2.6/drivers/bluetooth/brf6150.c
===================================================================
--- linux-omap-2.6.orig/drivers/bluetooth/brf6150.c	2006-11-02 20:26:51.000000000 +0100
+++ linux-omap-2.6/drivers/bluetooth/brf6150.c	2006-11-02 20:26:58.000000000 +0100
@@ -569,7 +569,7 @@ static void brf6150_tx_tasklet(unsigned 
 	spin_unlock_irqrestore(&info->lock, flags);
 }
 
-static irqreturn_t brf6150_interrupt(int irq, void *data, struct pt_regs *regs)
+static irqreturn_t brf6150_interrupt(int irq, void *data)
 {
 	struct brf6150_info *info = (struct brf6150_info *)data;
 	u8 iir, msr;
@@ -617,8 +617,7 @@ static irqreturn_t brf6150_interrupt(int
 	return ret;
 }
 
-static irqreturn_t brf6150_wakeup_interrupt(int irq, void *dev_inst,
-					    struct pt_regs *regs)
+static irqreturn_t brf6150_wakeup_interrupt(int irq, void *dev_inst)
 {
 	struct brf6150_info *info = dev_inst;
 	int should_wakeup;
Index: linux-omap-2.6/drivers/cbus/retu.c
===================================================================
--- linux-omap-2.6.orig/drivers/cbus/retu.c	2006-11-02 20:26:51.000000000 +0100
+++ linux-omap-2.6/drivers/cbus/retu.c	2006-11-02 20:26:58.000000000 +0100
@@ -187,7 +187,7 @@ void retu_ack_irq(int id)
 /*
  * RETU interrupt handler. Only schedules the tasklet.
  */
-static irqreturn_t retu_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t retu_irq_handler(int irq, void *dev_id)
 {
 	tasklet_schedule(&retu_tasklet);
 	return IRQ_HANDLED;
Index: linux-omap-2.6/drivers/cbus/tahvo.c
===================================================================
--- linux-omap-2.6.orig/drivers/cbus/tahvo.c	2006-11-02 20:26:51.000000000 +0100
+++ linux-omap-2.6/drivers/cbus/tahvo.c	2006-11-02 20:26:58.000000000 +0100
@@ -182,7 +182,7 @@ void tahvo_set_backlight_level(int level
 /*
  * TAHVO interrupt handler. Only schedules the tasklet.
  */
-static irqreturn_t tahvo_irq_handler(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t tahvo_irq_handler(int irq, void *dev_id)
 {
 	tasklet_schedule(&tahvo_tasklet);
 	return IRQ_HANDLED;

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-=-=--

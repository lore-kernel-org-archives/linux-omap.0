From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH] usb: musb: fix pm_runtime calls while atomic
Date: Fri, 12 Aug 2011 07:38:51 -0700
Message-ID: <1313159931-22121-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40693 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab1HLOi4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Aug 2011 10:38:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, balbi@ti.com
Cc: linux-omap@vger.kernel.org, axelhaslam@ti.com, ccross@google.com, Vikram Pandita <vikram.pandita@ti.com>, Moiz Sonasath <m-sonasath@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

musb pm_runtime_get_sync call happens in intrrupt context on cable attach case
That can result in re-enabling the interrupts and cause side affects.

So move the code to a work queue.

Following is the error path hit on cable attach:

BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:802
in_atomic(): 0, irqs_disabled(): 0, pid: 18, name: irq/378-twl6030

Backtrace:
[<c00520f0>] (dump_backtrace+0x0/0x110) from [<c054f454>] (dump_stack+0x18/0x1c)
[<c054f43c>] (dump_stack+0x0/0x1c) from [<c007f59c>] (__might_sleep+0x130/0x134)
[<c007f46c>] (__might_sleep+0x0/0x134) from [<c02c2794>] (__pm_runtime_resume+0x94/0x98)
[<c02c2700>] (__pm_runtime_resume+0x0/0x98) from [<c033e7e4>] (musb_otg_notifications+0x9c/0x164)
[<c033e748>] (musb_otg_notifications+0x0/0x164) from [<c00b3df0>] (notifier_call_chain+0x4c/0x8c)
[<c00b3da4>] (notifier_call_chain+0x0/0x8c) from [<c00b44a8>] (__atomic_notifier_call_chain+0x40/0x54)
[<c00b4468>] (__atomic_notifier_call_chain+0x0/0x54) from [<c00b44dc>] (atomic_notifier_call_chain+0x20/0x28)
[<c00b44bc>] (atomic_notifier_call_chain+0x0/0x28) from [<c033f124>] (twl6030_usb_irq+0xc8/0xdc)
[<c033f05c>] (twl6030_usb_irq+0x0/0xdc) from [<c00d79f8>] (irq_thread_fn+0x24/0x40)
[<c00d79d4>] (irq_thread_fn+0x0/0x40) from [<c00d7b64>] (irq_thread+0x150/0x1d8)
[<c00d7a14>] (irq_thread+0x0/0x1d8) from [<c00adf70>] (kthread+0x94/0x98)
[<c00adedc>] (kthread+0x0/0x98) from [<c0094388>] (do_exit+0x0/0x720)

Tested with:
MUSB Device mode: Cold boot / Hot plug
MUSB Host mode: Cold boot / Hot plug

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 drivers/usb/musb/musb_core.h |    2 ++
 drivers/usb/musb/omap2430.c  |   14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 0e053b5..ff47316 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -386,6 +386,7 @@ struct musb {
 
 	irqreturn_t		(*isr)(int, void *);
 	struct work_struct	irq_work;
+	struct work_struct	otg_notifier_work;
 	u16			hwvers;
 
 /* this hub status bit is reserved by USB 2.0 and not seen by usbcore */
@@ -432,6 +433,7 @@ struct musb {
 	u16			int_tx;
 
 	struct otg_transceiver	*xceiv;
+	u8			xceiv_event;
 
 	int nIrq;
 	unsigned		irq_wake:1;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index c5d4c44..3026673 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -234,11 +234,21 @@ static int musb_otg_notifications(struct notifier_block *nb,
 		unsigned long event, void *unused)
 {
 	struct musb	*musb = container_of(nb, struct musb, nb);
+
+	musb->xceiv_event = event;
+	schedule_work(&musb->otg_notifier_work);
+
+	return 0;
+}
+
+static void musb_otg_notifier_work(struct work_struct *data_notifier_work)
+{
+	struct musb *musb = container_of(data_notifier_work, struct musb, otg_notifier_work);
 	struct device *dev = musb->controller;
 	struct musb_hdrc_platform_data *pdata = dev->platform_data;
 	struct omap_musb_board_data *data = pdata->board_data;
 
-	switch (event) {
+	switch (musb->xceiv_event) {
 	case USB_EVENT_ID:
 		dev_dbg(musb->controller, "ID GND\n");
 
@@ -310,6 +320,8 @@ static int omap2430_musb_init(struct musb *musb)
 		return -ENODEV;
 	}
 
+	INIT_WORK(&musb->otg_notifier_work, musb_otg_notifier_work);
+
 	status = pm_runtime_get_sync(dev);
 	if (status < 0) {
 		dev_err(dev, "pm_runtime_get_sync FAILED");
-- 
1.7.4.1


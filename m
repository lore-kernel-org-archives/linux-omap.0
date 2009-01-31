From: Kim Kyuwon <chammoru@gmail.com>
Subject: [PATCH] ARM: OMAP: Disable USB interrupt in the musb_resume()
	function
Date: Sat, 31 Jan 2009 17:21:56 +0900
Message-ID: <4d34a0a70901310021l6f42b34es24ca320e44c51ae6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:44846 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZAaIV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2009 03:21:57 -0500
Received: by wf-out-1314.google.com with SMTP id 27so894001wfd.4
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2009 00:21:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, =?EUC-KR?B?seix1L/4?= <q1.kim@samsung.com>

USB should be suspended with interrupt disabled[1]. If USB is suspended with
interrupt enabled and connected to host PC, a kernel panic would occur When
it wakes up. Because, after the arch_suspend_enable_irqs() function is called
in the suspend_enter() function, USB Interrupt handler is called, even though
USB controller is still not resumed! All devices are resumed after the
device_resume() is called.

[1] /Documentation/power/devices.txt: 412 line

Signed-off-by: Kim Kyuwon <chammoru@gmail.com>
---
 drivers/usb/musb/musb_core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 2cc34fa..0dfe15e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2151,6 +2151,8 @@ static int musb_suspend(struct platform_device
*pdev, pm_message_t message)

 	spin_lock_irqsave(&musb->lock, flags);

+	disable_irq(musb->nIrq);
+
 	if (is_peripheral_active(musb)) {
 		/* FIXME force disconnect unless we know USB will wake
 		 * the system up quickly enough to respond ...
@@ -2184,6 +2186,8 @@ static int musb_resume(struct platform_device *pdev)
 	else
 		clk_enable(musb->clock);

+	enable_irq(musb->nIrq);
+
 	/* for static cmos like DaVinci, register values were preserved
 	 * unless for some reason the whole soc powered down and we're
 	 * not treating that as a whole-system restart (e.g. swsusp)
-- 
Kim Kyuwon

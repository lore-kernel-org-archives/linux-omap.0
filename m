From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Suspend/Resume support with Omap2fb
Date: Thu, 12 Mar 2009 23:56:11 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427C51EBA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56316 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955AbZCLS03 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:26:29 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Hi,

Finally I could able to find the root-cause, actually some of the previous observations miss-led me to dig into power management, suspend/resume path and clock structure. But after bit debugging and with the help of Sanjeev, we got the rid of it.

The issue is with DSS2 library, inside function "dpi_display_suspend". It calls dispc_enable_lcd_out(0), but doesn't wait till the frame-done interrupt. And due to this I was getting some abrupt behavior in suspend/resume path. 
Actually in the beginning I overlooked legacy frame-buffer driver, which handles this scenario perfectly.
 
For Display sub-system we have 2 interface clocks coming, L3_ICLK and L4_ICLK. Out of these, L4_ICLK goes to Display register access and L3_ICLK goes to DMA register. In our suspend call we are disabling clocks for L3_ICLK (we don't control L4_ICLK), and due to this L4_ICLK stays attached with GFX. You will only be able to find out this by looking to CM_CLKSTST_DSS.CLKACTIVITY_DSS, which is set 1 and indicates some interface clock is still active in DSS domain.

Below is the patch which will explain the change 


+#include <linux/completion.h>
+#include <linux/jiffies.h>

+static void dpi_display_isr(void *arg, unsigned int irqstatus)
+{
+       struct omap_display *display = (struct omap_display *)arg;
+
+       complete(&display->frame_done);
+}

static int dpi_display_suspend(struct omap_display *display)
 {
+       void *handle = NULL;
+
        if (display->state != OMAP_DSS_DISPLAY_ACTIVE)
                return -EINVAL;

        if (display->panel->suspend)
                display->panel->suspend(display);

+       /*
+        * Wait for frame done interrupt
+        */
+       handle = omap_dispc_register_isr(dpi_display_isr, display,
+                       DISPC_IRQ_FRAMEDONE);
+       if (!handle)
+               return -EINVAL;
+
+       init_completion(&display->frame_done);
+
        dispc_enable_lcd_out(0);
+       if (!wait_for_completion_timeout(&display->frame_done,
+                               msecs_to_jiffies(500))) {
+               printk("timeout waiting for FRAME DONE\n");
+       }

Still I need to test this thoroughly, I may hit some another issue (Already I am seeing some crashes also when off state is enabled). I will create consolidated patch for this and will submit to list.

Thanks,
Vaibhav Hiremath

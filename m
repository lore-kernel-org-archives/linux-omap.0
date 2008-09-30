From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 19/23] twl4030-gpio: remove legacy irq triggering calls and user
Date: Tue, 30 Sep 2008 10:37:20 -0700
Message-ID: <200809301037.21294.david-b@pacbell.net>
References: <1222769160-31615-1-git-send-email-felipe.balbi@nokia.com> <1222769160-31615-19-git-send-email-felipe.balbi@nokia.com> <1222769160-31615-20-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:30850 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752936AbYI3RhX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Sep 2008 13:37:23 -0400
In-Reply-To: <1222769160-31615-20-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Here's an important bugfix ... strictly speaking the bug was
introduced in patch #18, but rather than redo both patches
I think it's simpler to just merge this one-liner here where
it could first have been noticed.

With this, I can confirm I've actually seen TWL triggering
GPIO interrupts ... on the appropriate edge.  At least,
when using GPIO-1, since I wasn't keen on trying to use
GPIO-0 to report removal of my SD-resident rootfs.  ;)


--- beagle.orig/drivers/gpio/twl4030-gpio.c	2008-09-30 10:28:25.000000000 -0700
+++ beagle/drivers/gpio/twl4030-gpio.c	2008-09-30 10:28:18.000000000 -0700
@@ -652,7 +652,8 @@ static int twl4030_gpio_unmask_thread(vo
 			type = desc->status & IRQ_TYPE_SENSE_MASK;
 			spin_unlock_irq(&desc->lock);
 
-			twl4030_set_gpio_edge_ctrl(irq, type);
+			twl4030_set_gpio_edge_ctrl(irq - twl4030_gpio_irq_base,
+					type);
 		}
 
 		local_irq_disable();

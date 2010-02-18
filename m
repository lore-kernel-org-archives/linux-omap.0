From: Peter Barada <peter.barada@gmail.com>
Subject: Problem specifying which gpio_126 to use on omap353x
Date: Thu, 18 Feb 2010 11:39:40 -0500
Message-ID: <738b3f7e1002180839x62a17dct381eed020642b91d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34757 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757475Ab0BRQjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Feb 2010 11:39:41 -0500
Received: by pwj8 with SMTP id 8so1581753pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Feb 2010 08:39:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On my board I have an isp1760 hooked up using gpio_126 (pin P27 -
MMC1_DAT4/SIM_IO/GPIO_126).  From the schematics (and TRM), there is a
2nd gpio_126 on pin D25 (CAM_STROBE/GPIO_126).

I tried to use:

#define ISP1760_IRQ 126

omap_mux_init_gpio(ISP1760_IRQ, OMAP_PIN_INPUT_PULLUP);
if (gpio_request(ISP1760_IRQ, "isp1760 IRQ") < 0) {
    printk(KERN_ERR "Failed to request GPIO%d for isp1760IRQ\n", ISP1760_IRQ);
    return;
}

And in the log I see:

mux: Multiple gpio paths for gpio126
mux: Multiple gpio paths for gpio126
Failed to request GPIO126 for isp1760 IRQ

How do I tell gpio_request()and friends that I want to use GPIO_126 on
pin P27, not GPIO_126 on pin D25?

Thanks in advance!

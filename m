From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFT/PATCH 0/8] cbus patches
Date: Thu, 16 Sep 2010 17:09:00 -0700
Message-ID: <20100917000900.GV29610@atomide.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58127 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0IQAJE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 20:09:04 -0400
Content-Disposition: inline
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>

* Felipe Balbi <balbi@ti.com> [100914 01:22]:
> Hi all,
> 
> if you have n8x0/n770 board getting dust, please
> spend some minutes to boot test the following
> patches on that. After you do so, please reply
> with your Tested-by tag.
> 
> I'm also adding to this series Jarkko Nikula's
> ioctl fix since l-o doesn't compile without that.

Seems to kick the watchdog on N800 at least after
the following fix. So I've pushed them all into the
cbus branch for more testing :)

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 16 Sep 2010 17:02:33 -0700
Subject: [PATCH] cbus: Fix retu init order

Device needs to be registered before the driver. Otherwise
the driver register will fail.

Eventually the device register will move to the board-*.c files.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 1397366..4a072da 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -531,11 +531,11 @@ static int __init retu_init(void)
 	/* Set up correct gpio number on struct resource */
 	retu_resource[0].start = gpio_to_irq(retu_irq_pin);
 
-	ret = platform_driver_probe(&retu_driver, retu_probe);
+	ret = platform_device_register(&retu_device);
 	if (ret < 0)
 		goto err1;
 
-	ret = platform_device_register(&retu_device);
+	ret = platform_driver_probe(&retu_driver, retu_probe);
 	if (ret < 0)
 		goto err2;
 

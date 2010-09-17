From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 0/8] cbus patches
Date: Fri, 17 Sep 2010 09:44:56 +0300
Message-ID: <20100917064456.GG23325@legolas.emea.dhcp.ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
 <20100917000900.GV29610@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab0IQGpQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 02:45:16 -0400
Content-Disposition: inline
In-Reply-To: <20100917000900.GV29610@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>

Hi,

On Thu, Sep 16, 2010 at 07:09:00PM -0500, Tony Lindgren wrote:
>diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
>index 1397366..4a072da 100644
>--- a/drivers/cbus/retu.c
>+++ b/drivers/cbus/retu.c
>@@ -531,11 +531,11 @@ static int __init retu_init(void)
> 	/* Set up correct gpio number on struct resource */
> 	retu_resource[0].start = gpio_to_irq(retu_irq_pin);
>
>-	ret = platform_driver_probe(&retu_driver, retu_probe);
>+	ret = platform_device_register(&retu_device);

ok, good catch :-)

Thanks a lot.

-- 
balbi

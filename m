From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/4] cbus: tahvo: move platform_device to board file
Date: Fri, 1 Oct 2010 15:37:37 +0300
Message-ID: <20101001123737.GT2925@legolas.emea.dhcp.ti.com>
References: <1285936419-28426-1-git-send-email-balbi@ti.com>
 <1285936419-28426-4-git-send-email-balbi@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60510 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756750Ab0JAMhh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 08:37:37 -0400
Content-Disposition: inline
In-Reply-To: <1285936419-28426-4-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Fri, Oct 01, 2010 at 07:33:38AM -0500, Balbi, Felipe wrote:
>@@ -255,9 +269,24 @@ static void __init n8x0_cbus_init(void)
> 		return;
> 	}
>
>-	set_irq_type(gpio_to_irq(108), IRQ_TYPE_EDGE_RISING);
>-	retu_resource[0].start = gpio_to_irq(108);
>-	platform_device_register(&retu_device);

hmmm, these three deleted lines look suspicious :-(

Let these cook for a while, I'll get back to them in a day or two. CBUS
is making me crazy :-p

-- 
balbi

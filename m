From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Thu, 19 Apr 2012 17:10:20 +0300
Message-ID: <4F901CCC.9000703@compulab.co.il>
References: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:52102
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755581Ab2DSOKd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 10:10:33 -0400
In-Reply-To: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

ping

Alan, Felipe,
Can this go into 3.5?

The dependency patch has already reached Samuel's tree,
what would be the best way to apply this one?
Should I ask Samuel to apply this one also (after having your acks)
via his tree, to reduce possible merge failures/conflicts?

On 03/27/12 16:08, Igor Grinberg wrote:
> When PHY reset pin is connected to a GPIO on external GPIO chip
> (e.g. I2C), we should not call the gpio_set_value() function, but
> gpio_set_value_cansleep().
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
> This patch depends on the patch from Keshava [1]:
> ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
> 
> [1] http://www.spinics.net/lists/linux-omap/msg66774.html
> 
>  drivers/usb/host/ehci-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 5c78f9e..26e9241 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -258,10 +258,10 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
>  		udelay(10);
>  
>  		if (gpio_is_valid(pdata->reset_gpio_port[0]))
> -			gpio_set_value(pdata->reset_gpio_port[0], 1);
> +			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
>  
>  		if (gpio_is_valid(pdata->reset_gpio_port[1]))
> -			gpio_set_value(pdata->reset_gpio_port[1], 1);
> +			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
>  	}
>  
>  	return 0;

-- 
Regards,
Igor.

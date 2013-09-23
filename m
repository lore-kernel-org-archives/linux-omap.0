From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Remove additional delay of 100ms when resuming
Date: Mon, 23 Sep 2013 15:26:44 +0900
Message-ID: <000001ceb825$dfae0eb0$9f0a2c10$%han@samsung.com>
References: <1379907508-22492-1-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1379907508-22492-1-git-send-email-gautam.vivek@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Vivek Gautam' <gautam.vivek@samsung.com>
Cc: linux-usb@vger.kernel.org, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Felipe Balbi' <balbi@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-omap@vger.kernel.org

On Monday, September 23, 2013 12:38 PM, Vivek Gautam wrote:
> 
> This delay got introduced in:
> "7415f17 usb: dwc3: core: add power management support"
> which reflected similar code in dwc3_core_soft_reset() function.
> However, originally the delay of 100ms in dwc3_core_soft_reset() was
> meant to assist USB2PHY and USB3PHY reset, not for usb_phy_init()
> sequence.
> 
> We should get rid of this delay, since things will still work
> fine without this.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

OK, I see.
There is no reason to add msleep(100) to dwc3_resume();
thus, this msleep(100) can be removed.

Best regards,
Jingoo Han

> ---
> 
> Hi Felipe,
> 
> I remember this change for phy_init including msleep(100) was
> suggested by me, after testing the patch-series for PM support
> to dwc3.
> Sorry for that !!
> 
>  drivers/usb/dwc3/core.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 474162e..e88ffae 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -691,7 +691,6 @@ static int dwc3_resume(struct device *dev)
> 
>  	usb_phy_init(dwc->usb3_phy);
>  	usb_phy_init(dwc->usb2_phy);
> -	msleep(100);
> 
>  	spin_lock_irqsave(&dwc->lock, flags);
> 
> --
> 1.7.6.5

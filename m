From: Vignesh R <vigneshr@ti.com>
Subject: Re: [linux-next][PATCH] usb: dwc3: core: Call dwc3_core_get_phy()
 before initializing phys
Date: Tue, 11 Jul 2017 17:30:53 -0500
Message-ID: <7771d976-657a-064e-2cd4-5a6309929ee4@ti.com>
References: <20170629052514.12560-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170629052514.12560-1-vigneshr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Carlos Hernandez <ceh@ti.com>
List-Id: linux-omap@vger.kernel.org



On 6/29/2017 12:25 AM, Vignesh R wrote:
> commit f54edb539c116 ("usb: dwc3: core: initialize ULPI before trying to
> get the PHY") moved call to dwc3_core_get_phy() from dwc3_probe() to
> dwc3_core_init() after dwc3_core_soft_reset(). But
> dwc3_core_soft_reset() calls phy_init(), therefore dwc3_core_get_phy()
> needs to be called before dwc3_core_soft_reset().
> 
> Fix this by moving call to dwc3_core_get_phy() before
> dwc3_core_soft_reset().
> 
> This fixes the following abort seen on DRA7xx platforms
> [   24.769118] usb usb2: SerialNumber: xhci-hcd.1.auto
> [   24.781144] hub 2-0:1.0: USB hub found
> [   24.787836] hub 2-0:1.0: 1 port detected
> [   24.809939] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> 
> Reported-by: Carlos Hernandez <ceh@ti.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---

Could this be picked up for -rc1, so that we have a booting kernel for
dra7 platform? Or is this planned for -rc2?

>  drivers/usb/dwc3/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 326b302fc440..03474d3575ab 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -766,15 +766,15 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  			dwc->maximum_speed = USB_SPEED_HIGH;
>  	}
>  
> -	ret = dwc3_core_soft_reset(dwc);
> +	ret = dwc3_core_get_phy(dwc);
>  	if (ret)
>  		goto err0;
>  
> -	ret = dwc3_phy_setup(dwc);
> +	ret = dwc3_core_soft_reset(dwc);
>  	if (ret)
>  		goto err0;
>  
> -	ret = dwc3_core_get_phy(dwc);
> +	ret = dwc3_phy_setup(dwc);
>  	if (ret)
>  		goto err0;
>  
> 

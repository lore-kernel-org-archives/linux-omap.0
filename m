From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RESEND PATCH 1/3] usb: dwc3: Don't reinitialize core during host
 bus-suspend/resume
Date: Wed, 10 Jan 2018 14:48:44 +0200
Message-ID: <6b0ceec7-7620-3d03-ad43-6dca7cbca3e8@ti.com>
References: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506511163-26026-1-git-send-email-mgautam@codeaurora.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Manu Gautam <mgautam@codeaurora.org>, Felipe Balbi <balbi@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Manu,

On 27/09/17 14:19, Manu Gautam wrote:
> Driver powers-off PHYs and reinitializes DWC3 core and gadget on
> resume. While this works fine for gadget mode but in host
> mode there is not re-initialization of host stack. Also, resetting
> bus as part of bus_suspend/resume is not correct which could affect
> (or disconnect) connected devices.
> Fix this by not reinitializing core on suspend/resume in host mode
> for HOST only and OTG/drd configurations.
> 

All this seems correct but we (TI) were relying on dwc3_core_exit() to be called
during dwc3_suspend() to have the lowest power state for our platforms.

After this patch, DWC3 controller and PHYs won't be turned off thus
preventing our platform from reaching low power levels.

So this is a regression for us (TI) in v4.15-rc.

Felipe, do you agree?

If yes I can send a patch which fixes the regression
and also makes USB host work after suspend/resume.


> Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
> ---
>  drivers/usb/dwc3/core.c | 43 ++++++++++++++++++++-----------------------
>  1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 03474d3..f75613f 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -927,6 +927,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  
>  	switch (dwc->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
> +		dwc->current_dr_role = DWC3_GCTL_PRTCAP_DEVICE;
>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  
>  		if (dwc->usb2_phy)
> @@ -942,6 +943,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>  		}
>  		break;
>  	case USB_DR_MODE_HOST:
> +		dwc->current_dr_role = DWC3_GCTL_PRTCAP_HOST;
>  		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>  
>  		if (dwc->usb2_phy)
> @@ -1293,21 +1295,19 @@ static int dwc3_suspend_common(struct dwc3 *dwc)
>  {
>  	unsigned long	flags;
>  
> -	switch (dwc->dr_mode) {
> -	case USB_DR_MODE_PERIPHERAL:
> -	case USB_DR_MODE_OTG:
> +	switch (dwc->current_dr_role) {
> +	case DWC3_GCTL_PRTCAP_DEVICE:
>  		spin_lock_irqsave(&dwc->lock, flags);
>  		dwc3_gadget_suspend(dwc);
>  		spin_unlock_irqrestore(&dwc->lock, flags);
> +		dwc3_core_exit(dwc);
>  		break;
> -	case USB_DR_MODE_HOST:
> +	case DWC3_GCTL_PRTCAP_HOST:
>  	default:
>  		/* do nothing */
>  		break;
>  	}
>  
> -	dwc3_core_exit(dwc);
> -
>  	return 0;
>  }
>  
> @@ -1316,18 +1316,17 @@ static int dwc3_resume_common(struct dwc3 *dwc)
>  	unsigned long	flags;
>  	int		ret;
>  
> -	ret = dwc3_core_init(dwc);
> -	if (ret)
> -		return ret;
> +	switch (dwc->current_dr_role) {
> +	case DWC3_GCTL_PRTCAP_DEVICE:
> +		ret = dwc3_core_init(dwc);
> +		if (ret)
> +			return ret;
>  
> -	switch (dwc->dr_mode) {
> -	case USB_DR_MODE_PERIPHERAL:
> -	case USB_DR_MODE_OTG:
>  		spin_lock_irqsave(&dwc->lock, flags);
>  		dwc3_gadget_resume(dwc);
>  		spin_unlock_irqrestore(&dwc->lock, flags);
> -		/* FALLTHROUGH */
> -	case USB_DR_MODE_HOST:
> +		break;
> +	case DWC3_GCTL_PRTCAP_HOST:
>  	default:
>  		/* do nothing */
>  		break;
> @@ -1338,7 +1337,7 @@ static int dwc3_resume_common(struct dwc3 *dwc)
>  
>  static int dwc3_runtime_checks(struct dwc3 *dwc)
>  {
> -	switch (dwc->dr_mode) {
> +	switch (dwc->current_dr_role) {
>  	case USB_DR_MODE_PERIPHERAL:
>  	case USB_DR_MODE_OTG:
>  		if (dwc->connected)
> @@ -1381,12 +1380,11 @@ static int dwc3_runtime_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	switch (dwc->dr_mode) {
> -	case USB_DR_MODE_PERIPHERAL:
> -	case USB_DR_MODE_OTG:
> +	switch (dwc->current_dr_role) {
> +	case DWC3_GCTL_PRTCAP_DEVICE:
>  		dwc3_gadget_process_pending_events(dwc);
>  		break;
> -	case USB_DR_MODE_HOST:
> +	case DWC3_GCTL_PRTCAP_HOST:
>  	default:
>  		/* do nothing */
>  		break;
> @@ -1402,13 +1400,12 @@ static int dwc3_runtime_idle(struct device *dev)
>  {
>  	struct dwc3     *dwc = dev_get_drvdata(dev);
>  
> -	switch (dwc->dr_mode) {
> -	case USB_DR_MODE_PERIPHERAL:
> -	case USB_DR_MODE_OTG:
> +	switch (dwc->current_dr_role) {
> +	case DWC3_GCTL_PRTCAP_DEVICE:
>  		if (dwc3_runtime_checks(dwc))
>  			return -EBUSY;
>  		break;
> -	case USB_DR_MODE_HOST:
> +	case DWC3_GCTL_PRTCAP_HOST:
>  	default:
>  		/* do nothing */
>  		break;
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

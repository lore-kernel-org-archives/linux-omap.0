From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/7] usb: dwc3: adapt dwc3 core to use Generic PHY
 Framework
Date: Tue, 15 Oct 2013 16:48:51 +0300
Message-ID: <525D47C3.207@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
 <1378136591-7463-3-git-send-email-kishon@ti.com> <525814A9.7060106@ti.com>
 <525BB8C0.1070802@ti.com> <525BC5A9.3060904@ti.com>
 <20131015115741.GD11380@radagast> <525D30C2.8060208@ti.com>
 <20131015131934.GG11380@radagast>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131015131934.GG11380@radagast>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, Vivek Gautam <gautamvivek1987@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, george.cherian@ti.com, linux-usb@vger.kernel.org, linux@arm.linux.org.uk, s.nawrocki@samsung.com, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, Kishon Vijay Abraham I <kishon@ti.com>, rob@landley.net, bcousson@baylibre.com, galak@codeaurora.org, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ian.campbell@citrix.com
List-Id: linux-omap@vger.kernel.org

On 10/15/2013 04:19 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Oct 15, 2013 at 03:10:42PM +0300, Roger Quadros wrote:
>>>>>>> @@ -665,6 +669,9 @@ struct dwc3 {
>>>>>>>  	struct usb_phy		*usb2_phy;
>>>>>>>  	struct usb_phy		*usb3_phy;
>>>>>>>  
>>>>>>> +	struct phy		*usb2_generic_phy;
>>>>>>> +	struct phy		*usb3_generic_phy;
>>>>>>> +
>>>>>>>  	void __iomem		*regs;
>>>>>>>  	size_t			regs_size;
>>>>>>>  
>>>>>>>
>>>>>
>>>>> Do you have any suggestions on how to get only individual PHYs? like only
>>>>> usb2phy or usb3phy?
>>>>
>>>> My earlier understanding was that both PHYs are needed only if .speed is "super-speed"
>>>> and only usb2phy is needed for "high-speed". But as per Vivek's email it seems
>>>> Samsung's exynos5 SoC doesn't need usb2phy for "super-speed".
>>>>
>>>> So to keeps things flexible, I can propose the following approach
>>>> - if speed == 'high-speed' usb2phy must be present. usb3phy will be ignored if supplied.
>>>> - if speed == 'super-speed' usb3phy must be present and usb2phy is optional but must be
>>>> initialized if supplied.
>>>> - if speed is not specified, we default to 'super-speed'.
>>>>
>>>> Felipe, does this address the issue you were facing with OMAP5?
>>>
>>> on OMAP5 we cannot skip USB3 PHY initialization. But then it becomes a
>>> question of supporting a test feature (in OMAP5 case it would be cool to
>>> force controller to lower speeds for testing) or coping with a broken
>>> DTS.
>>>
>>
>> I don't think we can protect ourselves from all possible broken
>> configurations of DTS.
>> I would vote for simplicity and maximum flexibility.
>>
>> So IMO we should just depend on DTS to provide the phys that are
>> needed by the platform.
>> In the driver we initialize whatever PHY is provided and don't
>> complain if any or even all PHYs are missing.
> 
> considering that DTS is an ABI, I really think eventually we *will* have
> broken DTBs burned into ROM and we will have to find ways to work with
> those too. Same thing already happens today with ACPI tables.
> 
>> If this is not good enough then could you please suggest an
>> alternative? Thanks.
> 
> The alternative would be to mandate nop xceiv for the "missing" PHY, but
> that doesn't solve anything, really, as DTS authors might still forget
> about the NOP xceiv and you can argue that forcing NOP xceiv would be a
> SW configuration.
> 
> So, perhaps we go with the approach that all PHYs are optional, and
> here's my original patch which makes USB3 PHY optional:
> 
> commit 979b84f96e4b7559b596b2933ae198aba267f260
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Sun Jun 30 18:39:23 2013 +0300
> 
>     usb: dwc3: core: make USB3 PHY optional
>     
>     If we want a port to work at any speed lower
>     than Superspeed, it makes no sense to even
>     initialize/power up the USB3 transceiver,
>     provided it won't be used.
>     
>     We can use the oportunity to save some power
>     and leave the superspeed transceiver powered
>     off.
>     
>     There is at least one such case which is
>     Texas Instruments' AM437x which has one
>     of its USB3 ports without a matching USB3
>     PHY (that port is hardwired to work on USB2
>     only).
>     
>     Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 74f9cf0..7a5ab93 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -387,16 +387,34 @@ static int dwc3_probe(struct platform_device *pdev)
>  	if (node) {
>  		dwc->maximum_speed = of_usb_get_maximum_speed(node);
>  
> -		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> -		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
> +		switch (dwc->maximum_speed) {
> +		case USB_SPEED_SUPER:
> +			dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> +			dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
> +			break;
> +		case USB_SPEED_HIGH:
> +		case USB_SPEED_FULL:
> +		case USB_SPEED_LOW:
> +			dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
> +			break;
> +		}
>  
>  		dwc->needs_fifo_resize = of_property_read_bool(node, "tx-fifo-resize");
>  		dwc->dr_mode = of_usb_get_dr_mode(node);
>  	} else if (pdata) {
>  		dwc->maximum_speed = pdata->maximum_speed;
>  
> -		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> -		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
> +		switch (dwc->maximum_speed) {
> +		case USB_SPEED_SUPER:
> +			dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +			dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
> +			break;
> +		case USB_SPEED_HIGH:
> +		case USB_SPEED_FULL:
> +		case USB_SPEED_LOW:
> +			dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
> +			break;
> +		}

What if we try to get both PHYs irrespective of 'maximum_speed' but based
on presence of phandle/pdata. That way there is some control in the adaptation code (dts/pdata)
as to which PHYs needs to be initialized for that particular instance.

This is because there doesn't seem to be a consensus between different designs.
e.g. omap5 needs both phys for 'high-speed' whereas exynos5250 needs just the
usb3 phy for 'super-speed'

>  
>  		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
>  		dwc->dr_mode = pdata->dr_mode;
> @@ -424,19 +442,21 @@ static int dwc3_probe(struct platform_device *pdev)
>  		return -EPROBE_DEFER;
>  	}
>  
> -	if (IS_ERR(dwc->usb3_phy)) {
> -		ret = PTR_ERR(dwc->usb3_phy);
> +	if (dwc->maximum_speed == USB_SPEED_SUPER) {
> +		if (IS_ERR(dwc->usb3_phy)) {
> +			ret = PTR_ERR(dwc->usb3_phy);
>  
> -		/*
> -		 * if -ENXIO is returned, it means PHY layer wasn't
> -		 * enabled, so it makes no sense to return -EPROBE_DEFER
> -		 * in that case, since no PHY driver will ever probe.
> -		 */
> -		if (ret == -ENXIO)
> -			return ret;
> +			/*
> +			 * if -ENXIO is returned, it means PHY layer wasn't
> +			 * enabled, so it makes no sense to return -EPROBE_DEFER
> +			 * in that case, since no PHY driver will ever probe.
> +			 */
> +			if (ret == -ENXIO)
> +				return ret;
>  
> -		dev_err(dev, "no usb3 phy configured\n");
> -		return -EPROBE_DEFER;
> +			dev_err(dev, "no usb3 phy configured\n");
> +			return -EPROBE_DEFER;
> +		}
>  	}
>  
>  	dwc->xhci_resources[0].start = res->start;
> 
> 
> what you guys are saying though, is that every PHY should be optional.
> 
> Do we have any device which doesn't provide USB2 PHY, only USB3 ? Dude,
> that's so non-standard! USB *must* be backwards compatible so I'd expect
> USB2 PHY to always be available.
> 

Maybe the USB2 PHY hardware is there on the Exynos5250 but it just doesn't have discrete power control.
Vivek?

cheers,
-roger

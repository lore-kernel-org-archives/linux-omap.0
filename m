From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v7 5/5] usb: dwc3: core: cleanup IRQ resources
Date: Tue, 10 May 2016 14:45:19 +0300
Message-ID: <5731C9CF.3030303@ti.com>
References: <1462873919-20532-1-git-send-email-rogerq@ti.com>
 <1462873919-20532-6-git-send-email-rogerq@ti.com>
 <877ff2i61f.fsf@linux.intel.com> <5731B395.4010201@ti.com>
 <87shxqgqyw.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87shxqgqyw.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 10/05/16 13:14, Felipe Balbi wrote:
> 
> Hi,
> 
> Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> writes:
>>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>>> index 186a886..2e20892 100644
>>>> --- a/drivers/usb/dwc3/core.h
>>>> +++ b/drivers/usb/dwc3/core.h
>>>> @@ -716,6 +716,8 @@ struct dwc3_scratchpad_array {
>>>>   * @maximum_speed: maximum speed requested (mainly for testing purposes)
>>>>   * @revision: revision register contents
>>>>   * @dr_mode: requested mode of operation
>>>> + * @gadget_irq: IRQ number for Peripheral IRQs
>>>> + * @otg_irq: IRQ number for OTG IRQs
>>>>   * @usb2_phy: pointer to USB2 PHY
>>>>   * @usb3_phy: pointer to USB3 PHY
>>>>   * @usb2_generic_phy: pointer to USB2 PHY
>>>> @@ -817,6 +819,9 @@ struct dwc3 {
>>>>  
>>>>  	enum usb_dr_mode	dr_mode;
>>>>  
>>>> +	int			gadget_irq;
>>>> +	int			otg_irq;
>>>
>>> while at that, let's add host_irq too and do proper changes to dwc3/host.c
>>
>> Sure. So we add host_irq here, and manually create an irq resource
>> in dwc3_host_init?
> 
> right :-) Then the code looks similar for otg, peripheral and host parts ;-)
> 
Just saw that host_irq is not used anywhere other than creating the XHCI platform
device. So I don't see why we need host_irq in struct dwc3.
It is obtained in dwc3_host_init() and consumed there itself.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

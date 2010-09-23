From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path
Date: Thu, 23 Sep 2010 13:47:08 +0400
Message-ID: <4C9B221C.5090807@ru.mvista.com>
References: <1285201846-26599-1-git-send-email-hemahk@ti.com> <CE25F9D2A56A423C84BED8BC132A07FB@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CE25F9D2A56A423C84BED8BC132A07FB-wD+IZp/g4/2mHdYHvhjUOg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maulik <x0082077-l0cyMroinI0@public.gmane.org>
Cc: 'Hema HK' <hemahk-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Felipe Balbi' <balbi-l0cyMroinI0@public.gmane.org>, 'Tony Lindgren' <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, 'Kevin Hilman' <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "'Cousson, Benoit'" <b-cousson-l0cyMroinI0@public.gmane.org>, 'Paul Walmsley' <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 23-09-2010 9:50, Maulik wrote:

>> -----Original Message-----
>> From: Hema HK [mailto:hemahk-l0cyMroinI0@public.gmane.org]
>> Sent: Thursday, September 23, 2010 6:01 AM
>> To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: Hema HK; Maulik Mankad; Felipe Balbi; Tony Lindgren; Kevin Hilman;
>> Cousson, Benoit; Paul Walmsley
>> Subject: [PATCH 9/9 v3] usb : musb: Offmode fix for idle path

>> With OMAP core-off support musb was not functional as context was getting
>> lost after wakeup from core-off. And also musb was blocking the core-off
>> after loading the gadget driver even with no cable connected sometimes.

>> Added the idle and wakeup APIs in the platform layer which will
>> be called in the idle and wakeup path.

>> Used the pm_runtime_put_sysc API to configure the
>> musb to force idle/standby modes, saving the context and disable the clk
>> in
>> while idling if there is no activity on the usb bus.

>> Used the pm_runtime_get_sync API to configure the musb to
>> no idle/standby modes, enable the clock and restore the context
>> after wakeup when there is no activity on the usb bus.

>> Signed-off-by: Hema HK<hemahk-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Maulik Mankad<x0082077-l0cyMroinI0@public.gmane.org>
>> Cc: Felipe Balbi<balbi-l0cyMroinI0@public.gmane.org>
>> Cc: Tony Lindgren<tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>> Cc: Kevin Hilman<khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>> Cc: Cousson, Benoit<b-cousson-l0cyMroinI0@public.gmane.org>
>> Cc: Paul Walmsley<paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

[...]

>> Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
>> ===================================================================
>> --- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
>> +++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
[...]
>> @@ -115,8 +126,101 @@ void __init usb_musb_init(struct omap_mu
>>   	put_device(dev);
>>   }
>>
>> +void musb_prepare_for_idle()
>> +{
>> +	int core_next_state;
>> +	struct omap_hwmod *oh = oh_p;
>> +	struct omap_device *od;
>> +	struct platform_device *pdev;
>> +	struct musb_hdrc_platform_data *pdata;
>> +	struct device *dev;
>> +
>> +	if (!core_pwrdm)
>> +		return;
>> +
>> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>> +	if (core_next_state>= PWRDM_POWER_INACTIVE)
>> +		return;
>> +	if (!oh)
>> +		return;
>> +
>> +	od = oh->od;
>> +	pdev =&od->pdev;
>> +
>> +	if (!pdev)
>> +		return;
>> +	dev =&pdev->dev;
>> +
>> +	if (dev->driver) {
>> +		pdata = dev->platform_data;
>> +
>> +	if (pdata->is_usb_active)

> Don't you need a start brace here?

    No if the *if* only embraces one statement as here. But the next *if* can 
be collapsed into this one.

> Also a tab is required if this if condition is under if (dev->driver)

    Yeah.

>> +		if (!pdata->is_usb_active(dev)) {

    Brace not necessary.

>> +			if (core_next_state == PWRDM_POWER_OFF) {
>> +				pdata->save_context = 1;
>> +				pm_runtime_put_sync(dev);
>> +			} else if  (core_next_state == PWRDM_POWER_RET) {
>> +				pdata->save_context = 0;
>> +				pm_runtime_put_sync(dev);
>> +			}
>> +		}
>> +	}
>> +}
>> +
>> +void musb_wakeup_from_idle()
>> +{
>> +	int core_next_state;
>> +	int core_prev_state;
>> +	struct omap_hwmod *oh = oh_p;
>> +	struct omap_device *od;
>> +	struct platform_device *pdev;
>> +	struct device *dev;
>> +	struct musb_hdrc_platform_data *pdata;
>> +
>> +	if (!core_pwrdm)
>> +		return;
>> +
>> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>> +
>> +	if (core_next_state>= PWRDM_POWER_INACTIVE)
>> +		return;
>> +	 core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
>> +
>> +	 if (!oh)
>> +		return;
>> +	 od = oh->od;
>> +	 pdev =&od->pdev;
>> +
>> +	 if (!pdev)
>> +		return;
>> +
>> +	 dev =&pdev->dev;
>> +
>> +	 if (dev->driver) {
>> +		pdata = dev->platform_data;
>> +
>> +		if (pdata->is_usb_active)

> Braces needed for this if condition?

    No. But the next *if* can be collapsed into the previous.

>> +			if (!pdata->is_usb_active(dev)) {
>> +				if (core_prev_state == PWRDM_POWER_OFF) {
>> +					pdata->restore_context = 1;
>> +					 pm_runtime_get_sync(dev);
>> +				} else {
>> +					 pdata->restore_context = 0;
>> +					 pm_runtime_get_sync(dev);
>> +				}
>> +			 }
>> +	 }
>> +}

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

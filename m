From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [linux-next][PATCH] usb: dwc3: omap: remove IRQ_NOAUTOEN used
 with shared irq
Date: Mon, 3 Jul 2017 13:28:37 -0500
Message-ID: <9b8d09f8-a52d-9992-142d-b3727062b234@ti.com>
References: <20170628233131.19114-1-grygorii.strashko@ti.com>
 <463ea19c-dc60-5926-56b4-0f10d2e23e94@ti.com>
 <20170629060353.GE3730@atomide.com>
 <dac573e2-31e3-b431-8510-973d691fc0ed@ti.com>
 <c54d656c-469f-b81d-5af4-91aec6f9da20@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c54d656c-469f-b81d-5af4-91aec6f9da20-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "GregKroah-Hartmangregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <GregKroah-Hartmangregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 07/02/2017 11:27 PM, Vignesh R wrote:
> Hi,
> 
> On Saturday 01 July 2017 01:04 AM, Strashko, Grygorii wrote:
>>
>>
>> On 06/29/2017 01:03 AM, Tony Lindgren wrote:
>>> * Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> [170628 21:21]:
>>>>
>>>>
>>>> On Thursday 29 June 2017 05:01 AM, Strashko, Grygorii wrote:
>>>>> IRQ_NOAUTOEN can't be used with shared IRQs and Kernel now will triggers
>>>>> warning if it happns, since commit 04c848d39879 ("genirq: Warn when
>>>>> IRQ_NOAUTOEN is used with shared interrupts"). And this is the case for
>>>>> OMAP DWC 3 driver.
>>>>>
>>>>> Hence, remove IRQ_NOAUTOEN flag and instead call disable_irq() before
>>>>> disabling PM runtime in probe error path handling.
>>>>
>>>> Or, how about requesting the irq at the end of probe after extcon
>>>> registration?
>>>
>>> Hmm yeah, what prevents the issue that we tried to fix with commit
>>> 12a7f17fac5b ("usb: dwc3: omap: fix race of pm runtime with irq handler
>>> in probe")?
>>
>> No, I think. There should be the disable_irq() call any way
>> before pm_runtime_put_sync(dev);| pm_runtime_disable(dev); -
>> once IRQ is requested driver can't know if IRQ handler is running now or not
>> unless it will call disable_irq()/free_irq().
>>
>> But, I've also thought about moving request_irq() down (seems
>> it can be moved even after of_platform_populate()).
>> looks like it can be separate patch.
>>
> 
> commit 12a7f17fac5b says PM runtime can race with IRQ handler when
> deferred probing happening due to extcon, therefore IRQ_NOAUTOEN was set
> and disable_irq() call was added. If IRQ handler registration is moved
> to a place after of_platform_populate(), then we can be sure that extcon
> is registered and there wont be any deferred probe or race with irq
> handler and PM runtime. Would disable_irq() still be needed then?
> 

You might be correct, so feel free to send a patch.

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

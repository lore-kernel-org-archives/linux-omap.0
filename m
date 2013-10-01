From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] DRIVERS: IRQCHIP: Add support for crossbar IP
Date: Tue, 1 Oct 2013 09:57:11 -0400
Message-ID: <524AD4B7.7040700@ti.com>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com> <52499441.1030403@gmail.com> <524AAE69.8060703@ti.com> <524AD290.207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <524AD290.207-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Cc: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 01 October 2013 09:48 AM, Rob Herring wrote:
> On 10/01/2013 06:13 AM, Sricharan R wrote:
>> Hi,
>>
>> On Monday 30 September 2013 08:39 PM, Rob Herring wrote:
>>> On 09/30/2013 08:59 AM, Sricharan R wrote:
>>>> Some socs have a large number of interrupts requests to service
>>>> the needs of its many peripherals and subsystems. All of the interrupt
>>>> requests lines from the subsystems are not needed at the same
>>>> time, so they have to be muxed to the controllers appropriately.
>>>> In such places a interrupt controllers are preceded by an
>>>> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
>>>> requests to the controller inputs.
>>>>
>>>> This series models the peripheral interrupts that can be routed through
>>>> the crossbar to the GIC as 'routable-irqs'. The routable irqs are added
>>>> in a separate linear domain inside the GIC. The registered routable domain's
>>>> callback are invoked as a part of the GIC's callback, which in turn should
>>>> allocate a free irq line and configure the IP accordingly. So every peripheral
>>>> in the dts files mentions the fixed crossbar number as its interrupt. A free
>>>> gic line for that gets allocated and configured when the peripheral's interrupt
>>>> is mapped.
>>>>
>>>> The minimal crossbar driver to track and allocate free GIC lines and configure the
>>>> crossbar is added here, along with the DT bindings.
>>> Seems like interrupt-map property is what you need here.
>>>
>>> http://devicetree.org/Device_Tree_Usage#Advanced_Interrupt_Mapping
>>>
>>> Versatile Express also has an example.
>>    OK, but the idea was not to tie up the crossbar<->interrupt numbers at the
>>    DTS level, but to assign it dynamically during runtime. This was one of the
>>   comments that came up with first crossbar support patches, which was assigning a
>>   interrupt line to crossbar number in the DTS and setting it up in crossbar probe.
> 
> Is there an actual usecase on a single h/w design that you run out of
> interrupts and it is a user decision which interrupts to use?
>
Yes. There are 240 peripheral interrupts connected out of which 160 can
be used in this specific case. 
 
> You could fill in the interrupt-map at run-time. It would have to be
> early (bootloader or early kernel init) and can't be at request_irq time.
>
Well all options are tried before coming up to the $subject solution.
It was suggested by Thomas in the last review.
 
>>     https://lkml.org/lkml/2013/7/18/416
>>
>>    Since this approach of assigning in DTS was opposed, we moved to IRQCHIP and
>>    that did not go as well. Finally was asked to handle this as a part of GIC driver with
>>    a separate domain.
>>    
>>   http://www.spinics.net/lists/linux-omap/msg97085.html
> 
> This has nothing to do with the GIC, so it does not belong there.
> 
Well the router makes connections from peripheral to GIC. Thomas can
better explain it but I think since its doing irq routing for GIC on
a given hardware, I don't see any issue having some generic map/unmap
function in GIC. The actual implementation is still outside of GIC.

Regards,
Sasntosh

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

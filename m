From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 04/11] otg-fsm: move usb_bus_start_enum into otg-fsm->ops
Date: Thu, 16 Jul 2015 13:40:05 +0300
Message-ID: <55A78A05.4030403@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <1436350777-28056-5-git-send-email-rogerq@ti.com> <20150713015759.GC27710@shlinux2> <55A38F62.8010509@ti.com> <20150714003427.GA31197@shlinux2> <55A66073.5010800@ti.com> <20150716005413.GA25628@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150716005413.GA25628@shlinux2>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 16/07/15 03:54, Peter Chen wrote:
> On Wed, Jul 15, 2015 at 04:30:27PM +0300, Roger Quadros wrote:
>> On 14/07/15 03:34, Peter Chen wrote:
>>> On Mon, Jul 13, 2015 at 01:13:54PM +0300, Roger Quadros wrote:
>>>> Peter,
>>>>
>>>> On 13/07/15 04:58, Peter Chen wrote:
>>>>> On Wed, Jul 08, 2015 at 01:19:30PM +0300, Roger Quadros wrote:
>>>>>> This is to prevent missing symbol build error if OTG is
>>>>>> enabled (built-in) and HCD core (CONFIG_USB) is module.
>>>>>>
>>>>>
>>>>> We may let the OTG-DRD/OTG-FSM depends on CONFIG_USB to fix it.
>>>>
>>>> CONFIG_OTG already depends on CONFIG_USB as it is a sub-option of
>>>> CONFIG_USB. It doesn't depend on CONFIG_USB_GADGET and that can
>>>> be fixed.
>>>>
>>>> But dependency is not the problem here. Symbols not available to
>>>> OTG driver when USB/GADGET is 'm' is the problem.
>>>>
>>>> e.g.
>>>> CONFIG_USB_OTG is always built-in.
>>>> we need to work if CONFIG_USB is 'm'/'y'
>>>> _and_ if CONFIG_USB_GADGET is 'm'/'y'
>>>>
>>>
>>> below should fix this issue, but we may need to make some
>>> changes for code which are defined by CONFIG_USB_OTG.
>>>
>>> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
>>> index a99c89e..5e374ad 100644
>>> --- a/drivers/usb/core/Kconfig
>>> +++ b/drivers/usb/core/Kconfig
>>> @@ -42,8 +42,9 @@ config USB_DYNAMIC_MINORS
>>>           If you are unsure about this, say N here.
>>>
>>> config USB_OTG
>>> -       bool "OTG support"
>>> +       tristate "OTG support"
>>> 	depends on PM
>>> +       depends on USB && USB_GADGET
>>> 	default n
>>>    help
>>>      The most notable feature of
>>>      USB OTG is support for a
>>
>> With this USB_OTG will become 'm' when either USB or USB_GADGET is m
>> and will break if either USB or USB_GADGET is made y as all OTG core
>> API symbols won't be available. :)
>>
> 
> Ok, after thinking more, seems we can't handle properly if USB_OTG as
> 'm', your idea that using host/gadget/fsm->ops to call hcd/gadget API
> and the controller driver will defines these ops (due to it will use
> hcd/gadget function) is proper way currently.
> 

Can I take this as your Ack for this patch? :)

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

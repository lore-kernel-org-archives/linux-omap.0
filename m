From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v10 08/14] usb: otg: add OTG/dual-role core
Date: Fri, 10 Jun 2016 13:44:03 +0300
Message-ID: <a559997c-2107-1850-1b22-c4532350d665@cogentembedded.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-9-git-send-email-rogerq@ti.com> <57592060.6060801@ti.com>
 <2522343c-422f-79e1-af40-eb953bde42f6@cogentembedded.com>
 <575A9430.6070508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <575A9430.6070508-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 6/10/2016 1:19 PM, Roger Quadros wrote:

>>> It provides APIs for the following tasks
>>>
>>> - Registering an OTG/dual-role capable controller
>>> - Registering Host and Gadget controllers to OTG core
>>> - Providing inputs to and kicking the OTG state machine
>>>
>>> Provide a dual-role device (DRD) state machine.
>>> DRD mode is a reduced functionality OTG mode. In this mode
>>> we don't support SRP, HNP and dynamic role-swap.
>>>
>>> In DRD operation, the controller mode (Host or Peripheral)
>>> is decided based on the ID pin status. Once a cable plug (Type-A
>>> or Type-B) is attached the controller selects the state
>>> and doesn't change till the cable in unplugged and a different
>>> cable type is inserted.
>>>
>>> As we don't need most of the complex OTG states and OTG timers
>>> we implement a lean DRD state machine in usb-otg.c.
>>> The DRD state machine is only interested in 2 hardware inputs
>>> 'id' and 'b_sess_vld'.
>>>
>>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>>
>
> <snip>
>
>> [...]
>>> +/**
>>> + * usb_otg_register_gadget - Register the gadget controller to OTG core
>>> + * @gadget:    gadget controller
>>
>>    We call that USB device controller (UDC). I'm not sure what you meant here...
>>    And what about the 2nd arg, 'ops'?
>
> There are 2 data structures representing the Device controller.
>
> struct usb_gadget - represents a usb slave device
> struct usb_udc -struct usb_udc - describes one usb device controller
>
> usb_udc is for private use only. usb_otg_register_gadget() takes struct usb_gadget
> as argument.
>
> Do you want me to refer to struct usb_gadget as UDC?

    No.

> What is wrong with calling it gadget controller?

    It's not a controller, it's a piece of software AFAIU. Or is my English 
just too weak? :-)

> --
> cheers,
> -roger

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

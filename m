From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH v2 05/13] usb: otg: add OTG core
Date: Wed, 15 Apr 2015 16:24:33 +0300
Message-ID: <552E6691.3020908@ti.com>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>	 <1429008120-5395-6-git-send-email-rogerq@ti.com> <1429090149.16771.19.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429090149.16771.19.camel@x220>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 15/04/15 12:29, Paul Bolle wrote:
> (This will go into a minor detail. That's probably not what you want
> when posting an RFC. But this patch got caught by an email filter I use
> and a future, non-RFC, version will get caught too. So I decided to
> bother you with this now.)
> 
> On Tue, 2015-04-14 at 13:41 +0300, Roger Quadros wrote:
>> --- a/drivers/usb/common/Makefile
>> +++ b/drivers/usb/common/Makefile
> 
>> +obj-$(CONFIG_USB_OTG_CORE) += usb-otg.o
> 
> This creates a module usb-otg.ko if CONFIG_USB_OTG_CORE is 'm', built
> from just usb-otg.c.
> 
>> --- /dev/null
>> +++ b/drivers/usb/common/usb-otg.c
> 
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
> 
>> +EXPORT_SYMBOL_GPL(usb_otg_register);
> 
>> +EXPORT_SYMBOL_GPL(usb_otg_unregister);
> 
>> +EXPORT_SYMBOL_GPL(usb_otg_sync_inputs);
> 
>> +EXPORT_SYMBOL_GPL(usb_otg_kick_fsm);
> 
>> +EXPORT_SYMBOL_GPL(usb_otg_register_hcd);
> 
>> +EXPORT_SYMBOL_GPL(usb_otg_unregister_hcd);
> 
>> +EXPORT_SYMBOL_GPL(usb_otg_register_gadget);
> 
>> +EXPORT_SYMBOL_GPL(usb_otg_unregister_gadget);
>  
>> +EXPORT_SYMBOL_GPL(usb_otg_fsm_to_dev);
> 
> This code adds no MODULE_LICENSE() macro in this patch and usb-otg.ko
> will carry no license field. So I think the loading of that module
> (triggered by loading another module that uses one of the exported
> symbols, I suppose) taints the kernel. Am I correct?

Right. I will fix this. Thanks.

cheers,
-roger

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

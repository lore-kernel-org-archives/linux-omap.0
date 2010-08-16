From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 8/8 ]usb : musb:Using runtime pm apis for musb.
Date: Mon, 16 Aug 2010 17:41:59 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270AE9B45@dbde02.ent.ti.com>
References: <1281115749-1601-1-git-send-email-hemahk@ti.com>
 <4C5D8150.4020009@ru.mvista.com> <4C628B01.2010009@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C628B01.2010009-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 Hi,

>-----Original Message-----
>From: Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org] 
>Sent: Wednesday, August 11, 2010 5:05 PM
>To: Kalliguddi, Hema
>Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>Basak, Partha; Felipe Balbi; Tony Lindgren; Kevin Hilman
>Subject: Re: [PATCH 8/8 ]usb : musb:Using runtime pm apis for musb.
>
>Hello.
>
>I wrote:
>
>>> Calling runtime pm APIs pm_runtime_put_sync() and 
>>> pm_runtime_get_sync() for enabling/disabling the clocks,sysconfig 
>>> settings.
>
>>> used omap_hwmod_enable_wakeup & omap_hwmod_disable_wakeup apis to 
>>> set/clear
>>> the wakeup enable bit.
>>> Also need to put the USB in force standby and force idle 
>mode when usb 
>>> not used
>>> and set it back to smart idle and smart stndby after wakeup.
>>> these cases are handled using the oh flags.
>>> For omap3430 auto idle bit has to be disabled because of 
>the errata.So 
>>> using HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.
>
>>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>> Signed-off-by: Basak, Partha <p-basak2-l0cyMroinI0@public.gmane.org>
>
>>> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>
>[...]
>
>>> Index: linux-omap-pm/include/linux/usb/musb.h
>>> ===================================================================
>>> --- linux-omap-pm.orig/include/linux/usb/musb.h    2010-08-06 
>>> 10:44:06.000000000 -0400
>>> +++ linux-omap-pm/include/linux/usb/musb.h    2010-08-06 
>>> 10:44:42.946115274 -0400
>>> @@ -10,6 +10,9 @@
>>>  #ifndef __LINUX_USB_MUSB_H
>>>  #define __LINUX_USB_MUSB_H
>>>  
>>> +#include <linux/platform_device.h>
>
>>    You could just use incomplete declaration of 'struct 
>platfrom_device' 
>> instead of this #include.
>
>>> +#include <plat/omap_hwmod.h>
>
>    Did you think about the other platfroms where this file 
>doesn't exist? How 
>are they supposed to compile?!
>    I think this #include needs to be wrapped in #ifdef as well...

Good point. I did not think of it. It need not be wrapped. Instead I am changing the 
Enable_wakeup/disable_wakeup parameter to platform_device instead of omap_device.
So that I can avoid these includes.
>
>>> +
>>>  /* The USB role is defined by the connector used on the board, so 
>>> long as
>>>   * standards are being followed.  (Developer boards 
>sometimes won't.)
>>>   */
>>> @@ -129,6 +132,21 @@
>>>  
>>>      /* check usb device active state*/
>>>      int        (*is_usb_active)(struct device *dev);
>>> +
>>> +    /* omap hwmod data structure     */
>>> +    struct    omap_hwmod *oh;
>
>>    This should be wrapped into #ifdef, don't you think?
>
>>> +    /* enable clocks and set sysconfig register*/
>>> +    int        (*device_enable)(struct platform_device *pdev);
>>> +
>>> +    /* Disable clock and reset the sysconfig register settings*/
>>> +    int        (*device_idle)(struct platform_device *pdev);
>>> +
>>> +    /* set the enable wakeup bit of sysconfig register */
>>> +    int        (*enable_wakeup)(struct omap_device *od);
>>> +
>>> +    /* Clear the enable wakeup bit  of sysconfig register */
>>> +    int        (*disable_wakeup)(struct omap_device *od);
>
>>    This should be wrapped too, I think...

It will be taken care.
>
>WBR, Sergei
>
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

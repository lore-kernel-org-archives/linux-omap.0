From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: remove devm_request_threaded_irq
Date: Fri, 9 Dec 2016 17:32:11 -0600
Message-ID: <e394c44c-3ae3-b0ac-2b02-a886ca2510bd@ti.com>
References: <20161209205508.6456-1-grygorii.strashko@ti.com>
 <20161209215958.GN4920@atomide.com>
 <db75608b-f92c-6bfa-80a9-a3ab3adf7c23@ti.com>
 <20161209230457.GO4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161209230457.GO4920-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org



On 12/09/2016 05:04 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [161209 14:46]:
>>
>>
>> On 12/09/2016 03:59 PM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [161209 12:55]:
>>>> Switch back from devm_request_threaded_irq() to request_threaded_irq() to
>>>> avoid races between interrupt handler execution and PM runtime in error
>>>> handling code path in probe and in dwc3_omap_remove():
>>>
>>> Can't you just call disable_irq() on the exit path instead of removing
>>> devm?
>>>
>>
>> I can. But what will be the benefit from using devm then?
> 
> Hmm good point. Probably the least number of code would be to just
> do NOAUTOEN before devm_request_irq(), then only do enable_irq()
> just before returning from the probe. After all, we don't really
> want the irq running until the probe is done.
> 
> I think that would leave out the extra handling from the error
> path?
> 

Good question here is - do we need this irq to be enabled for sub-device
probing from of_platform_populate()? ;)  

-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

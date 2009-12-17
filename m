From: Arnaud Mandy <ext-arnaud.2.mandy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3 v3] musb: Add context save and restore support
Date: Thu, 17 Dec 2009 16:10:54 +0200
Message-ID: <4B2A3BEE.7000809@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com> <1260797982-28880-2-git-send-email-ajay.gupta@ti.com> <4B2A3453.7040008@nokia.com> <19F8576C6E063C45BE387C64729E73940449F439C7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E73940449F439C7-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

ext Gupta, Ajay Kumar wrote:
> <snip>
>   
>>>  #ifdef CONFIG_PM
>>>
>>> +static struct musb_context_registers musb_context;
>>> +
>>> +void musb_save_context(struct musb *musb)
>>> +{
>>>
>>>       
>> Could you add one more parameter to this function call, which would
>> select either if we want to save the musb_platform context or not?
>> I m working at the moment on turning off the musb when cable unplugged
>> and turning it on with restoring context after cable re-connect.
>> In this case I don't need to restore the the musb_platform_context since
>> I just set them before calling this one.
>>
>> Same apply for restore.
>>
>> what do you think?
>> I could also modify slightly this implementation after it is ready and
>> submit it.
>>     
>
> I think you want to add the parameter in musb_platform_save_context()  and
> not in musb_save_context.
> If so then where do you restore them? {As you said before calling this}
>   

In order to support off-mode, we need the transceiver driver to wake-up 
the controller.
I m working on a hook which would allow that.
I want to take advantage of your implementation for saving/restoring 
musb context, but saving the platform data is not necessary in my case.
Maybe it musb_platform_save/restore_context(), shouldn't be called from 
musb_save/restore_context();

> I think if the requirement is generic and suits for all other platforms
> Using musb then we can add it.
>   

Yes it should.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] AM35x: Add musb support
Date: Mon, 22 Mar 2010 16:31:46 +0300
Message-ID: <4BA77142.3050109@mvista.com>
References: <1267017495-17548-1-git-send-email-ajay.gupta@ti.com>,<4BA4CCF3.4060500@ru.mvista.com> <19F8576C6E063C45BE387C64729E7394044DCC5F29@dbde02.ent.ti.com> <4BA5FBF6.8010102@mvista.com> <19F8576C6E063C45BE387C64729E7394044DE0E5E6@dbde02.ent.ti.com> <4BA742ED.6080004@ru.mvista.com> <19F8576C6E063C45BE387C64729E7394044DE0E71B@dbde02.ent.ti.com> <4BA74E48.30109@ru.mvista.com> <19F8576C6E063C45BE387C64729E7394044DE0E730@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DE0E730-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Gupta, Ajay Kumar wrote:
>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org]
>> Sent: Monday, March 22, 2010 4:33 PM
>> To: Gupta, Ajay Kumar
>> Cc: Sergei Shtylyov; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: Re: [PATCH] AM35x: Add musb support
>>
>> Gupta, Ajay Kumar wrote:
>>
>>     
>>>>>>> I have not added CPPI4.1 DMA  specific register here..
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>               
>>>>>>    Ah. Then they're not compatible with DA8xx anyway...
>>>>>>
>>>>>>
>>>>>>             
>>>>> We could make it compatible with some change as done at,
>>>>> http://arago-project.org/git/people/?p=sriram/ti-psp-
>>>>>
>>>>>           
>>>> omap.git;a=commitdiff;h=2ecce9529bd56c32997e0b2cbe84f7727ba5b217
>>>>
>>>> I'm not sure where cppi41_dma.c gets the definitions for
>>>> USB_[RT]X_MODE_REG...
>>>>
>>>>         
>>> It is being used from plat/usb.h.
>>>
>>>       
>>    I haven't found where it's included.
>>     
>
> It's from cppi41_dma.h.
>   

   Well, you've removed the register #define's from cppi41_dma.h and 
#includ'ed <plat/usb.h> BUT there's certainly no such header for DA8xx , 
so as I  suspected you've broken DA8xx support. That certainly won't do. :-/

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

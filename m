From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: Use pinctrl constants
Date: Fri, 23 Oct 2015 16:47:09 +0200
Message-ID: <CABxcv==XkkrRL87F4hgwgyqyokzhW=3=eyZurNixbrQ-E9GfMA@mail.gmail.com>
References: <1445530847-25217-1-git-send-email-afd@ti.com>
	<20151022212356.GU3078@atomide.com>
	<562A3141.9000701@ti.com>
	<CABxcv=kDXK3CR=YfS-P9VaaXY-rmT2KpuKsAs_BdfZMVtfwzDQ@mail.gmail.com>
	<562A45DC.1090501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562A45DC.1090501-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello Andrew,

On Fri, Oct 23, 2015 at 4:36 PM, Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org> wrote:
> On 10/23/2015 09:29 AM, Javier Martinez Canillas wrote:
>>
>> Hello Andrew,
>>
>> On Fri, Oct 23, 2015 at 3:08 PM, Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org> wrote:
>>>
>>> On 10/22/2015 04:23 PM, Tony Lindgren wrote:
>>>>
>>>>
>>>> * Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org> [151022 09:21]:
>>>>>
>>>>>
>>>>> Using constants for pinctrl allows better readability and removes
>>>>> redundancy with comments.
>>>>
>>>>
>>>>
>>>> You should use the include/dt-bindings/pinctrl/omap.h macro
>>>> AM33XX_IOPAD(pa, val) while at it. Otherwise we'll end up patching
>>>> the same things again later on.
>>>>
>>>
>>> Hmm, I haven't really been following this change, it kind of seems to add
>>> some unnecessary abstraction by using physical hardware addresses instead
>>> of offsets, then just converting them back to offsets. The offset style
>>> DT
>>> nodes are already auto-generated with existing tools anyway:
>>> https://dev.ti.com/pinmux
>>>
>>> I'm sure this has been discussed already so if this is a blocker I'll
>>> re-spin this.
>>>
>>
>> The good thing about the IOPAD pinmux macros is that matches what is
>> in the TRM so it is easier to read the DTS and verify that is correct.
>>
>> I've on my queue to migrate all the remaining DTS for TI SoCs to use
>> the IOPAD macros but is just that I didn't have time to do it this
>> week. Probably I'll do it at the end of the next week.
>>
>
> Then this patch can probably be dropped, hopefully the converted constants
> in this patch can be of some help for you though.
>

Yes they are but feel free to re-spin your patch if you wish, it will
be one less DTS to convert :-)

But yes, if you don't then I'll do it when changing all DTS.

> Andrew
>
>

Best regards,
Javier
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

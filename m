From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-boneblack: Use pinctrl constants
Date: Fri, 23 Oct 2015 09:36:12 -0500
Message-ID: <562A45DC.1090501@ti.com>
References: <1445530847-25217-1-git-send-email-afd@ti.com>
 <20151022212356.GU3078@atomide.com> <562A3141.9000701@ti.com>
 <CABxcv=kDXK3CR=YfS-P9VaaXY-rmT2KpuKsAs_BdfZMVtfwzDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABxcv=kDXK3CR=YfS-P9VaaXY-rmT2KpuKsAs_BdfZMVtfwzDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 10/23/2015 09:29 AM, Javier Martinez Canillas wrote:
> Hello Andrew,
>
> On Fri, Oct 23, 2015 at 3:08 PM, Andrew F. Davis <afd@ti.com> wrote:
>> On 10/22/2015 04:23 PM, Tony Lindgren wrote:
>>>
>>> * Andrew F. Davis <afd@ti.com> [151022 09:21]:
>>>>
>>>> Using constants for pinctrl allows better readability and removes
>>>> redundancy with comments.
>>>
>>>
>>> You should use the include/dt-bindings/pinctrl/omap.h macro
>>> AM33XX_IOPAD(pa, val) while at it. Otherwise we'll end up patching
>>> the same things again later on.
>>>
>>
>> Hmm, I haven't really been following this change, it kind of seems to add
>> some unnecessary abstraction by using physical hardware addresses instead
>> of offsets, then just converting them back to offsets. The offset style DT
>> nodes are already auto-generated with existing tools anyway:
>> https://dev.ti.com/pinmux
>>
>> I'm sure this has been discussed already so if this is a blocker I'll
>> re-spin this.
>>
>
> The good thing about the IOPAD pinmux macros is that matches what is
> in the TRM so it is easier to read the DTS and verify that is correct.
>
> I've on my queue to migrate all the remaining DTS for TI SoCs to use
> the IOPAD macros but is just that I didn't have time to do it this
> week. Probably I'll do it at the end of the next week.
>

Then this patch can probably be dropped, hopefully the converted constants
in this patch can be of some help for you though.

Andrew

>> Andrew
>>
>>
>>> Regards,
>>>
>
> Best regards,
> Javier
>

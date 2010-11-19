From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 2/5] OMAP: mailbox: fix rx interrupt disable in omap4
Date: Fri, 19 Nov 2010 15:50:02 +0100
Message-ID: <4CE68E9A.5040903@ti.com>
References: <1290107742-16760-1-git-send-email-h-kanigeri2@ti.com>	<1290107742-16760-3-git-send-email-h-kanigeri2@ti.com>	<4CE5B68F.8000502@ti.com>	<AANLkTinVOKZoSRkXyfzUap5mOmRE5nNsvCiw_QDUxb85@mail.gmail.com>	<20101119083250.GH6446@legolas.emea.dhcp.ti.com> <AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49227 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab0KSOuR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Nov 2010 09:50:17 -0500
In-Reply-To: <AANLkTimzaB6aFo2=iEpR=2a3T_3oWQa6iBxQxWhBBCiw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 11/19/2010 3:22 PM, Kanigeri, Hari wrote:
> Felipe,
>
> On Fri, Nov 19, 2010 at 2:32 AM, Felipe Balbi<balbi@ti.com>  wrote:
>> On Thu, Nov 18, 2010 at 06:07:40PM -0600, Kanigeri, Hari wrote:
>>>
>>> Benoit,
>>>
>>> On Thu, Nov 18, 2010 at 5:28 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>>>>
>>>> On 11/18/2010 8:15 PM, Hari Kanigeri wrote:
>>>>>
>>>>> disabling rx interrupt on omap4 is different than its pre-decessors.
>>>>> The bit in OMAP4_MAILBOX_IRQENABLE_CLR should be set to disable the
>>>>> interrupts instead of clearing the bit.
>>>>>
>>>>> Signed-off-by: Hari Kanigeri<h-kanigeri2@ti.com>
>>>>> ---
>>>>>   arch/arm/mach-omap2/mailbox.c |    5 ++++-
>>>>>   1 files changed, 4 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-omap2/mailbox.c
>>>>> b/arch/arm/mach-omap2/mailbox.c
>>>>> index 42dbfa4..82b5ced 100644
>>>>> --- a/arch/arm/mach-omap2/mailbox.c
>>>>> +++ b/arch/arm/mach-omap2/mailbox.c
>>>>> @@ -195,7 +195,10 @@ static void omap2_mbox_disable_irq(struct omap_mbox
>>>>> *mbox,
>>>>>         struct omap_mbox2_priv *p = (struct omap_mbox2_priv *)mbox->priv;
>>>>>         u32 l, bit = (irq == IRQ_TX) ? p->notfull_bit : p->newmsg_bit;
>>>>>         l = mbox_read_reg(p->irqdisable);
>>>>> -       l&= ~bit;
>>>>> +       if (cpu_is_omap44xx())
>>>>
>>>> Since it is not omap version specific but IP version specific, you should
>>>> not use cpu_is_ to do that. Moreover cpu_is calls should be used during
>>>> init
>>>> only.
>>>> You can use the rev field in hwmod_class in order to detect the IP
>>>> version.
>>>> Smartreflex series for 3630 is already using that kind of mechanism.
>>>> You will have to copy that revision information into pdata struct and
>>>> then
>>>> use that here.
>>>
>>> I see your point, but since mailbox hwmod patches from Omar are still
>>> under review I didn't find any other option than to enable this
>>> This is critical functionality that I want to include in and not wait
>>> till the hwmod patches are accepted.

OK, I didn't see that your series was supposed to be done before Omar's one.

>>> Please let me know if there is any other way of approaching this problem ?
>>
>> how about you read the IP revision yourself during probe ? Or pass in a
>> flag like I said on the other email ?
>>
>
> I like your proposal of reading the IP revision in probe. I will send
> a revised patch for this.

Most of the time, we do not want to use the IP revision because it is 
un-accurate and does not reflect the change we'd like to track.
For example some time a minor change in the RTL that will not impact the 
SW at all might trigger a change in the IP revision, whereas on the 
other hand a major bug fix that will impact the SW is not capture in the 
IP revision... yeah, that's bad, but this can happen.

That's why we are relying on a rev field in the hwmod.

Meanwhile, you can do the cpu_is check at init time, then fill a pdata 
attribute with a revision parameter, and use that revision parameter in 
the omap2_mbox_disable_irq.
When hwmod will be there you will just extract that information from the 
hwmod rev field.

Regards,
Benoit


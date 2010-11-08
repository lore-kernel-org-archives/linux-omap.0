From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 3/7] OMAP4: hwmod data: add mailbox data
Date: Mon, 8 Nov 2010 03:56:31 -0500
Message-ID: <4CD7BB3F.1010304@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>	<1289006244-27147-4-git-send-email-omar.ramirez@ti.com>	<4CD58DF6.6040600@ti.com> <AANLkTi=mkBROke+4Yf25QndYB=0pE+k0tE2NKxUM5xU_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51815 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368Ab0KHI4B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 03:56:01 -0500
In-Reply-To: <AANLkTi=mkBROke+4Yf25QndYB=0pE+k0tE2NKxUM5xU_@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Omar,

On 11/7/2010 10:07 AM, Ramirez Luna, Omar wrote:
> On Sat, Nov 6, 2010 at 12:18 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> I don't know why, but this patch has nothing to do with my original one.
>> Can you stick to the original code?
>
> no, apart from the ordering of structure members, that I will change,

If you do want to change a patch already submitted to loml, the least 
you can do is to comment on the mailing list, and afaik, you didn't 
provide any comment on this code.
So do not change it without any explanation or any rational.
That's the most basic rule of the patch submission / review process in 
Linux.

> since keeping the order of the original structure doesn't fly, I don't
> see anything that needs to be changed.
>
> - The magic numbers replaced for the defines, afaik it gives more clarity.

No, since these are not magic numbers but physical address or dma number 
or irq channel.
That does not give any more clarity to add a define, and in fact it adds 
an extra level of indirection for nothing.
The hwmod file is "the" unique HW definition files. So all the 
information that used to be scattered all over various header files will 
have to be there.
You should considered this file as a global SoC HW definition file.

> - mailbox irq has a name.

Which is in the structure anyway, so again no need to add a define.
All the structure that are populated hrer are all unique to every IP, so 
having that kind of assignment does not seems very useful to me.

omap44xx_mailbox_irq = OMAP44XX_MAILBOX_IRQ;

whereas that:
omap44xx_mailbox_irq = 20;

Give you a little be more information, because you do not have have to 
read the TRM or another header file to get the real number.

FYI, that was discussed at least 6 months ago during the submission of 
the early hwmod series.

> - overall defining block was improved:
>
>          class
>          ocp_if
>          slave ports
>          hwmod
>
> If you see, each dependent reference is right before the structure
> that is using it, which at least to me establishes some order, as of
> today this ordering doesn't exists.
>
> e.g. you are defining some hwmod and some how you are populating all
> the members, if you are looking at your omap_hwmod struct and want to
> see the irqs defined you need to scroll beyond the supposed first
> reference in omap_hwmod (right now above ocp_if)

So what? If you have any issue with the original order, please feel free 
to comment on the original patch.
In case you didn't notice, all the OMAP4 data are following the same 
pattern. So any change to the structure should be applied everywhere.

I do not have any issue to improve the overall readability if that make 
sense for everybody, but again, please comment first.

>>
>> On 11/5/2010 9:17 PM, Ramirez Luna, Omar wrote:
>>> +/* mailbox */
>>
>> The original comment is missing.
>
> <quote>
> /*
>   * 'mailbox' class
>   * mailbox module allowing communication between the on-chip processors
>   * useusing a queued mailbox-interrupt mechanism.
>   */
> </quote>
>
> I don't think it adds anything to the patch, should we start
> commenting on the functionality of the drivers for each hwmod?

In that case, it does not hurt since this file is the C file version of 
the TRM. You might not care because you know what that module is doing, 
but most people don't.

>
>>> +
>>> +static struct omap_hwmod omap44xx_mailbox_hwmod;
>>> +
>>> +static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
>>> +       {
>>> +               .pa_start       = OMAP44XX_MAILBOX_BASE,
>>
>> If that physical address is not used elsewhere, and it should be the case,
>> there is no need to create a define for it. That's why the physical address
>> was directly used here.
>> There is no added value to create a define for that.
>
> yes there is, apart from readability where '0x4a0f4000' doesn't say much

It says everything... when you use a debugger, what kind of information 
OMAP44XX_MAILBOX_BASE will give you? Nothing, you will have to check 
again the TRM or the define to get the real useful information.

> for me at least, if reviewing I need to open the TRM check if that is
> the address and move on, with the define you know that someone have
> checked the address before (when creating the define)

And what if the define is wrong??? You have as well to check the TRM... 
FYI, that file is automatically generated from the HW data, so it has a 
much lower probably to contain wrong data. Especially compared to a 
manually written header file done from a buggy TRM.

Regards,
Benoit

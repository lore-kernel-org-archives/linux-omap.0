From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 3/7] OMAP4: hwmod data: add mailbox data
Date: Mon, 8 Nov 2010 10:55:50 -0600
Message-ID: <AANLkTim2_CaznLkjMDgH5jBxPJhCrD3Vjx8D44F7+COm@mail.gmail.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
	<1289006244-27147-4-git-send-email-omar.ramirez@ti.com>
	<4CD58DF6.6040600@ti.com>
	<AANLkTi=mkBROke+4Yf25QndYB=0pE+k0tE2NKxUM5xU_@mail.gmail.com>
	<4CD7BB3F.1010304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60352 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754881Ab0KHQzw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 11:55:52 -0500
Received: by mail-iw0-f169.google.com with SMTP id 9so6741415iwn.0
        for <linux-omap@vger.kernel.org>; Mon, 08 Nov 2010 08:55:52 -0800 (PST)
In-Reply-To: <4CD7BB3F.1010304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Russell King <linux@arm.linux.org.uk>, Felipe Contreras <felipe.contreras@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Anna, Suman" <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Benoit,

On Mon, Nov 8, 2010 at 2:56 AM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
>> no, apart from the ordering of structure members, that I will change=
,
>
> If you do want to change a patch already submitted to loml, the least=
 you
> can do is to comment on the mailing list, and afaik, you didn't provi=
de any
> comment on this code.
> So do not change it without any explanation or any rational.
> That's the most basic rule of the patch submission / review process i=
n
> Linux.

I'm submitting my changes to review, I accept that I should have put
loudly an clear the reasons why the ordering was changing. I guess you
are the maintainer of the code, right? so if you say the ordering
standard is omap4 then I'm fine with such triviality.

>> since keeping the order of the original structure doesn't fly, I don=
't
>> see anything that needs to be changed.
>>
>> - The magic numbers replaced for the defines, afaik it gives more cl=
arity.
>
> No, since these are not magic numbers but physical address or dma num=
ber or
> irq channel.
> That does not give any more clarity to add a define, and in fact it a=
dds an
> extra level of indirection for nothing.
> The hwmod file is "the" unique HW definition files. So all the inform=
ation
> that used to be scattered all over various header files will have to =
be
> there.
> You should considered this file as a global SoC HW definition file.

Ok, I don't mind changing this too, I'm glad you clarify/review this
before more hwmods make it to the tree, following the same style I'm
using which is the one already there.

>> - mailbox irq has a name.
>
> Which is in the structure anyway, so again no need to add a define.

I didn't add a define for the irq name, I put the irq name because it
wasn't there.

> All the structure that are populated hrer are all unique to every IP,=
 so
> having that kind of assignment does not seems very useful to me.
>
> omap44xx_mailbox_irq =3D OMAP44XX_MAILBOX_IRQ;
>
> whereas that:
> omap44xx_mailbox_irq =3D 20;
>
> Give you a little be more information, because you do not have have t=
o read
> the TRM or another header file to get the real number.
>
> FYI, that was discussed at least 6 months ago during the submission o=
f the
> early hwmod series.
>
>> - overall defining block was improved:
>>
>> =A0 =A0 =A0 =A0 class
>> =A0 =A0 =A0 =A0 ocp_if
>> =A0 =A0 =A0 =A0 slave ports
>> =A0 =A0 =A0 =A0 hwmod
>>
>> If you see, each dependent reference is right before the structure
>> that is using it, which at least to me establishes some order, as of
>> today this ordering doesn't exists.
>>
>> e.g. you are defining some hwmod and some how you are populating all
>> the members, if you are looking at your omap_hwmod struct and want t=
o
>> see the irqs defined you need to scroll beyond the supposed first
>> reference in omap_hwmod (right now above ocp_if)
>
> So what? If you have any issue with the original order, please feel f=
ree to
> comment on the original patch.
> In case you didn't notice, all the OMAP4 data are following the same
> pattern. So any change to the structure should be applied everywhere.
>
> I do not have any issue to improve the overall readability if that ma=
ke
> sense for everybody, but again, please comment first.

Again, I should have sent an RFC explaining such changes. will do.

I feel commenting in the original patch is useless because this code
is already in-tree, it might have already changed.

>> <quote>
>> /*
>> =A0* 'mailbox' class
>> =A0* mailbox module allowing communication between the on-chip proce=
ssors
>> =A0* useusing a queued mailbox-interrupt mechanism.
>> =A0*/
>> </quote>
>>
>> I don't think it adds anything to the patch, should we start
>> commenting on the functionality of the drivers for each hwmod?
>
> In that case, it does not hurt since this file is the C file version =
of the
> TRM. You might not care because you know what that module is doing, b=
ut most
> people don't.

Ok, then.

>>>> +static struct omap_hwmod omap44xx_mailbox_hwmod;
>>>> +
>>>> +static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] =3D =
{
>>>> + =A0 =A0 =A0 {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D OMAP44XX_M=
AILBOX_BASE,
>>>
>>> If that physical address is not used elsewhere, and it should be th=
e
>>> case,
>>> there is no need to create a define for it. That's why the physical
>>> address
>>> was directly used here.
>>> There is no added value to create a define for that.
>>
>> yes there is, apart from readability where '0x4a0f4000' doesn't say =
much
>
> It says everything... when you use a debugger, what kind of informati=
on
> OMAP44XX_MAILBOX_BASE will give you? Nothing, you will have to check =
again
> the TRM or the define to get the real useful information.

Why is that? if you use a debugger you will see the address, if you
use an objdump you can easily traverse to the definition (with cscope,
ctags...). Again, I don't mind placing the hex number there, now that
there is an explanation for doing so.

Overall, I feel the lack of information made the code look as it is
right now for the existing LO hwmods, given that it is also a matter
of ordering stuff it should be pretty straight forward. I'll give you
my proposal offline, if you think it makes sense we can send it to LO
and avoid traffic of non-technical stuff.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

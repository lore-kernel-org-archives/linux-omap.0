From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: dspbridge and the omapl1x
Date: Wed, 11 Aug 2010 18:35:41 -0500
Message-ID: <AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
	<AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
	<AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41305 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391Ab0HKXfn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 19:35:43 -0400
Received: by ywh1 with SMTP id 1so193613ywh.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 16:35:42 -0700 (PDT)
In-Reply-To: <AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: ErnestoRamos <ernesto@ti.com>, ArmandoUribe <x0095078@ti.com>, NishanthMenon <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, ReneSapiens <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, OmarRamirezLuna <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, "Uppal, Deepali" <deepali@ti.com>

Ben,

On Wed, Aug 11, 2010 at 2:25 PM, Ben Gardiner
<bengardiner@nanometrics.ca> wrote:
> Hello Hari,
>
> On Wed, Aug 11, 2010 at 12:55 PM, Hari Kanigeri <hari.kanigeri@gmail.=
com> wrote:
>> Ben,
>>
>>> Yes, dynamic memory management. With DSP Link on the OMAPL138 the
>>> memory allocated to the DSP must be specified as a 'hole' in Linux
>>> memory at boot-time [1[2][3]. It seems (perhaps this is wishful
>>> thinking) that dspbridge does not have this limitation.
>>
>> DSPBridge doesn't has this requirement.
>
> Thank you for confirming.
>
>>> Also dynamic application loading. With DSP Link it is possible to r=
un
>>> multiple linux processes concurrently communicating with DSP tasks =
but
>>> the image loaded and executed on the DSP side must contain the code
>>> for all of the tasks at load time [4]. It seems that dspbridge does
>>> not have this limitation.
>>>
>>> I am very interested in learning details about both dsplink and
>>> dspbridge; please reply with more details or corrections as you see
>>> fit.
>>
>> DSPBridge and DSPLink IPCs are for 2 different purposes. So before y=
ou
>> make a switch to one of the IPC, I would recommend to you to make su=
re
>> your requirements are met.
>> To check the differences between DSPBridge and DSPLink, please check
>> this email thread contributed by Richard W.
>> http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/0098=
50.html.
>
> Good point. Thank you for making that clear to me. And for the link t=
o
> the post, I'm regret that I missed that in my initial research.

No problem.

> I'm
> starting to think that maybe a direct comparison between DSPLink and
> dspbridge is not a fair one.
>
Yes, as you mentioned in your earlier email it's not Apples to Apples
comparison.

>> We are working on making some of core functionalities such as DMM,
>> resource Management, =A0reset Management of co-processors generic fo=
r
>> any IPC to use. So if DSPLink is missing DMM functionality then it
>> should be just the matter of DSPLink adapting to this.
>
> I don't get what you're trying to say here, sorry. Would DSPLink be
> one of the IPCs for which the 'core functionalities' could be adapted=
?

May be let's re-visit this point when the RFC is send on my above
mentioned features.

> Could you explain an example of how DMM being made generic for any IP=
C
> to use could be applied to DSPLink?

Basically today the Dynamic memory management is handled by DSPBridge.
So the userspace clients talk to DSPBridge, and DSPBridge in turn
talks to IOMMU to map the user passed Buffers. DSPBridge is managing
the virtual address space of DSP in this case.
So basically where we are going is replacing DSPBridge's DMM module
with a generic Kernel module that can handle the DMM for any given
number of Co-Processors. OMAP3 has only Co-Processor, where as OMAP4
has 2 Co-Processors. The solution should be generic to handle any
number of Devices.
I will try to send an RFC of this implementation and I would love to
get feedback from you.

In case if you want to get some information on how the Dynamic memory
mapping works, you can refer pages 12-15 of this presentation
https://gforge.ti.com/gf/download/docmanfileversion/17/674/OMAP3430_Bri=
dge_overview.pdf

>
>> I am not aware of the official word from T.I to support dspbridge on
>> OMAP1, but as the community you will have the support in case you wa=
nt
>> to go with dspbridge option.
>>
>> On a high level, this is what needs to be done to provide support fo=
r OMAP1.
>>
>> 1. Adapt to iommu. Add support if the support is not present for OMA=
P1.
>>
>> 2. Adapt to mailbox
>>
>> 3. Reset and Power management adaptation for OMAP1.
>
> Thanks for the roadmap. This doesn't sound too daunting, but that
> could be because I am ignorant of the details. :)

I forgot to add item 4. "Surprises" :)


>
> I'm still not sure about the iommu features required by dspbridge, I
> will need to look into this. But 2+3 sound like they could be provide=
d
> by DSPLink itself. Would it be sane to put dspbridge on top of
> DSPLink? Just to sound it out, the DSP-side base image could be
> DSPBios + DSPLink (DSP-side) and the ARM-side would be made of
> dspbridge where the IPC is DSP Link 'compatible'. This could avoid a
> rewrite of the DSP-side of dspbridge maybe?

Probably over-kill to get the features you want.

>

Thank youi,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

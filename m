From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: dspbridge and the omapl1x
Date: Thu, 12 Aug 2010 10:08:54 -0400
Message-ID: <AANLkTikpKWxfSEgJLx3v5Q7kEwkgAyvU_76vRGbnCjZQ@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
	<AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
	<AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
	<AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33785 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab0HLOI5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 10:08:57 -0400
Received: by wyb32 with SMTP id 32so1434123wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 07:08:56 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>, "Kamoolkar, Mugdha" <mugdha@ti.com>
Cc: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, "Menon, Nishanth" <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Uppal, Deepali" <deepali@ti.com>

Hari and Mugdha,

On Wed, Aug 11, 2010 at 7:35 PM, Hari Kanigeri <hari.kanigeri@gmail.com=
> wrote:
> On Wed, Aug 11, 2010 at 2:25 PM, Ben Gardiner
> <bengardiner@nanometrics.ca> wrote:
>> On Wed, Aug 11, 2010 at 12:55 PM, Hari Kanigeri <hari.kanigeri@gmail=
=2Ecom> wrote:
>>> We are working on making some of core functionalities such as DMM,
>>> resource Management,  reset Management of co-processors generic for
>>> any IPC to use. So if DSPLink is missing DMM functionality then it
>>> should be just the matter of DSPLink adapting to this.
>>
>> I don't get what you're trying to say here, sorry. Would DSPLink be
>> one of the IPCs for which the 'core functionalities' could be adapte=
d?
>
> May be let's re-visit this point when the RFC is send on my above
> mentioned features.
>
>> Could you explain an example of how DMM being made generic for any I=
PC
>> to use could be applied to DSPLink?
>
> Basically today the Dynamic memory management is handled by DSPBridge=
=2E
> So the userspace clients talk to DSPBridge, and DSPBridge in turn
> talks to IOMMU to map the user passed Buffers. DSPBridge is managing
> the virtual address space of DSP in this case.
> So basically where we are going is replacing DSPBridge's DMM module
> with a generic Kernel module that can handle the DMM for any given
> number of Co-Processors. OMAP3 has only Co-Processor, where as OMAP4
> has 2 Co-Processors. The solution should be generic to handle any
> number of Devices.
> I will try to send an RFC of this implementation and I would love to
> get feedback from you.

I would be happy to review the RFC.

> In case if you want to get some information on how the Dynamic memory
> mapping works, you can refer pages 12-15 of this presentation
> https://gforge.ti.com/gf/download/docmanfileversion/17/674/OMAP3430_B=
ridge_overview.pdf

Thank you for the link; the diagram on page 13 was most helpful in
solidifying my understanding of the IOMMU to which your are referring
in your explanation of DMM above and in the roadmap below.

>>> On a high level, this is what needs to be done to provide support f=
or OMAP1.
>>>
>>> 1. Adapt to iommu. Add support if the support is not present for OM=
AP1.

Gulp. This could be a problem. Thanks to your link above I now
understand that the iommu which is controlled by dspbridge and
facilitates the use by the DSP of scattered pages allocated on the ARM
side is an MMU _separate_ from that of the ARM.

The OMAP3430 obviously has an MMU for the DSP Side [1] but I can't
find any documentation indicating that the OMAP L138 has a DSP-side
MMU.

On Thu, Aug 12, 2010 at 2:16 AM, Kamoolkar, Mugdha <mugdha@ti.com> wrot=
e:
> One thing I would like to mention is that the DMM feature does requir=
e the slave DSP to have an MMU. The OMAPL1xx devices do not have MMU fo=
r the DSP. DMM cannot be implemented without the DSP having an MMU. Hen=
ce, even if you ported DSPBridge to OMAPL1xx devices, you could not mak=
e use of the DMM feature.

 Thank you, Mugdha, for reading my mind and confirming that there is
no MMU on the omapL1x -- I saved a draft of this email last night and
was going to do some more research to confirm myself but you saved me
the trouble.

On Thu, Aug 12, 2010 at 2:16 AM, Kamoolkar, Mugdha <mugdha@ti.com> wrot=
e:
> You are correct that dynamic linking and loading is a feature that is=
 available in DSPBridge, and which is missing in DSPLink, which could w=
ork on OMAPL1xx if you ported DSPBridge to OMAPL1xx

I imagined that the lack of MMU would be a blocker in porting
dspbridge since it would be impossible to support scattered (in PAs)
pages on the DSP-side. But Mugdha makes it sound like the port could
be accomplished with DMM omitted.

Also I believe that the new Contiguous Memory Allocation (CMA)
framework was developed specifically for systems that need to allocate
physically contiguous memory because they don't have an MMU. What
would say to avoiding the IOMMU requirement and keeping DMM by using
physically contiguous dynamically allocated memory regions like those
provided by the new CMA [2]?

On Wed, Aug 11, 2010 at 7:35 PM, Hari Kanigeri <hari.kanigeri@gmail.com=
> wrote:
>>> 2. Adapt to mailbox
On Thu, Aug 12, 2010 at 2:16 AM, Kamoolkar, Mugdha <mugdha@ti.com> wrot=
e:
> Also, OMAPL1xx devices do not use mailbox interrupts. They have a dif=
ferent type of IPC interrupt, which is not mailbox. So a different kind=
 of abstraction would be required to be able to use either mailbox or t=
his different IPC interrupt.

Good point. I believe that currently it is DSPLink which provides a
mailbox implemented on top of the available IPC interrupt on the L13x.
If re-using DSPLink in the dspbridge's baseimage is still overkill
then we at least have code in DSPLink from which to base the
standalone driver code.

On Wed, Aug 11, 2010 at 7:35 PM, Hari Kanigeri <hari.kanigeri@gmail.com=
> wrote:
>>> 3. Reset and Power management adaptation for OMAP1.
>>
>> Thanks for the roadmap. This doesn't sound too daunting, but that
>> could be because I am ignorant of the details. :)
>
> I forgot to add item 4. "Surprises" :)

:) I think we ran into a big one.

Best Regards,
Ben Gardiner

[1] http://www.ti.com/litv/pdf/sprufn0a
[2] http://mid.gmane.org/cover.1281100495.git.m.nazarewicz@samsung.com
---
Nanometrics Inc.
http://www.nanometrics.ca





>> >>>
>> >>> I am very interested in learning details about both dsplink and
>> >>> dspbridge; please reply with more details or corrections as you =
see
>> >>> fit.
>> >>
>> >> DSPBridge and DSPLink IPCs are for 2 different purposes. So befor=
e you
>> >> make a switch to one of the IPC, I would recommend to you to make=
 sure
>> >> your requirements are met.
>> >> To check the differences between DSPBridge and DSPLink, please ch=
eck
>> >> this email thread contributed by Richard W.
>> >> http://linux.omap.com/pipermail/linux-omap-open-source/2007-
>> May/009850.html.
>> >
>> > Good point. Thank you for making that clear to me. And for the lin=
k to
>> > the post, I'm regret that I missed that in my initial research.
>>
>> No problem.
>>
>> > I'm
>> > starting to think that maybe a direct comparison between DSPLink a=
nd
>> > dspbridge is not a fair one.
>> >
>> Yes, as you mentioned in your earlier email it's not Apples to Apple=
s
>> comparison.
>>
>> >> We are working on making some of core functionalities such as DMM=
,
>> >> resource Management, =A0reset Management of co-processors generic=
 for
>> >> any IPC to use. So if DSPLink is missing DMM functionality then i=
t
>> >> should be just the matter of DSPLink adapting to this.
>> >
>> > I don't get what you're trying to say here, sorry. Would DSPLink b=
e
>> > one of the IPCs for which the 'core functionalities' could be adap=
ted?
>>
>> May be let's re-visit this point when the RFC is send on my above
>> mentioned features.
>>
>> > Could you explain an example of how DMM being made generic for any=
 IPC
>> > to use could be applied to DSPLink?
>>
>> Basically today the Dynamic memory management is handled by DSPBridg=
e.
>> So the userspace clients talk to DSPBridge, and DSPBridge in turn
>> talks to IOMMU to map the user passed Buffers. DSPBridge is managing
>> the virtual address space of DSP in this case.
>> So basically where we are going is replacing DSPBridge's DMM module
>> with a generic Kernel module that can handle the DMM for any given
>> number of Co-Processors. OMAP3 has only Co-Processor, where as OMAP4
>> has 2 Co-Processors. The solution should be generic to handle any
>> number of Devices.
>> I will try to send an RFC of this implementation and I would love to
>> get feedback from you.
>>
>> In case if you want to get some information on how the Dynamic memor=
y
>> mapping works, you can refer pages 12-15 of this presentation
>> https://gforge.ti.com/gf/download/docmanfileversion/17/674/OMAP3430_=
Bridge
>> _overview.pdf
>>
>> >
>> >> I am not aware of the official word from T.I to support dspbridge=
 on
>> >> OMAP1, but as the community you will have the support in case you=
 want
>> >> to go with dspbridge option.
>> >>
>> >> On a high level, this is what needs to be done to provide support=
 for
>> OMAP1.
>> >>
>> >> 1. Adapt to iommu. Add support if the support is not present for =
OMAP1.
>> >>
>> >> 2. Adapt to mailbox
>> >>
>> >> 3. Reset and Power management adaptation for OMAP1.
>> >
>> > Thanks for the roadmap. This doesn't sound too daunting, but that
>> > could be because I am ignorant of the details. :)
>>
>> I forgot to add item 4. "Surprises" :)
>>
>>
>> >
>> > I'm still not sure about the iommu features required by dspbridge,=
 I
>> > will need to look into this. But 2+3 sound like they could be prov=
ided
>> > by DSPLink itself. Would it be sane to put dspbridge on top of
>> > DSPLink? Just to sound it out, the DSP-side base image could be
>> > DSPBios + DSPLink (DSP-side) and the ARM-side would be made of
>> > dspbridge where the IPC is DSP Link 'compatible'. This could avoid=
 a
>> > rewrite of the DSP-side of dspbridge maybe?
>>
>> Probably over-kill to get the features you want.

>
>>
>> >
>>
>> Thank youi,
>> Best regards,
>> Hari
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> Regards,
> Mugdha
>



--=20
Best Regards,
Ben Gardiner

---
Nanometrics Inc.
+1 (613) 592-6776 x239
http://www.nanometrics.ca
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "Kamoolkar, Mugdha" <mugdha@ti.com>
Subject: RE: dspbridge and the omapl1x
Date: Thu, 12 Aug 2010 11:46:23 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
	<AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
	<AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
 <AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60313 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758637Ab0HLGQd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 02:16:33 -0400
In-Reply-To: <AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>
Cc: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, "Menon, Nishanth" <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Uppal, Deepali" <deepali@ti.com>

Ben,

Re-replying with Netiquette ... I apologize for my earlier e-mail.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Hari Kanigeri
> Sent: Thursday, August 12, 2010 5:06 AM
> To: Ben Gardiner
> Cc: Ramos Falcon, Ernesto; Uribe de Leon, Armando; Menon, Nishanth;
> KulikovVasiliy; Sapiens, Rene; AndyShevchenko; FelipeContreras; Ramir=
ez
> Luna, Omar; OhadBen-Cohen; linux-omap@vger.kernel.org; Uppal, Deepali
> Subject: Re: dspbridge and the omapl1x
>=20
> Ben,
>=20
> On Wed, Aug 11, 2010 at 2:25 PM, Ben Gardiner
> <bengardiner@nanometrics.ca> wrote:
> > Hello Hari,
> >
> > On Wed, Aug 11, 2010 at 12:55 PM, Hari Kanigeri
> <hari.kanigeri@gmail.com> wrote:
> >> Ben,
> >>
> >>> Yes, dynamic memory management. With DSP Link on the OMAPL138 the
> >>> memory allocated to the DSP must be specified as a 'hole' in Linu=
x
> >>> memory at boot-time [1[2][3]. It seems (perhaps this is wishful
> >>> thinking) that dspbridge does not have this limitation.
> >>
> >> DSPBridge doesn't has this requirement.
> >
> > Thank you for confirming.
One thing I would like to mention is that the DMM feature does require =
the slave DSP to have an MMU. The OMAPL1xx devices do not have MMU for =
the DSP. DMM cannot be implemented without the DSP having an MMU. Hence=
, even if you ported DSPBridge to OMAPL1xx devices, you could not make =
use of the DMM feature.
> >
> >>> Also dynamic application loading. With DSP Link it is possible to=
 run
> >>> multiple linux processes concurrently communicating with DSP task=
s but
> >>> the image loaded and executed on the DSP side must contain the co=
de
> >>> for all of the tasks at load time [4]. It seems that dspbridge do=
es
> >>> not have this limitation.
You are correct that dynamic linking and loading is a feature that is a=
vailable in DSPBridge, and which is missing in DSPLink, which could wor=
k on OMAPL1xx if you ported DSPBridge to OMAPL1xx
> >>>
> >>> I am very interested in learning details about both dsplink and
> >>> dspbridge; please reply with more details or corrections as you s=
ee
> >>> fit.
> >>
> >> DSPBridge and DSPLink IPCs are for 2 different purposes. So before=
 you
> >> make a switch to one of the IPC, I would recommend to you to make =
sure
> >> your requirements are met.
> >> To check the differences between DSPBridge and DSPLink, please che=
ck
> >> this email thread contributed by Richard W.
> >> http://linux.omap.com/pipermail/linux-omap-open-source/2007-
> May/009850.html.
> >
> > Good point. Thank you for making that clear to me. And for the link=
 to
> > the post, I'm regret that I missed that in my initial research.
>=20
> No problem.
>=20
> > I'm
> > starting to think that maybe a direct comparison between DSPLink an=
d
> > dspbridge is not a fair one.
> >
> Yes, as you mentioned in your earlier email it's not Apples to Apples
> comparison.
>=20
> >> We are working on making some of core functionalities such as DMM,
> >> resource Management, =A0reset Management of co-processors generic =
for
> >> any IPC to use. So if DSPLink is missing DMM functionality then it
> >> should be just the matter of DSPLink adapting to this.
> >
> > I don't get what you're trying to say here, sorry. Would DSPLink be
> > one of the IPCs for which the 'core functionalities' could be adapt=
ed?
>=20
> May be let's re-visit this point when the RFC is send on my above
> mentioned features.
>=20
> > Could you explain an example of how DMM being made generic for any =
IPC
> > to use could be applied to DSPLink?
>=20
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
>=20
> In case if you want to get some information on how the Dynamic memory
> mapping works, you can refer pages 12-15 of this presentation
> https://gforge.ti.com/gf/download/docmanfileversion/17/674/OMAP3430_B=
ridge
> _overview.pdf
>=20
> >
> >> I am not aware of the official word from T.I to support dspbridge =
on
> >> OMAP1, but as the community you will have the support in case you =
want
> >> to go with dspbridge option.
> >>
> >> On a high level, this is what needs to be done to provide support =
for
> OMAP1.
> >>
> >> 1. Adapt to iommu. Add support if the support is not present for O=
MAP1.
> >>
> >> 2. Adapt to mailbox
> >>
> >> 3. Reset and Power management adaptation for OMAP1.
> >
> > Thanks for the roadmap. This doesn't sound too daunting, but that
> > could be because I am ignorant of the details. :)
>=20
> I forgot to add item 4. "Surprises" :)
>=20
>=20
> >
> > I'm still not sure about the iommu features required by dspbridge, =
I
> > will need to look into this. But 2+3 sound like they could be provi=
ded
> > by DSPLink itself. Would it be sane to put dspbridge on top of
> > DSPLink? Just to sound it out, the DSP-side base image could be
> > DSPBios + DSPLink (DSP-side) and the ARM-side would be made of
> > dspbridge where the IPC is DSP Link 'compatible'. This could avoid =
a
> > rewrite of the DSP-side of dspbridge maybe?
>=20
> Probably over-kill to get the features you want.
iommu could not be adapted for OMAPL1xx since it abstracts the DSP MMU,=
 which is non-existent on OMAPL1xx devices.

Also, OMAPL1xx devices do not use mailbox interrupts. They have a diffe=
rent type of IPC interrupt, which is not mailbox. So a different kind o=
f abstraction would be required to be able to use either mailbox or thi=
s different IPC interrupt.

>=20
> >
>=20
> Thank youi,
> Best regards,
> Hari
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Mugdha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: dspbridge and the omapl1x
Date: Thu, 12 Aug 2010 08:40:07 -0500
Message-ID: <AANLkTikA0a2s4Vkq1PYFo_bsA4vWkCgKR6foFDj8x-Wj@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
	<AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
	<AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
	<AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50333 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab0HLNkI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 09:40:08 -0400
Received: by ywh1 with SMTP id 1so390019ywh.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 06:40:08 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kamoolkar, Mugdha" <mugdha@ti.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, "Menon, Nishanth" <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Uppal, Deepali" <deepali@ti.com>

Mugdha,

On Thu, Aug 12, 2010 at 1:16 AM, Kamoolkar, Mugdha <mugdha@ti.com> wrote:
> Ben,
>
>>
>>
>> >
>> > I'm still not sure about the iommu features required by dspbridge, I
>> > will need to look into this. But 2+3 sound like they could be provided
>> > by DSPLink itself. Would it be sane to put dspbridge on top of
>> > DSPLink? Just to sound it out, the DSP-side base image could be
>> > DSPBios + DSPLink (DSP-side) and the ARM-side would be made of
>> > dspbridge where the IPC is DSP Link 'compatible'. This could avoid a
>> > rewrite of the DSP-side of dspbridge maybe?
>>
>> Probably over-kill to get the features you want.
> iommu could not be adapted for OMAPL1xx since it abstracts the DSP MMU, which is non-existent on OMAPL1xx devices.
>
> Also, OMAPL1xx devices do not use mailbox interrupts. They have a different type of IPC interrupt, which is not mailbox. So a different kind of abstraction would be required to be able to use either mailbox or this different IPC interrupt.

Thanks for providing information on OMAPL1xx devices. I wasn't aware
of OMAP1 architecture.

Thank you,
Best regards,
Hari

From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: dspbridge and the omapl1x
Date: Thu, 12 Aug 2010 18:28:22 -0600
Message-ID: <AANLkTimzLZKn3nUT2=nFAzLzyzuhUVz=Y9h5ciqTu90h@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
	<AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
	<AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
	<AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
	<AANLkTikpKWxfSEgJLx3v5Q7kEwkgAyvU_76vRGbnCjZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56509 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607Ab0HMA2X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 20:28:23 -0400
Received: by gxk23 with SMTP id 23so672682gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 17:28:22 -0700 (PDT)
In-Reply-To: <AANLkTikpKWxfSEgJLx3v5Q7kEwkgAyvU_76vRGbnCjZQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: "Kamoolkar, Mugdha" <mugdha@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, "Menon, Nishanth" <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Uppal, Deepali" <deepali@ti.com>

> On Thu, Aug 12, 2010 at 2:16 AM, Kamoolkar, Mugdha <mugdha@ti.com> wrote:
>> You are correct that dynamic linking and loading is a feature that is available in DSPBridge, and which is missing in DSPLink, which could work on OMAPL1xx if you ported DSPBridge to OMAPL1xx
>
> I imagined that the lack of MMU would be a blocker in porting
> dspbridge since it would be impossible to support scattered (in PAs)
> pages on the DSP-side. But Mugdha makes it sound like the port could
> be accomplished with DMM omitted.
>
> Also I believe that the new Contiguous Memory Allocation (CMA)
> framework was developed specifically for systems that need to allocate
> physically contiguous memory because they don't have an MMU. What
> would say to avoiding the IOMMU requirement and keeping DMM by using
> physically contiguous dynamically allocated memory regions like those
> provided by the new CMA [2]?
>

Just curious as how CMA is different from Android's pmem.

>

Thank you,
Best regards,
Hari

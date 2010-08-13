From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: dspbridge and the omapl1x
Date: Fri, 13 Aug 2010 09:44:18 -0400
Message-ID: <AANLkTima8UM7JpWHynHWFL+8X=FejBj_SptUe6MwRhei@mail.gmail.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
	<AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
	<AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
	<AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
	<AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
	<AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E80ACF17@dbde02.ent.ti.com>
	<AANLkTikpKWxfSEgJLx3v5Q7kEwkgAyvU_76vRGbnCjZQ@mail.gmail.com>
	<AANLkTimzLZKn3nUT2=nFAzLzyzuhUVz=Y9h5ciqTu90h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61346 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab0HMNoT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 09:44:19 -0400
Received: by wyb32 with SMTP id 32so2646425wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Aug 2010 06:44:18 -0700 (PDT)
In-Reply-To: <AANLkTimzLZKn3nUT2=nFAzLzyzuhUVz=Y9h5ciqTu90h@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <hari.kanigeri@gmail.com>
Cc: "Kamoolkar, Mugdha" <mugdha@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, "Menon, Nishanth" <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Uppal, Deepali" <deepali@ti.com>

On Thu, Aug 12, 2010 at 8:28 PM, Hari Kanigeri <hari.kanigeri@gmail.com> wrote:
>> Also I believe that the new Contiguous Memory Allocation (CMA)
>> framework was developed specifically for systems that need to allocate
>> physically contiguous memory because they don't have an MMU. What
(edit) "... because they don't have an _IO_MMU."

>> would say to avoiding the IOMMU requirement and keeping DMM by using
>> physically contiguous dynamically allocated memory regions like those
>> provided by the new CMA [2]?
>>
>
> Just curious as how CMA is different from Android's pmem.

I'm not really sure, but based on the discussion in one of the pmem
patches proposed on lkml [1] they seem to provide similar
functionality.

Perhaps the difference is that pmem has made it to staging whereas CMA
is only a proposed feature so far?

Best Regards,
Ben Gardiner

[1] https://patchwork.kernel.org/patch/47513/

---
Nanometrics Inc.
http://www.nanometrics.ca

From: "Kamoolkar, Mugdha" <mugdha@ti.com>
Subject: RE: dspbridge and the omapl1x
Date: Thu, 12 Aug 2010 11:37:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E80ACEFC@dbde02.ent.ti.com>
References: <AANLkTin7MAdSUmyja5=tp8TP+2mS53++yJT5T6+K27Lp@mail.gmail.com>
 <AANLkTinYLLf4a9p_zFfPZ5s_+-NbNi+zn8UO0G-=i1CK@mail.gmail.com>
 <AANLkTimDnC=BRtdGRGStYj-7XX8ZtehZvY6eK-v-6O5-@mail.gmail.com>
 <AANLkTinyg1+FMLBDgMTpfOK2iy=yzGqsd1XA+xsZ9sse@mail.gmail.com>
 <AANLkTincmfyydjQxsyAR_od13O15Oimyr5QBd-9gCess@mail.gmail.com>
 <AANLkTikVNhNRki4UoJEK2W4mjS2K64gBEvQxYn8BOyY1@mail.gmail.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E80ACEDB@dbde02.ent.ti.com>
 <20100812060250.GC23362@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41221 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353Ab0HLGHo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 02:07:44 -0400
In-Reply-To: <20100812060250.GC23362@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: Hari Kanigeri <hari.kanigeri@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "Uribe de Leon, Armando" <x0095078@ti.com>, "Menon, Nishanth" <nm@ti.com>, KulikovVasiliy <segooon@gmail.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, AndyShevchenko <andy.shevchenko@gmail.com>, FelipeContreras <felipe.contreras@gmail.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, OhadBen-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Uppal, Deepali" <deepali@ti.com>

Felipe,

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Thursday, August 12, 2010 11:33 AM
> To: Kamoolkar, Mugdha
> Cc: Hari Kanigeri; Ben Gardiner; Ramos Falcon, Ernesto; Uribe de Leon,
> Armando; Menon, Nishanth; KulikovVasiliy; Sapiens, Rene; AndyShevchenko;
> FelipeContreras; Ramirez Luna, Omar; OhadBen-Cohen; linux-
> omap@vger.kernel.org; Uppal, Deepali
> Subject: Re: dspbridge and the omapl1x
> 
> Hi,
> 
> On Thu, Aug 12, 2010 at 08:00:05AM +0200, ext Kamoolkar, Mugdha wrote:
> >One thing I would like to mention is that the DMM feature does require
> >the slave DSP to have an MMU. The OMAPL1xx devices do not have MMU for
> >the DSP. DMM cannot be implemented without the DSP having an MMU.
> >Hence, even if you ported DSPBridge to OMAPL1xx devices, you could not
> >make use of the DMM feature.
> >
> >However, you are correct that dynamic linking and loading is a feature
> >that is available in DSPBridge, and which is missing in DSPLink, which
> >could work on OMAPL1xx if you ported DSPBridge to OMAPL1xx
> 
> please follow the Netiquette [1]. It's really difficult to follow
> dspbridge threads.
> 
> [1] http://www.elinux.org/Netiquette
> 

Thanks! Live and learn ...

> --
> balbi
> 
> DefectiveByDesign.org

Regards,
Mugdha

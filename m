From: "Marathe, Yogesh" <yogesh_marathe@ti.com>
Subject: RE: [PATCH 05/11] omap3: Remove non-existent config option
Date: Wed, 29 Sep 2010 18:58:27 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234006B4C@dbde02.ent.ti.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
	<AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
	<AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
 <AANLkTimD_MRbuTnBMPzAKPTmrDwjLkLVmr9bTSNROb5L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58042 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374Ab0I2N2h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 09:28:37 -0400
In-Reply-To: <AANLkTimD_MRbuTnBMPzAKPTmrDwjLkLVmr9bTSNROb5L@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Wednesday, September 29, 2010 5:05 PM
> To: Kanigeri, Hari
> Cc: Marathe, Yogesh; Premi, Sanjeev; Tony Lindgren; linux-arm-
> kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 05/11] omap3: Remove non-existent config
> option
> 
> Hi Hari,
> 
> On Mon, Sep 27, 2010 at 7:28 PM, Kanigeri, Hari <h-
> kanigeri2@ti.com> wrote:
> > Yogesh is coming from dsplink requirement to use iommu. I see his
> comment as why Bridge requirement should be imposed on other IPCs
> that need iommu.
> 
> Ahh, that explains a lot. However, dsp-link can just enable
> CONFIG_MPU_BRIDGE_IOMMU, and that's it, right? Perhaps it would
> make
> sense to rename to CONFIG_OMAP_IOMMU_IVA2, or something like
> that. But
> not remove it and break tidspbridge, which is already in staging.
> 
> Once both are working happily with CONFIG_OMAP_IOMMU_IVA2 on,
> _then_
> it can be removed.
> 
> --
> Felipe Contreras

Felipe,

dsplink and syslink (two drivers who use iommu) should not enable
CONFIG_MPU_BRIDGE_IOMMU as dspbridge and dsplink /syslink 
can not co-exist as they are using same resources. Not applying patch
breaks dsplink/sylink any one which is being used. Defining this config
makes them co-exist. 

I'm ok with changing name to CONFIG_OMAP_IOMMU_IVA2 but ideally
then that will also break the dspbridge. 

One more way would be to soure revert the patch and apply on dspbridge branch if it breaks the builds on that branch rather than
breaking others in master.

Regards,
Yogesh.

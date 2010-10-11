From: "Marathe, Yogesh" <yogesh_marathe@ti.com>
Subject: RE: [PATCH 05/11] omap3: Remove non-existent config option
Date: Mon, 11 Oct 2010 10:40:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302342AE66C@dbde02.ent.ti.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
	<AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
	<AANLkTim9Y3i7M9Jjo6RZs7zMNVZUkFm1P7P=h0y2J=Nj@mail.gmail.com>
	<8F7AF80515AF0D4D93307E594F3CB40E5F6A365B@dlee03.ent.ti.com>
	<AANLkTimD_MRbuTnBMPzAKPTmrDwjLkLVmr9bTSNROb5L@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930234006B4C@dbde02.ent.ti.com>
	<AANLkTinZqx2nFuoYoCYpD4+PG7_J=ACLBxAwOvpVm4c9@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB593023412B2C1@dbde02.ent.ti.com>
	<496565EC904933469F292DDA3F1663E602F471C1BF@dlee06.ent.ti.com>
 <AANLkTim=1dXg8O_q-RLZEjrVvN+Bb2DV1N1jwNjVBw3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33039 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab0JKFKu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 01:10:50 -0400
In-Reply-To: <AANLkTim=1dXg8O_q-RLZEjrVvN+Bb2DV1N1jwNjVBw3a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Sunday, October 10, 2010 7:38 PM
> To: Guzman Lugo, Fernando
> Cc: Marathe, Yogesh; Kanigeri, Hari; Premi, Sanjeev; Tony Lindgren;
> linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 05/11] omap3: Remove non-existent config
> option
> 
> On Wed, Oct 6, 2010 at 3:14 AM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
> > Can I know the status of this patch?
> >
> > This patch is needed now that tidspbridge has migrated to use
> > Iommu moudle.
> >
> > Will this patch be merged?
> 
> This patch hasn't even been sent yet. I expected somebody else to try
> it and do so.

Felipe,

I think Fernando is talking about the patch that I had sent at the
beginning. I had replied Fernando saying it is under discussion as
you were looking at other iommu patches.

If we have agreed upon having CONFIG_OMAP_IOMMU_IVA2 available 
"by default" I have no problem to try your patch else the original patch 
that I had sent should be reconsidered.

Regards,
Yogesh.
 
> Anyway, I'm now trying iommu myself and will send this patch when I
> get the dsp working.
> 
> --
> Felipe Contreras



From: "Marathe, Yogesh" <yogesh_marathe@ti.com>
Subject: RE: [PATCH 05/11] omap3: Remove non-existent config option
Date: Wed, 6 Oct 2010 14:01:48 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930234204D03@dbde02.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59593 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932184Ab0JFIcC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 04:32:02 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602F471C1BF@dlee06.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Guzman Lugo, Fernando
> Sent: Wednesday, October 06, 2010 5:44 AM
> To: Marathe, Yogesh; Felipe Contreras
> Cc: Kanigeri, Hari; Premi, Sanjeev; Tony Lindgren; linux-arm-
> kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 05/11] omap3: Remove non-existent config
> option
> 
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Marathe,
> Yogesh
> > Sent: Friday, October 01, 2010 6:29 AM
> > To: Felipe Contreras
> > Cc: Kanigeri, Hari; Premi, Sanjeev; Tony Lindgren;
> > linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> > Subject: RE: [PATCH 05/11] omap3: Remove non-existent config
> option
> >
> > > -----Original Message-----
> > > From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> > > Sent: Thursday, September 30, 2010 12:42 AM
> > > To: Marathe, Yogesh
> > > Cc: Kanigeri, Hari; Premi, Sanjeev; Tony Lindgren; linux-arm-
> > > kernel@lists.infradead.org; linux-omap@vger.kernel.org
> > > Subject: Re: [PATCH 05/11] omap3: Remove non-existent config
> option
> > >
> > > On Wed, Sep 29, 2010 at 4:28 PM, Marathe, Yogesh
> > > <yogesh_marathe@ti.com> wrote:
> > > > dsplink and syslink (two drivers who use iommu) should not
> enable
> > > > CONFIG_MPU_BRIDGE_IOMMU as dspbridge and dsplink
> /syslink can not
> > > > co-exist as they are using same resources. Not applying
> > > patch
> > > > breaks dsplink/sylink any one which is being used. Defining this
> > > config
> > > > makes them co-exist.
> > >
> > > No, for dsp-link you would have:
> > > CONFIG_TIDSPBRIDGE=n
> > > CONFIG_OMAP_IOMMU_IVA2=y
> > >
> > > It would be exactly the same as applying your patch.
> > >
> > > And tidspbridge is not using iommu right now.
> >
> > I noticed that you have added OMAP_IOMMU_IVA2 to Kconfig. In
> > this case I need CONFIG_OMAP_IOMMU_IVA2=y by default on
> > master so that iommu is open to use for all other drivers by default.
> >
> > > And AFAIK syslink is not for omap3, so omap3_devices is not
> > relevant.
> > >
> > > > I'm ok with changing name to CONFIG_OMAP_IOMMU_IVA2
> but
> > > ideally
> > > > then that will also break the dspbridge.
> > >
> > > No, grep for MPU_BRIDGE_IOMMU on the current tidspbridge in
> > mainline;
> > > it's not defined anywhere, so CONFIG_OMAP_IOMMU_IVA2, or
> > > CONFIG_FOOBAR, it doesn't matter for tidspbridge right now. And
> > > MPU_BRIDGE_IOMMU doesn't depend on tidspbridge on any way.
> >
> > Please explain, how removing CONFIG_MPU_BRIDGE_IOMMU Or
> any
> > other the config name in place, breaks tidspbridge?
> > My patch is removing the 'if defined'.
> 
> Can I know the status of this patch?

I have been discussing this with Fernando. In his opinion we should have 
a Kconfig option and iommu user should explicitly set it to 'y' if they wish
to use it. I'm saying removal of this 'if defined' solves the problem which
is what you also want.

> 
> This patch is needed now that tidspbridge has migrated to use
> Iommu moudle.
> 
> Will this patch be merged?

I'm also waiting on this patch to get accepted.

> 
> Regards,
> Fernando.
> 
> >
> > >
> > > > One more way would be to soure revert the patch and apply on
> > > dspbridge branch if it breaks the builds on that branch rather than
> > > > breaking others in master.
> > >
> > > There is no tidspbrige branch; it's in mainline:
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> > > 2.6.git;a=tree;f=drivers/staging/tidspbridge
> > >
> > > But that doesn't matter, even if it was in a branch, iommu
> > should not
> > > break either tidspbridge, or dsp-link, and driver branches
> > should not
> > > modify anything outside their domain (ideally).
> > >
> > > All you need to do is 'select OMAP_IOMMU_IVA2', although
> > the attached
> > > patch would be needed.
> > >
> > > --
> > > Felipe Contreras
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-omap" in the body of a message to
> > majordomo@vger.kernel.org More majordomo info at
> > http://vger.kernel.org/majordomo-info.html
> >

Regards,
Yogesh.

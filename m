From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
Date: Wed, 12 Sep 2012 03:53:25 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB18F8@DBDE01.ent.ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com>
 <504F0877.4030907@ti.com>
 <alpine.DEB.2.00.1209112307170.9444@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55038 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab2ILDxe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 23:53:34 -0400
In-Reply-To: <alpine.DEB.2.00.1209112307170.9444@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Turquette, Mike" <mturquette@ti.com>

On Wed, Sep 12, 2012 at 04:40:51, Paul Walmsley wrote:
> On Tue, 11 Sep 2012, Vaibhav Hiremath wrote:
> 
> > I tried this branch on BeagleBone platform and needs one small typo
> > correction in hwmod data patch (submitted earlier, which you are going
> > to queue it)
> > 
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > index de7a3ab..767a77d 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> > @@ -1441,7 +1441,7 @@ static struct omap_hwmod am33xx_mmc2_hwmod = {
> >         .clkdm_name     = "l3s_clkdm",
> >         .mpu_irqs       = am33xx_mmc2_irqs,
> >         .sdma_reqs      = am33xx_mmc2_edma_reqs,
> > -       .main_clk       = "mmc2_fck",
> > +       .main_clk       = "mmc_clk",
> >         .prcm           = {
> >                 .omap4  = {
> >                       .clkctrl_offs = AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET,
> > 
> > 
> > With above change I boot tested it on BeagleBone platform and also
> > verified the clock rates getting printed in debugfs.
> 
> So does this mean we need to put together a patch to remove the existing 
> mmc2_fck first from the OMAP clock data file?  Looks like that would be 
> the right thing to do, based on the AM33x PRCM data.
> 

Yes, that's correct and it has been already removed from clock data file 
while migrating to common clock framework.

Thanks,
Vaibhav

> 
> - Paul
> 


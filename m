From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 1/4] OMAP3: hwmod data: add mmu data for iva and isp
Date: Sun, 25 Dec 2011 22:08:19 +0100
Message-ID: <201112252208.20148.laurent.pinchart@ideasonboard.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com> <CAMP44s2H7v6dRPXO6eBBNrYAnym_ZLdmKcAQPmYyCC6Wo5qOmw@mail.gmail.com> <CAB-zwWhNNW1GEYr019xecuZTYhR55HpNGrhGjJdE1CEAfFSriQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:45788 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab1LYVIX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Dec 2011 16:08:23 -0500
In-Reply-To: <CAB-zwWhNNW1GEYr019xecuZTYhR55HpNGrhGjJdE1CEAfFSriQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Omar,

On Friday 23 December 2011 16:53:58 Ramirez Luna, Omar wrote:
> On Mon, Dec 19, 2011 at 10:11 AM, Felipe Contreras wrote:
> > On Fri, Dec 16, 2011 at 4:01 AM, Ramirez Luna, Omar wrote:
> >> On Thu, Dec 15, 2011 at 6:39 PM, Felipe Contreras wrote:
> >>> Are you sure you are not missing something like:
> >>> 
> >>>  .clk = "cam_ick",
> >> 
> >> I believe in this case cam_ick is used as the main clock as it
> >> supplies both functional and interface.
> > 
> > Are you sure?
> 
> As sure as 4.7.4.1.7 CAM Power Domain ;), if someone else could
> clarify would be great to avoid the "are you sure" discussion.

I don't know where the ISP IOMMU fonctional and interface clocks come from, 
sorry. Shouldn't it be possible to find someone inside TI who can provide that 
information ? :-)

> >>>> +/* isp mmu slave ports */
> >>>> +static struct omap_hwmod_ocp_if *omap3xxx_isp_mmu_slaves[] = {
> >>>> +       &omap3xxx_l4_core__isp_mmu,
> >>>> +};
> >>>> +
> >>>> +static struct omap_hwmod omap3xxx_isp_mmu_hwmod = {
> >>>> +       .name           = "isp_mmu",
> >>>> +       .class          = &omap3xxx_mmu_hwmod_class,
> >>>> +       .mpu_irqs       = omap3xxx_isp_mmu_irqs,
> >>>> +       .main_clk       = "cam_ick",
> >>> 
> >>> It's not "cam_fck"?
> >> 
> >> AFAIK cam_fck doesn't exist in the code, and CAM_L3_ICK is used as
> >> both ick/fck according to TRM.
> > 
> > Then maybe the code is wrong.
> > 
> > Look at the OMAP34xx documentation, it says that:
> > 
> > CAM_L3_ICLK -> CAM_FCLK
> > CAM_L4_ICLK -> CAM_ICLK
> > CAM_MCLK -> CAM_MCLK
> > CSI2_96M_FCLK -> CSI2_96M_FCLK
> > 
> > CAM_FCLK
> > Functional clock (L3 interconnect clock domain)
> > Functional clock domain.
> > 
> > CAM_ICLK
> > Interface clock (L4 interconnect clock domain)
> > Interface clock domain.
> 
> "The camera subsystem interface is clocked with the L3 and L4 clocks
> (CAM_L3_ICLK and CAM_L4_ICLK, respectively). CAM_L3_ICLK is also used
> as the main functional clock. The functional clock (CAM_MCLK) is
> provided by DPLL4 to supply the external sensor."
> 
> Either CAM subsystem section or PRCM - CAM PWRDM is ambiguous or wrong.

I haven't checked how the clocks are used in details (I started working on the 
OMAP3 ISP driver after the clock handling code was in place), but I can at 
least confirm that CAM_L3_ICLK is the main functional clock. I would be a bit 
surprised if CAM_L3_ICLK was used as the interface clock as well.

Once again, you should be able to find clarification on this subject inside 
TI.

> ...
> 
> > Looks like the driver is manually calling clk_get() and clk_put() for
> > the "i3_ick", where I guess the clock framework is supposed to do
> > that... It's almost as if somebody forgot a dependency somewhere.
> 
> Would be good to clarify the intentions to keep the code as it is.

Once proper clock dependencies will be in place I'll be glad to remove the 
direct l3_ick if needed.

> >>>> +       .dev_attr       = &isp_mmu_dev_attr,
> >>>> +       .slaves         = omap3xxx_isp_mmu_slaves,
> >>>> +       .slaves_cnt     = ARRAY_SIZE(omap3xxx_isp_mmu_slaves),
> >>>> +       .flags          = HWMOD_NO_IDLEST,
> >>>> +};
> >>> 
> >>> Most of the stuff I see the hwmods is .main_lock = "foo_fck", slave
> >>> .clk = "foo_ick". Maybe that explains the irq issues you get.
> >> 
> >> I see irq issues with iva hwmod because tidspbridge doesn't use iommu
> >> API yet, so if you enable both the mmu hwmod and tidspbridge own mmu
> >> implementation there will be some conflicts.
> >> 
> >> I didn't see isp issues though, but I didn't went more than
> >> booting/enabling with isp mmu.
> > 
> > This is what you said:
> > Removed clk handling during interrupt, given that in order to receive
> > one, the device should be powered on in advance.
> 
> Yes, you should receive an interrupt if the clock is enabled and the
> iommu is being used, hence the part inside in the ISR to enable the
> clocks was removed.
> 
> > I'm not sure how this clock stuff works, but I'm guessing the device
> > is supposed to go to sleep at some points in time, and with your patch
> > "OMAP3/4: iommu: adapt to runtime pm" it won't, as long as the module
> > is loaded, unless I'm missing something.
> 
> The device should be able to be put to sleep at anytime when it is NOT
> being used. AFAIK there is no mechanism for the main processor (the
> one running the kernel) to know when the other iommus are not being
> used, given that they are in independent processors/subsystems, at
> least for the ones in the DSP or M3 processors. Once the user releases
> its iommu resource it means it is no longer using it, at that point
> the device can be put to sleep.

How should the OMAP3 ISP driver proceed to make sure that its IOMMU is clocked 
off when it doesn't need it ?

-- 
Regards,

Laurent Pinchart

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/1] omap3: Provide means for changing CSI2 PHY configuration
Date: Wed, 09 May 2012 16:08:01 +0200
Message-ID: <1895969.gXx5x6xbez@avalon>
References: <1336539641-28424-1-git-send-email-sakari.ailus@iki.fi> <1806533.kaSkiTLSjy@avalon> <20120509134308.GA3373@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:34518 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab2EIOIA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 10:08:00 -0400
In-Reply-To: <20120509134308.GA3373@valkosipuli.retiisi.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com

Hi Sakari,

On Wednesday 09 May 2012 16:43:08 Sakari Ailus wrote:
> On Wed, May 09, 2012 at 01:01:34PM +0200, Laurent Pinchart wrote:
> > On Wednesday 09 May 2012 08:00:41 Sakari Ailus wrote:
> > > The OMAP 3630 has configuration how the ISP CSI-2 PHY pins are connected
> > > to the actual CSI-2 receivers outside the ISP itself. Allow changing
> > > this configuration from the ISP driver.
> > > 
> > > Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > ---
> > > Hi,
> > > 
> > > This patch does what was discussed some time ago: provide a bit more
> > > high level interface than the registers for the ISP driver to change the
> > > CSI-2 PHY mappings.
> > > 
> > > omap_writel()/omap_readl() functions are no longer there so this works
> > > as a convenient push to write a patch such as this. ;-)
> > > 
> > >  arch/arm/mach-omap2/control.c              |   32 +++++++++++++++++++++
> > >  arch/arm/mach-omap2/include/mach/control.h |   11 +++++++++
> > >  2 files changed, 43 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/mach-omap2/include/mach/control.h

[snip]

> > > +void omap3_ctrl_csi2_select(u32 csi2cfg)
> > > +{
> > > +	/* FIXME: Do 34xx / 35xx require something here? */
> > 
> > Well, maybe it's time to find out whether it does ?
> 
> I'm not aware of anyone having a sensor with CSI-2 bus connected to a 3430;
> that's why this hasn't been found out. If we add the support we're at least
> going to be unable to test it. For that reason I was going to leave this
> as-is. What do you think?

I haven't seen any SCM register in the 3430 TRM related to CSI2 routing (most 
probably because the SoC seems to have the CSI1/CCP2 receiver hardwired to the 
CSIb block, and the CSI2 receiver hardwired to the CSIa block). If 34xx/35xx 
need something here, I don't know what.

What the 3430 would need is a ccp2 configuration function to access the 
CONTROL_CSIRXFE register.

> > > +	if (cpu_is_omap3630()) {
> > 
> > I would test !cpu_is_omap3630() and return, that would lower the
> > indentation level.
> 
> Now, yes. I'll do that if you agree with me on the previous question since
> otherwise this won't work too well. :)
> 
> > > +		u32 cam_phy_ctrl =
> > > +			omap_ctrl_readl(OMAP3630_CONTROL_CAMERA_PHY_CTRL);
> > > +
> > > +		/*
> > > +		 * SCM.CONTROL_CAMERA_PHY_CTRL
> > > +		 * - bit[4]    : CSIPHY1 data sent to CSIB
> > > +		 * - bit [3:2] : CSIPHY1 config: 00 d-phy, 01/10 ccp2
> > > +		 * - bit [1:0] : CSIPHY2 config: 00 d-phy, 01/10 ccp2
> > > +		 */
> > > +		if (csi2cfg == OMAP3_CTRL_CSI2_SELECT_PHY1_CCP2B)
> > > +			cam_phy_ctrl |= 1 << 2;
> > > +		else if (csi2cfg == OMAP3_CTRL_CSI2_SELECT_PHY1_CSI2C)
> > > +			cam_phy_ctrl &= ~(1 << 2);

Looking a bit more at the TRM, don't we need to provide a way to select 
between data/clock and data/strobe modes, and to select which PHY to connect 
to the ISP CSIb receiver ?

> > > +
> > > +		if (csi2cfg == OMAP3_CTRL_CSI2_SELECT_PHY2_CCP2B)
> > > +			cam_phy_ctrl |= 1;
> > > +		else if (csi2cfg == OMAP3_CTRL_CSI2_SELECT_PHY2_CSI2A)
> > > +			cam_phy_ctrl &= ~1;
> > > +
> > > +		omap_ctrl_writel(cam_phy_ctrl,
> > > +				 OMAP3630_CONTROL_CAMERA_PHY_CTRL);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(omap3_ctrl_csi2_select);

-- 
Regards,

Laurent Pinchart


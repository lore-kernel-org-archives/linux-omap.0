From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Tue, 13 Nov 2012 08:43:23 -0800
Message-ID: <20121113164323.20034.34462@nucleus>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
 <3718991.PIry3KaXBM@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52304 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754942Ab2KMQnr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 11:43:47 -0500
In-Reply-To: <3718991.PIry3KaXBM@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: paul@pwsan.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org

Quoting Laurent Pinchart (2012-11-13 05:42:35)
> Hi Mike,
> 
> Thank you for the patches.
> 
> On Wednesday 07 November 2012 17:12:35 Mike Turquette wrote:
> > From: Mike Turquette <mturquette@linaro.org>
> > 
> > Hi all,
> > 
> > This series is based on top of Paul's PRM/CM clean-up work.  It is a
> > refresh of the patches Rajendra sent out a while back[1], with the
> > addition of several fixes for PM regressions[2] across several
> > platforms.
> > 
> > I have tested on OMAP4430 Panda including PRCM diffing against pre-CCF
> > patches (delta is zero) and also suspend/resume.
> > 
> > I also tested on OMAP4460 Panda-ES.  Boot is fine and PRCM programming
> > appears sane.  However Panda-ES never comes back from suspend/resume.
> > This problem exists on the PRM/CM branch I based on and was not
> > introduced by this series.  I am investigating that independently of
> > this series.
> > 
> > Anyone wanting to pull the work can find it at:
> > git://git.linaro.org/people/mturquette/linux.git clk-omap-3.8
> > 
> > [1] http://article.gmane.org/gmane.linux.ports.arm.omap/78771
> > [2] http://article.gmane.org/gmane.linux.ports.arm.omap/84015
> 
> I've tested the whole series on a Beagleboard-xM. The kernel boots fine but 
> spits a couple of WARN_ON due to missing clk_prepare in USB-related drivers. I 
> haven't noticed any regression in the OMAP3 ISP driver.
> 

Those drivers need to be fixed.  Can you provide a log?

> I've also successfully tested rate back-propagation (CLK_SET_RATE_PARENT) on 
> the dpll4_m5x2_ck and cam_mclk clocks with the OMAP3 ISP driver. I'll send a 
> patch for that on top of your v3.
> 

It is great to see this feature in action.  Do you think the OMAP3 ISP
driver can have parent clock info removed?  The goal of the
CLK_SET_RATE_PARENT flag is to make life easier for drivers by not
having to know the details of the clock tree topology.

> So,
> 
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 

Thanks for testing!

Regards,
Mike

> -- 
> Regards,
> 
> Laurent Pinchart

From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: dts: dra7: remove ti,hwmod property from pcie
 phy
Date: Thu, 19 Mar 2015 16:49:47 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503191647150.9480@utopia.booyaka.com>
References: <1424422274-27946-1-git-send-email-kishon@ti.com> <1424422274-27946-2-git-send-email-kishon@ti.com> <5509A998.2080509@ti.com> <20150318165706.GQ31346@atomide.com> <5509D3BD.6030004@linaro.org> <alpine.DEB.2.02.1503191455020.9480@utopia.booyaka.com>
 <550AEDA1.50109@linaro.org> <alpine.DEB.2.02.1503191541270.9480@utopia.booyaka.com> <550AF78B.3050202@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36295 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735AbbCSQtt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 12:49:49 -0400
In-Reply-To: <550AF78B.3050202@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, nsekhar@ti.com, linux-omap@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, t-kristo@ti.com

On Thu, 19 Mar 2015, Grygorii.Strashko@linaro.org wrote:

> On 03/19/2015 05:45 PM, Paul Walmsley wrote:
> > On Thu, 19 Mar 2015, Grygorii.Strashko@linaro.org wrote:
> > 
> >> On 03/19/2015 04:55 PM, Paul Walmsley wrote:
> >>> On Wed, 18 Mar 2015, Grygorii.Strashko@linaro.org wrote:
> >>>
> >>>> On 03/18/2015 06:57 PM, Tony Lindgren wrote:
> >>>>> * Grygorii Strashko <grygorii.strashko@ti.com> [150318 09:37]:
> >>>>>> As I can see Patch 1 from this series was merged in 4.0-rc4,
> >>>>>> but this patch wasn't. As result, I can see below warning all the time
> >>>>>> during boot now:
> >>>>>>
> >>>>>> [    0.594591] platform 4a094000.pciephy: Cannot lookup hwmod
> >>>>>> 'pcie1-phy'
> >>>>>
> >>>>> OK. Is this needed as a fix for the v4.0-rc series, or can this wait
> >>>>> for v4.1?
> >>>>
> >>>> I think, Yes. These two patches should go all together, because they are
> >>>> interrelated.
> >>>
> >>> Does the warning result in a functional problem, or is it just a warning?
> >>>
> >>
> >> PCE1 PHY device is not registered any more.
> > 
> > How does the second patch fix that?
> 
> I've re-checked it - sorry for disinfo.
> 
> PHY devices are created, but omap_device_fail_pm_domain is assigned to them.
> As result Runtime PM is not working any more.
> 
> 
> [    0.592501] platform 4a094000.pciephy: Cannot lookup hwmod 'pcie1-phy'
> [    0.597510] pinctrl-single 4a003400.pinmux: 281 pins at pa fc003400 size 1124
> [    0.602794] ti-pipe3 4a094000.pciephy: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
> 
> When ti,hwmods is not present PCI PHY will be added as regular Platform device
> and Runtime PM will work again.

OK then it should definitely go up as a fix.  

Kishon, for future references, those two patches should have been combined 
into a single patch.  As it stands now, if someone bisects down to that 
first patch, it sounds like PM will be at least partially broken.  Too bad 
I don't have a DRA7xx board where things like this can be tested before 
being sent upstream.



- Paul

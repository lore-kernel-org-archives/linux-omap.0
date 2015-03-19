From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: dts: dra7: remove ti,hwmod property from pcie
 phy
Date: Thu, 19 Mar 2015 09:03:02 -0700
Message-ID: <20150319160301.GE31346@atomide.com>
References: <1424422274-27946-1-git-send-email-kishon@ti.com>
 <1424422274-27946-2-git-send-email-kishon@ti.com>
 <5509A998.2080509@ti.com>
 <20150318165706.GQ31346@atomide.com>
 <5509D3BD.6030004@linaro.org>
 <alpine.DEB.2.02.1503191455020.9480@utopia.booyaka.com>
 <550AEDA1.50109@linaro.org>
 <alpine.DEB.2.02.1503191541270.9480@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38626 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbbCSQHn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 12:07:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1503191541270.9480@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, nsekhar@ti.com, linux-omap@vger.kernel.org, sumit.semwal@linaro.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, t-kristo@ti.com

* Paul Walmsley <paul@pwsan.com> [150319 08:46]:
> On Thu, 19 Mar 2015, Grygorii.Strashko@linaro.org wrote:
> 
> > On 03/19/2015 04:55 PM, Paul Walmsley wrote:
> > > On Wed, 18 Mar 2015, Grygorii.Strashko@linaro.org wrote:
> > > 
> > > > On 03/18/2015 06:57 PM, Tony Lindgren wrote:
> > > > > * Grygorii Strashko <grygorii.strashko@ti.com> [150318 09:37]:
> > > > > > As I can see Patch 1 from this series was merged in 4.0-rc4,
> > > > > > but this patch wasn't. As result, I can see below warning all the time
> > > > > > during boot now:
> > > > > > 
> > > > > > [    0.594591] platform 4a094000.pciephy: Cannot lookup hwmod
> > > > > > 'pcie1-phy'
> > > > > 
> > > > > OK. Is this needed as a fix for the v4.0-rc series, or can this wait
> > > > > for v4.1?
> > > > 
> > > > I think, Yes. These two patches should go all together, because they are
> > > > interrelated.
> > > 
> > > Does the warning result in a functional problem, or is it just a warning?
> > > 
> > 
> > PCE1 PHY device is not registered any more.
> 
> How does the second patch fix that?

It seems it should be just a warning fix if the pciephy hwmod entries
are now gone?

Anyways, I'm planning to send a pull request for  omap-for-v4.0/fixes
today. Please let me know ASAP if the $subject patch should be dropped,
otherwise I'll send it as it fixes a boot time warning and is already
applied.

Regards,

Tony

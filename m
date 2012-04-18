From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
Date: Wed, 18 Apr 2012 02:52:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com> <4F8E76C3.7080803@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36749 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab2DRIwI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 04:52:08 -0400
In-Reply-To: <4F8E76C3.7080803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 18 Apr 2012, Cousson, Benoit wrote:

> On 4/12/2012 7:06 PM, Paul Walmsley wrote:
> > On Thu, 12 Apr 2012, Rajendra Nayak wrote:
> > 
> > > On OMAP4+, the clkdm association is moved to hwmod while on older OMAPs'
> > > its associated with a clk.
> > 
> > Sounds like this should be conditional based on the platform, then,
> > rather than weakening the warning for all platforms ?
> 
> Well, as already discussed the clockdomain information is mostly useless for
> most clock nodes because the HW is taking care of the dependencies, so
> highlighting only the ones missing in hwmod is far from enough and will avoid
> scaring people with something that is normal.

Sounds to me like the right time to make this change for OMAP4 is when the 
call to omap2_clk_disable_clkdm_control() is removed from 
clock44xx_data.c.  Hopefully that can happen as soon as someone can finish 
the analysis work that we discussed to figure out what drivers still 
aren't converted to using runtime PM, backed with omap_device & 
omap_hwmod.

And at that point, there shouldn't be any reason to test oh->_clk->clkdm 
at all on OMAP4, no?  OMAP4 should only warn if oh->clkdm_name is missing 
or can't be resolved.

> Considering that OMAP4 clock domain partition is way more complex than it was
> on OMAP2 & 3, if OMAP4 can leave without that, I doubt OMAP2 & 3 clock nodes
> will ever need it, except HW bugs, as usual.
> 
> But still, it is an exception more than the regular case.

As far as OMAP2/3 goes, when OMAP2/3 is converted to use the hwmod 
clockdomain enable sequence, that seems like a good time to drop the 
oh->_clk->clkdm test for main clocks.

I'm also wondering if we should be checking clockdomains for the optional 
clocks in _init_opt_clks()... at least on OMAP2/3, unsure about OMAP4.  
Right now we don't implement any hwmod clockdomain enable sequence for the 
optional clocks.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
Date: Wed, 18 Apr 2012 04:12:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204180406550.29048@utopia.booyaka.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com> <4F8E76C3.7080803@ti.com> <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com> <4F8E84DC.70600@ti.com> <alpine.DEB.2.00.1204180312160.29048@utopia.booyaka.com>
 <4F8E8FF7.4000706@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59933 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308Ab2DRKMN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 06:12:13 -0400
In-Reply-To: <4F8E8FF7.4000706@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 18 Apr 2012, Cousson, Benoit wrote:

> On 4/18/2012 11:40 AM, Paul Walmsley wrote:
> 
> > Sounds like the patch to alter the warnings should be associated with this
> > clock cleanup series, then, since it sounds like it changes the
> > clockdomain control model.
> 
> It just removes the modulemode clock nodes we were using so far. And since
> these nodes were the only ones with a clkdm on OMAP4, it is now complaining,
> because their parents clock does not have a clkdm.

If that series doesn't change the model, then maybe the right fix is just 
to associate those clocks with clockdomains in clock44xx_data.c, until the 
model changes?

I looked up some of those clocks in the OMAP4430 TRM vX.  Most of them 
would be associated with either a CM clockdomain or a PRM clockdomain. The 
TRM does actually mention these two clockdomains.  Two examples (out of 
several) that mention CD_PRM and CD_CM are Figure 3-58 "CD_L4_PER 
Overview" and Figure 3-59 "CD_L3_INIT Overview".

Of course, from the software's perspective, these associations would 
effectively be no-ops, as they are on OMAP2/3; but they seem to match the 
view of the hardware as described in the TRM, so at least they make sense.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: AM33xx: hwmod: Add INIT_NO_IDLE flag for debugss
 hwmod
Date: Wed, 7 May 2014 23:55:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405072348330.23579@utopia.booyaka.com>
References: <1397022467-6166-1-git-send-email-lokeshvutla@ti.com> <alpine.DEB.2.02.1404111800430.14347@utopia.booyaka.com> <alpine.DEB.2.02.1404111807210.14347@utopia.booyaka.com> <534B9C66.9020007@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36593 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbaEGXzd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 19:55:33 -0400
In-Reply-To: <534B9C66.9020007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: hvaibhav@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, rnayak@ti.com

Hi Lokesh

On Mon, 14 Apr 2014, Lokesh Vutla wrote:

> On Friday 11 April 2014 11:39 PM, Paul Walmsley wrote:
> > On Fri, 11 Apr 2014, Paul Walmsley wrote:
> > 
> >> On Wed, 9 Apr 2014, Lokesh Vutla wrote:
> >>
> >>> During boot, when hwmod tries to cut clocks for debugss it always
> >>> gets stuck in transition state and throws the following warning:
> >>>
> >>> [    0.139581] omap_hwmod: debugss: _wait_target_disable failed
> >>>
> >>> As per the information provided by folks, clocks to debugss cannot be cut.
> >>> So adding HWMOD_INIT_NO_IDLE flag to debugss hwmod.
> >>>
> >>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >>
> >> Thanks, queued for v3.15-rc.
> > 
> > Hmmm.  On second thought, this doesn't look like the right fix.  Could 
> > you please comment on the issues raised here:
> > 
> > https://patchwork.kernel.org/patch/2212111/
> Yes, I initially created a driver for enabling and disabling clocks for DEBUGSS.
> But I always see that DEBUGSS is always stuck in transition whenever clocks are cut
> to DEBUGSS. 
> During boot also when hwmod tries to cut clocks the following warning comes:
>   [    0.139581] omap_hwmod: debugss: _wait_target_disable failed.
> 
> As confirmed by the hardware team that this is a bug in silicon that clocks cannot
> be cut to DEBUGSS.
> So I am just adding HWMOD_INIT_NO_IDLE flag to debugss hwmod. 
> 
> I have also tested suspend-resume with $subject patch with TI internal tree.
> 
> Please let me know if I am not clear.

OK, here's my question.  Does the DEBUGSS module correctly enter a 
low-power state when going to suspend, even when the DEBUGSS is still 
enabled?  Or is it the case that we should still disable it in the hwmod 
code and simply skip the call to _wait_target_disable()?

If the former, then please repost your patch with some comments in the 
hwmod data to describe this case, and note that the module will still 
enter a low-power state appropriately when the MPUSS goes into standby (if 
that is indeed the behavior).

If the latter, then it seems like the right approach is to add a hwmod 
flag to indicate that we should still disable it, but not wait for the 
disable to complete.

I guess the most direct way to test this would be to pull out a ammeter 
and verify that the idle current is the same in both cases.

How does that sound?


- Paul

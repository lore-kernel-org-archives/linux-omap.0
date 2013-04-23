From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: hwmod: Cleanup sidle/mstandby
 programming
Date: Tue, 23 Apr 2013 08:19:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304230804410.30196@utopia.booyaka.com>
References: <1361354272-18089-1-git-send-email-santosh.shilimkar@ti.com> <1361354272-18089-3-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1303310053351.6436@utopia.booyaka.com> <515947D3.50904@ti.com> <516FD093.1020607@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57105 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab3DWITx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Apr 2013 04:19:53 -0400
In-Reply-To: <516FD093.1020607@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, khilman@deeprootsystems.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On Thu, 18 Apr 2013, Rajendra Nayak wrote:

> >>> _enable_wakeup() and _disable_wakeup() are expected to program the
> >>> OCP_SYSCONFIG.ENAWAKEUP bit.
> >>
> >> These functions were originally intended to take care of everything needed 
> >> for the IP block to wake up the chip, including the PRCM WKEN programming.  
> >> ENAWAKEUP is simply one part of that.
> >>
> >>> Get rid of the additional sidle/mstandby programming in them, as its 
> >>> confusing (this is expected to be handled elsewhere as part of 
> >>> _enable_sysc()/__idle_sysc())
> >>
> >> Sorry, why does the expectation exist for the code to enable and disable 
> >> device wakeup to be part of _enable_sysc()/_idle_sysc(), rather than in 
> >> functions called by _enable_sysc()/_idle_sysc()?
> > 
> > It all comes down to if SIDLE_SMART_WKUP/MSTANDBY_SMART_WKUP programming
> > be considered as 'idlemode' programming or 'enwakeup' programming.
> > If you consider these are being part of 'enwakeup' progrmming, these should
> > certainly be handled as part of _enable_wakeup() and _disable_wakeup().
> > 
> > Today, in some cases, these are *also* handled as part of _enable_sysc()
> > and _idle_sysc(). The way _enable_wakeup() is invoked from _enable_sysc()
> > is also very inconsistent. For instance, for any IP which supports
> > SYSC_HAS_MIDLEMODE and SYSC_HAS_ENAWAKEUP, we invoke _enable_wakeup()
> > regardless of the MIDLEMODE programmmed.
> > While in case of the IP supporting SYSC_HAS_SIDLEMODE, _enable_wakeup() is
> > invoked only when the SIDLEMODE programmed is SMART or SMART_WKUP.
> > 
> > I understand the cleanups you are suggesting below as part of the movement
> > of some of these things outside of mach-omap2.
> > I was more looking at fixing the existing piece so its readable and does
> > things more consistently.
> 
> Do you have any further thoughts on how we should do about this?

Is it possible to implement a solution that preserves _enable_wakeup() and 
_disable_wakeup() as distinct functions, that can be called by separate 
wakeup control entry points?

If it makes sense to change _enable_sysc() so that it doesn't call 
_enable_wakeup(), but does similar work itself, that's fine with me, as 
long as there's not too much code duplication.

It will be good to have the inconsistencies fixed.


- Paul

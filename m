From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/4] arm: omap: hwmod: 43xx: add DebugSS hwmod data
Date: Tue, 27 Jan 2015 17:55:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501271751020.4845@utopia.booyaka.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com> <1422054704-14915-2-git-send-email-balbi@ti.com> <alpine.DEB.2.02.1501260142590.5450@utopia.booyaka.com> <20150126165640.GA10679@saruman.tx.rr.com> <20150126194933.GG6660@saruman.tx.rr.com>
 <20150127160143.GH14623@saruman.tx.rr.com> <alpine.DEB.2.02.1501271652340.7149@utopia.booyaka.com> <20150127171532.GC14878@saruman.tx.rr.com> <20150127171843.GD14878@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150127171843.GD14878-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 27 Jan 2015, Felipe Balbi wrote:

> On Tue, Jan 27, 2015 at 11:15:32AM -0600, Felipe Balbi wrote:
> > On Tue, Jan 27, 2015 at 05:12:05PM +0000, Paul Walmsley wrote:
> > > On Tue, 27 Jan 2015, Felipe Balbi wrote:
> > > 
> > > > On Mon, Jan 26, 2015 at 01:49:33PM -0600, Felipe Balbi wrote:
> > > > > On Mon, Jan 26, 2015 at 10:56:40AM -0600, Felipe Balbi wrote:
> > > > >
> > > > > > hm... modulemode SWCTRL causes wait_target_ready to fail. Any hints ?
> > > > > 
> > > > > gets stuck in transition state. PRCM_CM_WKUP_DBGSS_CLKCTRL is always
> > > > > read as 0x 12510f00 which would translate into:
> > > > > 
> > > > > - module disabled
> > > > > - all opt clocks are on
> > > > > - module is transitioning
> > > > > - module in standby
> > > > > - clkA as TPIU and STM trace clock
> > > > > - all dividers set to 2
> > > > 
> > > > just fyi, checking with HW folks, this might be a new bug, unless
> > > > debugss needs something special.
> > > 
> > > If that happens on DEBUGSS disable, it's probably the same issue as on 
> > > AM33xx:
> > > 
> > > http://www.spinics.net/lists/arm-kernel/msg320801.html
> > > http://www.spinics.net/lists/arm-kernel/msg321930.html
> > > http://www.spinics.net/lists/arm-kernel/msg329151.html
> > > 
> > > Does adding HWMOD_INIT_NO_IDLE fix the issue you're seeing?
> > 
> > I'll try it out in a bit...
> 
> nope, same thing.
> 
> [   27.633235] omap_hwmod: debugss: _wait_target_disable failed

OK, looking at the code, this makes sense.  So here's what I'd suggest 
asking the hardware team: is the right approach to:

1. keep the DEBUGSS CLKCTRL MODULEMODE bitfield at 0x2 all the time, even 
when it's not in use or when entering chip low-power states, or

2. program the DEBUGSS CLKCTRL MODULEMODE bitfield to 0x0 when the DEBUGSS 
is not in use or when entering chip low-power states, but ignore the 
DEBUGSS CLKCTRL IDLEST register 

We'll need a new hwmod flag either way; the question is whether it should 
be something like HWMOD_CANNOT_DISABLE (case 1), or 
HWMOD_DISABLE_IGNORE_IDLEST (case 2).


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

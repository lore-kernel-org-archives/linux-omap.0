From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCHv3] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Wed, 19 Apr 2017 10:16:39 -0700
Message-ID: <20170419171639.GN7065@codeaurora.org>
References: <20170123221702.18420-1-tony@atomide.com>
 <dca1ef84-77d1-2b58-7913-91f3b69fde6d@ti.com>
 <20170419165522.GL7065@codeaurora.org>
 <20170419170246.GA19537@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170419170246.GA19537-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/19, Tony Lindgren wrote:
> * Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> [170419 09:58]:
> > On 02/13, Tero Kristo wrote:
> > > On 24/01/17 00:17, Tony Lindgren wrote:
> > > 
> > > This binding works for me, so:
> > > 
> > > Acked-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> > > 
> > 
> > This wasn't in the TI clk PR. Shall I merge this to clk-next?
> 
> Tero has this included in his clkctrl series and there's one typo
> fix needed where the doc still says #clock-cells = <4> instead of <2>.
> 
> I suggest let's wait a bit on this and let's try to get the clkctrl
> driver parts into next early after v4.12-rc1 if no issues.
> 
> It seems the clkctrl series clock driver part is pretty much
> ready to go, the remaining issues seem to be in the hwmod code.
> 

Ok thanks. I'll remove this from my queue.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM errata 430973 on multi platform kernels
Date: Mon, 6 Apr 2015 08:24:03 -0700
Message-ID: <20150406152402.GH18048@atomide.com>
References: <20150330175051.GK10805@atomide.com>
 <20150331123233.GA15103@earth>
 <20150401194734.GT10805@atomide.com>
 <20150403163553.GA16247@earth>
 <551F0F50.1030701@gmail.com>
 <20150403221517.GX10805@atomide.com>
 <551F186B.90608@gmail.com>
 <20150403225212.GY10805@atomide.com>
 <CAALWOA-h5SdnGhbckJ+x0efijmNaQxX-8ULjn_J=mCb-UJMeoQ@mail.gmail.com>
 <20150405133934.GC9186@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:42336 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142AbbDFP1t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Apr 2015 11:27:49 -0400
Content-Disposition: inline
In-Reply-To: <20150405133934.GC9186@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

* Sebastian Reichel <sre@kernel.org> [150405 06:40]:
> Hi,
> 
> On Sun, Apr 05, 2015 at 06:13:47AM +0200, Matthijs van Duin wrote:
> > On 4 April 2015 at 00:52, Tony Lindgren <tony@atomide.com> wrote:
> > > Right, it affects n900 for sure. My point is that it also seems to
> > > affect 37xx versions not listed to suffer from this issue.
> > 
> > They shouldn't... erratum 430973 only affected Cortex-A8 r1, and the
> > dm37xx should have an r3p2 right?
> > 
> > A word of caution though: at least on the DM814x and AM335x, secure
> > ROM sets bit 6 (IBE) in the Auxiliary Control Register, thereby
> > enabling BTB invalidate instructions (which normally execute as nops).
> > This is presumably a leftover of the erratum 430973 workaround, but it
> > means there is a risk of running afoul of erratum 687067 if BTB
> > invalidate by MVA instructions are actually used.
> > 
> > I would actually suggest clearing IBE if it set on Cortex-A8 r2 or
> > later processors and a secure monitor call is available to do so
> > (there is on the DM814x and AM335x, dunno about the 37xx), also for
> > performance reasons: BTB invalidates are quite expensive instructions
> > (when enabled).
> 
> So if I understand the issue correct, it would be ok to enable the
> 430973 workaround in cpu_v7_switch_mm for arm multiplatform kernels
> (mcr p15, 0, r2, c7, c5, 6 @ flush BTAC/BTB). On unaffected
> Cortex-A8 platforms the IBE bit should be unset (resulting in a nop
> instead of the BTB flush).

Well we only want to enable for cortex-a8 revisions affected by
430973, so a custom cpu_v7_switch_mm seems like the way to go there.

And then we need checks for clearing IBE for unaffected cortex-a8
revisions. I'll check to today if I have IBE bit set on the systems
where I'm seeing issues that should not be affected by 430973.
 
> So assuming, that the same is true for non Cortex-A8 platforms: Can
> the workaround simply be enabled by default if CPU_V7 is selected?

It should be enabled conditionally.

Regards,

Tony

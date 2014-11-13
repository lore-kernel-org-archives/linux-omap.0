From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] arm: dts: omap3-gta04: Add static configuration for
 devconf1 register
Date: Thu, 13 Nov 2014 15:58:41 -0800
Message-ID: <20141113235840.GS26481@atomide.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-5-git-send-email-marek@goldelico.com>
 <5463585D.9070209@ti.com>
 <20141112150210.GC26481@atomide.com>
 <5464969F.30708@ti.com>
 <20141113182848.GQ26481@atomide.com>
 <alpine.DEB.2.02.1411132251320.17030@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1411132251320.17030@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Marek Belisko <marek@goldelico.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, linux@arm.linux.org.uk, plagnioj@jcrosoft.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, hns@goldelico.com, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [141113 15:01]:
> Hi
> 
> On Thu, 13 Nov 2014, Tony Lindgren wrote:
> 
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [141113 03:33]:
> > > On 12/11/14 17:02, Tony Lindgren wrote:
> > > 
> > > >> And, with a quick grep, I see CONTROL_DEVCONF1 touched in multiple
> > > >> places in the kernel. I wonder if adding a pinmux entry for it could
> > > >> cause some rather odd problems.
> > > > 
> > > > They can all use pinctrl-single no problem.
> > > 
> > > Can, but don't. That's my worry. If we touch the DEVCONF1 via pinmux,
> > > and we have code in mach-omap2 that also touch DEVCONF1, without any
> > > knowledge (and locking) between those...
> > 
> > Hmm yeah the McBSP clock mux could be racy as the mux register for
> > McBSP is treated as a clock. This register muxes the clock between
> > external pin and internal clock. Considering that this should be
> > selectable at board level as the external clock probably needs to be
> > used if level shifters are being used, it should be really handled by
> > pinctrl-single.
> > 
> > The other use for hsmmc.c and pdata-quirks.c for the one time mux for
> > MMC clock from the MMC clock pin. That can be done with pinctrl-single
> > from the MMC driver too for DT based booting.
> > 
> > Then we just have the save and restore of the registers for
> > off-idle.
> >  
> > > So _maybe_ that's not an issue, as the pinmux config we have here is
> > > fixed, and done once at boot time, and maybe the code in mach-omap2 that
> > > touch DEVCONF1 is also ran just once and not at the same time as the
> > > pinmux. But I don't know if that's so.
> > 
> > It seems we could just do a read-only check for McBSP in the clock
> > code for the mux register, or even completely drop that code from
> > cclock3xxx_data.c and start using the pinctrl for that mux.
> > 
> > Paul & Tero, got any comments here?
> 
> It's best to move all of the SCM register reads/writes to an SCM IP block 
> driver.  This driver would be the only entity that would touch the SCM IP 
> block registers - no other code on the system would touch it (perhaps 
> aside from anything needed for early init).  The SCM driver would enforce 
> mutual exclusion via a spinlock, so concurrent SCM register modifications 
> wouldn't flake out.  Then the SCM driver would register clocks with the 
> CCF, register pins with the pinctrl subsystem, etc. etc.

We actually do have that with pinctrl-single + syscon. We certainly
need to implement more Linux framework drivers for the SCM registers.
Things like regulators, clocks, and PHYs, but they should use
pinctrl-single + syscon. See the the pbias-regulator.c for example.

Looking at the McBSP clock handling, threre's yet more handling of
the same DEVCONF1 mux register in omap2_mcbsp_set_clks_src that gets 
alled from omap_mcbsp_dai_set_dai_sysclk.

To me it seems that if we handle the DEVCONF with pinctrl-single, we
don't need most of the McBSP fck code or the omap2_mcbsp_set_clks_src.
Having the mux register as the clock enable register is not nice..
Who knows what the clock coming from the external pin might be :)

Regards,

Tony

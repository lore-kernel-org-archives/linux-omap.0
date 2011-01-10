From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/3] perf: add OMAP support for the new power events
Date: Mon, 10 Jan 2011 15:14:31 +0100
Message-ID: <201101101514.32355.trenn@suse.de>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com> <alpine.DEB.2.00.1101041146160.19319@utopia.booyaka.com> <AANLkTi=3pek3+Vv+c1TCxBH2RJcoSXq8TL8CyK9ABMeu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=3pek3+Vv+c1TCxBH2RJcoSXq8TL8CyK9ABMeu@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, mingo@elte.hu, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 05 January 2011 12:05:18 Jean Pihet wrote:
> Hi Paul,
> 
> On Tue, Jan 4, 2011 at 7:48 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > Hello Jean,
> >
> > On Tue, 4 Jan 2011, jean.pihet@newoldbits.com wrote:
> >
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> The patch adds the new power management trace points for
> >> the OMAP architecture.
> >>
> >> The trace points are for:
> >> - default idle handler. Since the cpuidle framework is
> >>   instrumented in the generic way there is no need to
> >>   add trace points in the OMAP specific cpuidle handler;
> >> - cpufreq (DVFS),
> >> - clocks changes (enable, disable, set_rate),
> >
> > A question about these.  Are these only meant to track calls to these
> > functions from outside the clock code?  Or meant to track actual hardware
> > clock changes?
> The former: this is used to track the clock requests from outside the
> clock framework.
> 
> > If the latter, then it might make sense to put these
> > trace points into the functions that actually change the hardware
> > registers, e.g., omap2_dflt_clk_{enable,disable}(), etc., since a
> > clk_enable() on a leaf clock may result in many internal system clocks
> > being enabled up the clock tree.
> I agree with you it is better to track the actual clock changes instead.
> I propose to move the tracepoints to omap2_clk_{enable...} which
> enables all the clocks irrespectively of the installed handler.
> Note about the clock handlers: omap2_dflt_clk_enable happens to be the
> handler for all controllable clocks but could that change in the
> future?
Looks like there is cpuidle34xx using cpuidle framework on specific boards
only.
And pm34xx.c and others override pm_idle and use the same low level
functions to reduce power consumption as cpuidle34xx.
Ideally pm34xx.c (and others) would not override pm_idle, but register as
a cpuidle driver. Then the idle events would be tracked by the
cpuidle subsystem automatically (with my latest patches).
But this would be a more intrusive change (are there efforts to do that?).
Even if it should happen at some point, adding some additional events for
people to better debug/monitor the stuff now does not hurt.

    Thomas

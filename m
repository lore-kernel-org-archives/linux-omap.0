From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/5] PM / clock_ops: provide default runtime ops and
 cleanup users
Date: Fri, 1 May 2015 10:09:10 +0900
Message-ID: <20150501010909.GI13754@verge.net.au>
References: <553A6289.4040001@oracle.com>
 <CAMuHMdWMjULD8jQDA-U6tumnCd=Q7jhZ2koha4CKU-K50tJXmw@mail.gmail.com>
 <20150428004618.GA1807@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150428004618.GA1807@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, santosh shilimkar <santosh.shilimkar@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rajendra Nayak <rnayak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 28, 2015 at 09:46:18AM +0900, Simon Horman wrote:
> On Fri, Apr 24, 2015 at 04:51:03PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Apr 24, 2015 at 4:41 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Thursday, April 23, 2015 02:03:08 PM Rajendra Nayak wrote:
> > >> Most users of PM clocks do the exact same thing in runtime callbacks.
> > >> Provide default callbacks and cleanup the existing users (keystone/davinci
> > >> /omap1/sh)
> > >>
> > >> Rajendra Nayak (5):
> > >>   PM / clock_ops: Provide default runtime ops to users
> > >>   arm: keystone: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
> > >>   arm: omap1: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
> > >>   arm: davinci: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
> > >>   drivers: sh: remove boilerplate code and use USE_PM_CLK_RUNTIME_OPS
> > >>
> > >>  arch/arm/mach-davinci/pm_domain.c  | 32 +-------------------------
> > >>  arch/arm/mach-keystone/pm_domain.c | 33 +-------------------------
> > >>  arch/arm/mach-omap1/pm_bus.c       | 37 ++----------------------------
> > >>  drivers/base/power/clock_ops.c     | 38 ++++++++++++++++++++++++++++++
> > >>  drivers/sh/pm_runtime.c            | 47 ++------------------------------------
> > >>  include/linux/pm_clock.h           | 10 ++++++++
> > >>  6 files changed, 54 insertions(+), 143 deletions(-)
> > >
> > > It is not particularly clear to me who is supposed to apply this series, but
> > > I can do that if people don't have problems with that.
> > 
> > All later patches depend on the first patch.
> > 
> > For shmobile, Simon has queued up changes for drivers/sh/pm_runtime.c,
> > but I think they don't conflict with this series.
> 
> Yes, that is the case. I have some patches (from Geert) queued up for v4.1.
> I have confirmed that they do not conflict with the shmobile (last) patch
> if this series.
> 
> <details>
> The patches are in the sh-drivers-for-v4.1 branch of my renesas tree; I
> rebased them yesterday; they should hit next today if there is a next
> today; I plan to send a pull request to Linus in the not to distant future;
> and I envisage they should end up in v4.1-rc2 or rc3.

The above mentioned changes were tagged as renesas-sh-drivers-for-v4.1 in
my renesas tree; were merged into in Linus's tree yesterday; and should
thus be included in v4.1-rc2.

I do not have any other changes to drivers/sh/pm_runtime.c pending at this time.

> </details>
> 
> On Fri, Apr 24, 2015 at 08:34:33AM -0700, santosh shilimkar wrote:
> > On 4/24/2015 7:41 AM, Rafael J. Wysocki wrote:
> > >On Thursday, April 23, 2015 02:03:08 PM Rajendra Nayak wrote:
> 
> [snip]
> 
> > >It is not particularly clear to me who is supposed to apply this series, but
> > >I can do that if people don't have problems with that.
> > >
> > >
> > I am fine by that given dependency with first patch.
> > Another way is, you pick up the first patch and give us an
> > immutable branch.
> > 
> > Either way is fine by me.
> 
> Likewise.
> 
> Here is an ack for the shmobile (last) patch if you decide to take it
> through your tree.
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 0/2] ARM: OMAP2+/dts: standardize SoC naming
Date: Wed, 8 Jan 2014 11:18:47 -0800
Message-ID: <20140108191846.GE31323@atomide.com>
References: <1386204578-6018-1-git-send-email-nm@ti.com>
 <CAGo_u6o+Lcf0wzmsSir1APd4T3A4D+GPtdRmkBM79mjW2aEGHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGo_u6o+Lcf0wzmsSir1APd4T3A4D+GPtdRmkBM79mjW2aEGHA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <bcousson@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, dt list <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, lkml <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140106 16:49]:
> Hi Benoit, Tony,
> 
> On Wed, Dec 4, 2013 at 6:49 PM, Nishanth Menon <nm@ti.com> wrote:
> > Originally attempted partially in [1], the missing binding were
> > reported as part of Rob's report in [2].
> 
> Would you like me to send this series again since I do not see this in:
> https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.14/dts

No need to and sorry for the delays. I'm applying these into
omap-for-v3.14/fixes-not-urgent as they should not conflict with
other DT related patches.

Regards,

Tony
 
> patchwork links:
> https://patchwork.kernel.org/patch/3286051/
> https://patchwork.kernel.org/patch/3286061/
> 
> >
> > So, here is take two of the series, lacking an standard causes issues
> > that was fixed such as [3]. Ideally, we should never again introduce a
> > board file without a exact compatible SoC match.
> >
> > I have stayed a bit away from updating board and SoC dts files yet
> > to look at the direction we'd like to go here. If we feel things are
> > good, I would gladly try to clean our mess up.
> >
> > Nishanth Menon (2):
> >   Documentation: dt: OMAP: explicitly state SoC compatible strings
> >   ARM: OMAP2+: board-generic: update SoC compatibility strings
> >
> >  .../devicetree/bindings/arm/omap/omap.txt          |   53 ++++++++++++++++++++
> >  arch/arm/mach-omap2/board-generic.c                |    7 +++
> >  2 files changed, 60 insertions(+)
> >
> > [1] https://patchwork.kernel.org/patch/2998201/
> > [2] http://marc.info/?l=linux-arm-kernel&m=138378029113665&w=2
> > [3] https://patchwork.kernel.org/patch/3279281/
> >
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

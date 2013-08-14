From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk
 info from DT
Date: Wed, 14 Aug 2013 14:49:04 +0100
Message-ID: <20130814134904.GC13141@e106331-lin.cambridge.arm.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-3-git-send-email-rnayak@ti.com>
 <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com>
 <520B8409.5000708@ti.com>
 <520B88A0.6080806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63991 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759903Ab3HNNtH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 09:49:07 -0400
Content-Disposition: inline
In-Reply-To: <520B88A0.6080806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@gmail.com>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, pawel.moll@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, grant.likely@linaro.org, tomasz.figa@gmail.com, rob.herring@calxeda.com, galak@codeaurora.org, mturquette@linaro.org

[Adding Mike Turquette and dt maintainers]

On Wed, Aug 14, 2013 at 02:39:44PM +0100, Nishanth Menon wrote:
> On 08/14/2013 08:20 AM, Rajendra Nayak wrote:
> > On Wednesday 14 August 2013 06:18 PM, Nishanth Menon wrote:
> >> Hi Rajendra,
> >>
> >> On Tue, Jul 23, 2013 at 1:24 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> >> [..]
> >>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> >>> index 12fa589..e5c804b 100644
> >>> --- a/arch/arm/mach-omap2/omap_hwmod.c
> >>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> >>> @@ -805,6 +805,65 @@ static int _init_interface_clks(struct omap_hwmod *oh)
> >>>          return ret;
> >>>   }
> >>>
> >>> +static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
> >>> +                                      struct device_node *np,
> >>> +                                      int *opt_clks_cnt)
> >>> +{
> >>> +       int i, clks_cnt;
> >>> +       const char *clk_name;
> >>> +       const char **opt_clk_names;
> >>> +
> >>> +       clks_cnt = of_property_count_strings(np, "clock-names");
> >>> +       if (!clks_cnt)
> >>> +               return NULL;
> >>> +
> >>> +       opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
> >>> +       if (!opt_clk_names)
> >>> +               return NULL;
> >>> +
> >>> +       for (i = 0; i < clks_cnt; i++) {
> >>> +               of_property_read_string_index(np, "clock-names", i, &clk_name);
> >>> +               if (!strcmp(clk_name, "fck"))
> >>
> >> Could we instead parse for names that are "optional,role_name" instead
> >> of assuming anything other than fck is optional clocks?
> >
> > you mean look for anything with optional,*? because the role names would change.
> >
> 
> yes. the idea being, we now have a meaning to the clock name - there are 
> two types of clocks here.. functional and optional, we *might* have 
> facility to add interface clock(we dont know interface clock handling 
> yet, but something in the future).. we might increase the support for 
> number of functional clocks.. it might help to keep the format such that 
> it is a "bit extendable".

I completely disagree. The only things that should appear in clock-names
are the names of the clock inputs that appear in the manual for the
device. The driver should know which ones are optional, as that's a
fixed property of the IP and the way the driver uses it.

You should not be embedding additional semantics in name properties.

Thanks,
Mark.

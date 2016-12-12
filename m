From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
Date: Mon, 12 Dec 2016 10:25:09 -0800
Message-ID: <148156710975.37646.2957511113527634913@resonance>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <20161028005341.GR26139@codeaurora.org>
 <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
 <20161028233750.GQ16026@codeaurora.org>
 <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tero Kristo (2016-12-02 00:15:53)
> On 29/10/16 02:37, Stephen Boyd wrote:
> > On 10/28, Tero Kristo wrote:
> >> Eventually that should happen. However, we have plenty of legacy
> >> code still in place which depend on clk_get functionality within
> >> kernel. The major contributing factor is the hwmod codebase, for
> >> which we have plans to:
> >>
> >> - get this clock driver merged
> >> - implement a new interconnect driver for OMAP family SoCs
> >> - interconnect driver will use DT handles for fetching clocks,
> >> rather than clock aliases
> >> - reset handling will be implemented as part of the interconnect
> >> driver somehow (no prototype / clear plans for that as of yet)
> >> - all the hwmod stuff can be dropped
> >>
> >> The clock alias handling is still needed as a transition phase until
> >> all the above is done, then we can start dropping them. Basically
> >> anything that is using omap_hwmod depends on the clock aliases right
> >> now.
> >
> > Ok, sounds good. Thanks.
> =

> Stephen, any final comments on this series? I guess its too late to push =

> for 4.10, but I would like to get this merged early for 4.11 window.

Hi Tero,

No final comments from me. I needed to go back and forth with Tony about
the clockdomain modeling, but it seems sensible to create clock
providers from the clock domains if you want to pass those struct clk
objects down to the drivers.

One thing I wasn't able to follow exactly in the code is how the
clockdomains are linking parent clocks from cm1, cm2, etc to the clock
domains. Are the clockdomain providers calling clk_get() on the clocks
that it *consumes*, or are the clockdomain providers never calling
clk_get() on those clocks and just establishing the tree hierarchy at
clk_register() time?

Unless Stephen has any more review comments we can merge this into a
clk-next based on v4.10-rc1 when that drops.

Regards,
Mike

> =

> -Tero

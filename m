From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
Date: Fri, 31 Aug 2018 11:34:13 +0200
Message-ID: <20180831093413.GK28861@localhost>
References: <20180822090319.29167-1-johan@kernel.org>
 <153549552398.129321.2521954503276443182@swboyd.mtv.corp.google.com>
 <20180829075007.GC28861@localhost>
 <4fbdbb5d-6b56-37e2-08e1-27f71cb6de22@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4fbdbb5d-6b56-37e2-08e1-27f71cb6de22@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Johan Hovold <johan@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Aug 30, 2018 at 10:28:28AM +0300, Tero Kristo wrote:
> On 29/08/18 10:50, Johan Hovold wrote:
> > On Tue, Aug 28, 2018 at 03:32:03PM -0700, Stephen Boyd wrote:
> >> Quoting Johan Hovold (2018-08-22 02:03:19)
> >>> Fix child-node lookup which by using the wrong OF helper was searching
> >>> the whole tree depth-first, something which could end up matching an
> >>> unrelated node.
> >>>
> >>> Also fix the related node-reference leaks.
> >>>
> >>> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
> >>
> >> Found by inspection? Or it's actively causing problems? I'm thinking
> >> it's the former so this can bake in clk-next for a while.
> > 
> > Right, through inspection. I fixed up most of these last year, but this
> > one managed to sneak in since then.
> > 
> > clk-next should be fine.
> 
> The patch looks fine to me also, just had to test this out with my 
> latest development branch as it conflicts with that one a bit.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Thanks for reviewing.

Johan

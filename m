From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: fix linker error with !SOC_OMAP4
Date: Fri, 21 Apr 2017 18:54:13 -0700
Message-ID: <20170422015413.GX7065@codeaurora.org>
References: <20170419214318.1605787-1-arnd@arndb.de>
 <9df5f73d-3e3a-ee33-1b75-c14a1a707ad9@ti.com>
 <CAK8P3a2=pDP7-b4njRo9KKa-JAueTp8O=stmyMz68-Piy__UKQ@mail.gmail.com>
 <c20456ea-dee2-878a-6cf1-2b3169fd20f4@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c20456ea-dee2-878a-6cf1-2b3169fd20f4@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michael Turquette <mturquette@baylibre.com>, Tony Lindgren <tony@atomide.com>, Richard Watts <rrw@kynesim.co.uk>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 04/20, Tero Kristo wrote:
> On 20/04/17 18:06, Arnd Bergmann wrote:
> >On Thu, Apr 20, 2017 at 4:57 PM, Tero Kristo <t-kristo@ti.com> wrote:
> >>On 20/04/17 00:43, Arnd Bergmann wrote:
> >>>
> >>>When none of the OMAP4-generation SoCs are enabled, we run into a link
> >>>error for am43xx/am43xx:
> >>>
> >>>drivers/clk/ti/dpll.o: In function `of_ti_am3_dpll_x2_setup':
> >>>dpll.c:(.init.text+0xd8): undefined reference to `clkhwops_omap4_dpllmx'
> >>>
> >>>This is easily fixed by adding another #ifdef.
> >>>
> >>>While looking at the code, I also spotted another problem with the
> >>>assignment of hw_ops variable that is not used again later. I'm
> >>>changing this to setting clk_hw->ops instead, which I guess is what
> >>>was intended here.
> >>
> >>
> >>Good catch... It seems the corner case is masked in the testing I did
> >>locally so far.
> >>
> >>>
> >>>Fixes: 0565fb168d63 ("clk: ti: dpll: move omap3 DPLL functionality to
> >>>clock driver")
> >>
> >>
> >>However, I believe the fixes tag should point to this one in linux-next:
> >>
> >>commit 473adbf4e02857a6b78dfb3d9fcf752638bbadb9
> >>Author: Tero Kristo <t-kristo@ti.com>
> >>Date:   Thu Feb 9 11:25:28 2017 +0200
> >>
> >>    clk: ti: dpll44xx: fix clksel register initialization
> >
> >Ah, right.
> >
> >>Other than that:
> >>
> >>Acked-by: Tero Kristo <t-kristo@ti.com>
> >
> >Do you want me to resend, or can you forward the patch with the
> >fixed fixes line?
> 
> I guess thats up to Stephen, he typically picks single fixes like
> these. I can also create a pull request with the fixes you provided
> if Stephen prefers that, in that case I can fix the "Fixes:" tag
> myself.
> 
> Stephen any preference?

I'll just apply it right now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

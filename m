From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] clk: ti: omap5+: dpll: implement errata i810
Date: Wed, 16 Dec 2015 09:16:50 -0800
Message-ID: <20151216171650.GS23396@atomide.com>
References: <1450256530-10251-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450256530-10251-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [151216 01:00]:
> Errata i810 states that DPLL controller can get stuck while transitioning
> to a power saving state, while its M/N ratio is being re-programmed.
> 
> As a workaround, before re-programming the M/N ratio, SW has to ensure
> the DPLL cannot start an idle state transition. SW can disable DPLL
> idling by setting the DPLL AUTO_DPLL_MODE=0 or keeping a clock request
> active by setting a dependent clock domain in SW_WKUP.
> 
> This errata is known to impact OMAP5 and DRA7 chips, but lets enable it
> unconditionally to avoid any potential problems with earlier generation
> SoCs also.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> v2: made the fix to be applied unconditionally on all OMAP3+ SoCs

Thanks looks good to me now:

Acked-by: Tony Lindgren <tony@atomide.com>

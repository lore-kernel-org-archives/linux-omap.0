From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: omap5+: dpll: implement errata i810
Date: Mon, 30 Nov 2015 11:35:38 -0800
Message-ID: <20151130193538.GJ11298@codeaurora.org>
References: <1448894605-30097-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448894605-30097-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/30, Tero Kristo wrote:
> Errata i810 states that DPLL controller can get stuck while transitioning
> to a power saving state, while its M/N ratio is being re-programmed.
> 
> As a workaround, before re-programming the M/N ratio, SW has to ensure
> the DPLL cannot start an idle state transition. SW can disable DPLL
> idling by setting the DPLL AUTO_DPLL_MODE=0 or keeping a clock request
> active by setting a dependent clock domain in SW_WKUP.
> 
> This errata impacts OMAP5 and DRA7 chips, so enable the errata for these.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 10/10] clk: ti: make clk-dra7-atl explicitly non-modular
Date: Fri, 4 Nov 2016 13:35:15 -0700
Message-ID: <20161104203515.GJ16026@codeaurora.org>
References: <20160704211220.5685-1-paul.gortmaker@windriver.com>
 <20160704211220.5685-11-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160704211220.5685-11-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/04, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> arch/arm/mach-omap2/Kconfig:config SOC_DRA7XX
> arch/arm/mach-omap2/Kconfig:    bool "TI DRA7XX"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
> 
> Since module_platform_driver() uses the same init level priority as
> builtin_platform_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tags etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

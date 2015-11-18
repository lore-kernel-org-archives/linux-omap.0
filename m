From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: gpio: Get parent clk names already in
 of_gpio_clk_setup()
Date: Wed, 18 Nov 2015 14:19:03 -0800
Message-ID: <20151118221903.GF32672@codeaurora.org>
References: <201511170911.tAH9B0CF031498@arroyo.ext.ti.com>
 <1447754204-24088-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447754204-24088-1-git-send-email-jsarha@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@baylibre.com>, tomi.valkeinen@ti.com, Sergej Sawazki <ce3a@gmx.de>
List-Id: linux-omap@vger.kernel.org

On 11/17, Jyri Sarha wrote:
> Get parent clk names already in of_gpio_clk_setup() and store the
> names in struct clk_gpio_delayed_register_data. of_clk_get_parent_name()
> can not be called in struct of_clk_provider's get() callback since it
> may make a recursive call to of_clk_get_from_provider() and this in turn
> tries to recursively lock of_clk_mutex.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Cc: Sergej Sawazki <ce3a@gmx.de>
> ---
> Something has changed in Linux mainline so that getting the clk
> parent names in struct of_clk_provider's get() callback does not work
> anymore. This patch should fix the problem.

Something would be commit 0a4807c2f9a4 (clk: Make
of_clk_get_parent_name() robust with #clock-cells = 1, 2015-10-14)?

The patch looks good. Given that there's one user of this code in
mainline I'll push this as a fix for v4.4.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/10] clk: ti: Add few dm814x clock aliases
Date: Tue, 8 Dec 2015 08:57:33 -0800
Message-ID: <20151208165732.GY23396@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449013103-23238-3-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [151201 15:43]:
> The timer clock aliases are needed early on dm814x. Let's also
> add the aliases for the interconnects and MMC.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Anybody from the clock department care to ack this one? I'd like to
get this series into Linux next as it fixes some some issues.

Regards,

Tony


>  drivers/clk/ti/clk-814x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/clk/ti/clk-814x.c b/drivers/clk/ti/clk-814x.c
> index e172920..9e85fcc 100644
> --- a/drivers/clk/ti/clk-814x.c
> +++ b/drivers/clk/ti/clk-814x.c
> @@ -14,10 +14,14 @@ static struct ti_dt_clk dm814_clks[] = {
>  	DT_CLK(NULL, "devosc_ck", "devosc_ck"),
>  	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
>  	DT_CLK(NULL, "sysclk4_ck", "sysclk4_ck"),
> +	DT_CLK(NULL, "sysclk5_ck", "sysclk5_ck"),
>  	DT_CLK(NULL, "sysclk6_ck", "sysclk6_ck"),
> +	DT_CLK(NULL, "sysclk8_ck", "sysclk8_ck"),
>  	DT_CLK(NULL, "sysclk10_ck", "sysclk10_ck"),
>  	DT_CLK(NULL, "sysclk18_ck", "sysclk18_ck"),
>  	DT_CLK(NULL, "timer_sys_ck", "devosc_ck"),
> +	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
> +	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
>  	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
>  	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
>  	{ .node_name = NULL },
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

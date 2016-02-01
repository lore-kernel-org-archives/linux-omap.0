From: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: add sanity checking for load and
 match values
Date: Mon, 1 Feb 2016 13:35:03 -0500
Message-ID: <20160201133503.53599493.drivshin.allworx@gmail.com>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
	<1454128014-22866-3-git-send-email-drivshin.allworx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <1454128014-22866-3-git-send-email-drivshin.allworx@gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 29 Jan 2016 23:26:52 -0500
"David Rivshin (Allworx)" <drivshin.allworx@gmail.com> wrote:

> From: David Rivshin <drivshin@allworx.com>
> 
> Add sanity checking to ensure that we do not program load or match
> values that are out of range if a user requests period or duty_cycle
> values which are not achievable. The match value cannot be less than
> the load value (but can be equal), and neither can be 0xffffffff.
> This means that there must be at least one fclk cycle between load
> and match, and another between match and overflow.
> 
> Fixes: 6604c6556db9 ("pwm: Add PWM driver for OMAP using dual-mode
> timers") Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
 [...]
> @@ -149,6 +149,24 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip, 
> period_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, period_ns); 
> duty_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, duty_ns); 
>
> +	if (period_cycles < 2) {
> +		dev_info(chip->dev,
> +			"period %dns is too short for clock rate %luHz\n",
> +			period_ns, clk_rate);
> +		goto err_einval;
> +	}
 [...]

I had some second thoughts on this over the weekend:
1) Perhaps the return should be -ERANGE instead of -EINVAL for this case?
2) Is dev_info() too severe for this? Perhaps dev_dbg() would be better?
Any preferences?

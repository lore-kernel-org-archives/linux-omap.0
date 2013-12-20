From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 3/7] regulator: add pbias regulator support
Date: Fri, 20 Dec 2013 15:39:51 -0800
Message-ID: <20131220184451.GD26054@atomide.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
 <1387560955-6547-4-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1387560955-6547-4-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org

* Balaji T K <balajitk@ti.com> [131220 09:37]:
> +static const struct pbias_reg_info pbias_mmc_omap2430 = {
> +	.enable = BIT(1),
> +	.enable_mask = BIT(1),
> +	.vmode = BIT(0),
> +	.enable_time = 100,
> +	.name = "pbias_mmc_omap2430"
> +};
> +
> +static const struct pbias_reg_info pbias_sim_omap3 = {
> +	.enable = BIT(9),
> +	.enable_mask = BIT(9),
> +	.vmode = BIT(8),
> +	.enable_time = 100,
> +	.name = "pbias_sim_omap3"
> +};
> +
> +static const struct pbias_reg_info pbias_mmc_omap4 = {
> +	.enable = BIT(26) | BIT(22),
> +	.enable_mask = BIT(26) | BIT(25) | BIT(22),
> +	.vmode = BIT(21),
> +	.enable_time = 10,
> +	.name = "pbias_mmc_omap4"
> +};
> +
> +static const struct pbias_reg_info pbias_mmc_omap5 = {
> +	.enable = BIT(27) | BIT(26),
> +	.enable_mask = BIT(27) | BIT(25) | BIT(26),
> +	.vmode = BIT(21),
> +	.enable_time = 100,
> +	.name = "pbias_mmc_omap5"
> +};

Should the enable_time be 100 for omap4 like for the others?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>

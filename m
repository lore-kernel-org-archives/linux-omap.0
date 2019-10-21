From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] clk/ti/adpll: allocate room for terminating null
Date: Mon, 21 Oct 2019 07:31:10 -0700
Message-ID: <20191021143110.GT5610@atomide.com>
References: <20191019155441.2b1b349f@heffalump.sk2.org>
 <20191019140634.15596-1-steve@sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191019140634.15596-1-steve@sk2.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Stephen Kitt <steve@sk2.org> [191019 14:07]:
> The buffer allocated in ti_adpll_clk_get_name doesn't account for the
> terminating null. This patch switches to devm_kasprintf to avoid
> overflowing.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
> Changes since v2:
>   - Move "adpll" into the format string and drop base_name entirely.
> 
> Changes since v1:
>   - Use devm_kasprintf instead of manually allocating the target
>     buffer.

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/clk/ti/adpll.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
> index fdfb90058504..bb2f2836dab2 100644
> --- a/drivers/clk/ti/adpll.c
> +++ b/drivers/clk/ti/adpll.c
> @@ -194,15 +194,8 @@ static const char *ti_adpll_clk_get_name(struct ti_adpll_data *d,
>  		if (err)
>  			return NULL;
>  	} else {
> -		const char *base_name = "adpll";
> -		char *buf;
> -
> -		buf = devm_kzalloc(d->dev, 8 + 1 + strlen(base_name) + 1 +
> -				    strlen(postfix), GFP_KERNEL);
> -		if (!buf)
> -			return NULL;
> -		sprintf(buf, "%08lx.%s.%s", d->pa, base_name, postfix);
> -		name = buf;
> +		name = devm_kasprintf(d->dev, GFP_KERNEL, "%08lx.adpll.%s",
> +				      d->pa, postfix);
>  	}
>  
>  	return name;
> -- 
> 2.20.1
> 

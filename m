From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: single: make two arrays static const, reduces
 object code size
Date: Tue, 19 Sep 2017 09:26:37 -0700
Message-ID: <20170919162637.GY5024@atomide.com>
References: <20170919144218.23607-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170919144218.23607-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Colin King <colin.king@canonical.com> [170919 07:43]:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the read-only arrays prop2 and prop4 on the stack, instead
> make them static const.  Makes the object code smaller by over 230 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   28235	   5820	    192	  34247	   85c7	drivers/pinctrl/pinctrl-single.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   27839	   5980	    192	  34011	   84db	drivers/pinctrl/pinctrl-single.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/pinctrl/pinctrl-single.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index b8b3d932cd73..e6cd8de793e2 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -873,13 +873,13 @@ static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
>  	int i = 0, nconfs = 0;
>  	unsigned long *settings = NULL, *s = NULL;
>  	struct pcs_conf_vals *conf = NULL;
> -	struct pcs_conf_type prop2[] = {
> +	static const struct pcs_conf_type prop2[] = {
>  		{ "pinctrl-single,drive-strength", PIN_CONFIG_DRIVE_STRENGTH, },
>  		{ "pinctrl-single,slew-rate", PIN_CONFIG_SLEW_RATE, },
>  		{ "pinctrl-single,input-schmitt", PIN_CONFIG_INPUT_SCHMITT, },
>  		{ "pinctrl-single,low-power-mode", PIN_CONFIG_LOW_POWER_MODE, },
>  	};
> -	struct pcs_conf_type prop4[] = {
> +	static const struct pcs_conf_type prop4[] = {
>  		{ "pinctrl-single,bias-pullup", PIN_CONFIG_BIAS_PULL_UP, },
>  		{ "pinctrl-single,bias-pulldown", PIN_CONFIG_BIAS_PULL_DOWN, },
>  		{ "pinctrl-single,input-schmitt-enable",
> -- 
> 2.14.1
> 

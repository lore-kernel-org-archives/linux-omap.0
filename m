From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] pinctrl: pinctrl-single: Make sure we do not
 change bits outside of mask
Date: Thu, 6 Sep 2012 11:59:38 -0700
Message-ID: <20120906185937.GY1303@atomide.com>
References: <1346835718-21325-1-git-send-email-peter.ujfalusi@ti.com>
 <1346835718-21325-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1346835718-21325-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [120905 02:02]:
> Use the pcs->fmask to make sure that the value is not changing (setting)
> bits in areas where it should not.
> To avoid situations like this:
> 
> pmx_dummy: pinmux@4a100040 {
> 	compatible = "pinctrl-single";
> 	reg = <0x4a100040 0x0196>;
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	pinctrl-single,register-width = <16>;
> 	pinctrl-single,function-mask = <0x00ff>;
> };
> 
> &pmx_dummy {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&board_pins>;
> 
> 	board_pins: pinmux_board_pins {
> 		pinctrl-single,pins = <
> 			0x6c 0xf0f
> 			0x6e 0x10f
> 			0x70 0x23f
> 			0x72 0xa5f
> 		>;
> 	};
> };
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks this is a valid fix:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/pinctrl/pinctrl-single.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 76a4260..3508631 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -337,7 +337,7 @@ static int pcs_enable(struct pinctrl_dev *pctldev, unsigned fselector,
>  		vals = &func->vals[i];
>  		val = pcs->read(vals->reg);
>  		val &= ~pcs->fmask;
> -		val |= vals->val;
> +		val |= (vals->val & pcs->fmask);
>  		pcs->write(val, vals->reg);
>  	}
>  
> -- 
> 1.7.12
> 

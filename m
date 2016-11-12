From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: twl4030_keypad: make driver DT only
Date: Sat, 12 Nov 2016 10:39:37 -0800
Message-ID: <20161112183937.GA5809@dtor-ws>
References: <1478948155-30219-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478948155-30219-1-git-send-email-Nicolae_Rosia@mentor.com>
Sender: linux-input-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Hi Nicolae,

On Sat, Nov 12, 2016 at 12:55:55PM +0200, Nicolae Rosia wrote:
> All users are DT-only and it makes no sense to keep
> unused code
> 

I am looking into converting the matrix keymap code to generic device
properties so that it can be not DT/legacy only; I'll pick up your patch
in a bit (just the bits removing platform data handling).

Thanks.

> Signed-off-by: Nicolae Rosia <Nicolae_Rosia@mentor.com>
> ---
>  drivers/input/keyboard/Kconfig          |  1 +
>  drivers/input/keyboard/twl4030_keypad.c | 32 ++++++++++++--------------------
>  2 files changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index cbd75cf..5c290b6 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -669,6 +669,7 @@ config KEYBOARD_TC3589X
>  config KEYBOARD_TWL4030
>  	tristate "TI TWL4030/TWL5030/TPS659x0 keypad support"
>  	depends on TWL4030_CORE
> +	depends on OF
>  	select INPUT_MATRIXKMAP
>  	help
>  	  Say Y here if your board use the keypad controller on
> diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
> index 323a0fb..af68330 100644
> --- a/drivers/input/keyboard/twl4030_keypad.c
> +++ b/drivers/input/keyboard/twl4030_keypad.c
> @@ -335,13 +335,18 @@ static int twl4030_kp_program(struct twl4030_keypad *kp)
>   */
>  static int twl4030_kp_probe(struct platform_device *pdev)
>  {
> -	struct twl4030_keypad_data *pdata = dev_get_platdata(&pdev->dev);
>  	const struct matrix_keymap_data *keymap_data = NULL;
>  	struct twl4030_keypad *kp;
>  	struct input_dev *input;
> +	struct device_node *np = pdev->dev.of_node;
>  	u8 reg;
>  	int error;
>  
> +	if (!np) {
> +		dev_err(&pdev->dev, "no DT info\n");
> +		return -EINVAL;
> +	}
> +
>  	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
>  	if (!kp)
>  		return -ENOMEM;
> @@ -363,28 +368,17 @@ static int twl4030_kp_probe(struct platform_device *pdev)
>  	input->id.product	= 0x0001;
>  	input->id.version	= 0x0003;
>  
> -	if (pdata) {
> -		if (!pdata->rows || !pdata->cols || !pdata->keymap_data) {
> -			dev_err(&pdev->dev, "Missing platform_data\n");
> -			return -EINVAL;
> -		}
> +	error = matrix_keypad_parse_of_params(&pdev->dev, &kp->n_rows,
> +					      &kp->n_cols);
> +	if (error)
> +		return error;
>  
> -		kp->n_rows = pdata->rows;
> -		kp->n_cols = pdata->cols;
> -		kp->autorepeat = pdata->rep;
> -		keymap_data = pdata->keymap_data;
> -	} else {
> -		error = matrix_keypad_parse_of_params(&pdev->dev, &kp->n_rows,
> -						      &kp->n_cols);
> -		if (error)
> -			return error;
> +	kp->autorepeat = true;
>  
> -		kp->autorepeat = true;
> -	}
>  
>  	if (kp->n_rows > TWL4030_MAX_ROWS || kp->n_cols > TWL4030_MAX_COLS) {
>  		dev_err(&pdev->dev,
> -			"Invalid rows/cols amount specified in platform/devicetree data\n");
> +			"Invalid rows/cols amount specified in DT\n");
>  		return -EINVAL;
>  	}
>  
> @@ -445,13 +439,11 @@ static int twl4030_kp_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id twl4030_keypad_dt_match_table[] = {
>  	{ .compatible = "ti,twl4030-keypad" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, twl4030_keypad_dt_match_table);
> -#endif
>  
>  /*
>   * NOTE: twl4030 are multi-function devices connected via I2C.
> -- 
> 2.5.5
> 

-- 
Dmitry

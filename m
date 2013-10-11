From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Input: twl4030_keypad - add device tree support
Date: Fri, 11 Oct 2013 16:38:33 -0700
Message-ID: <20131011233833.GE29913@atomide.com>
References: <1381353447-32708-1-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381353447-32708-1-git-send-email-sre@debian.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: Sebastian Reichel <sre@ring0.de>, linux-input@vger.kernel.org, =?utf-8?Q?'Beno=C3=AEt?= Cousson' <bcousson@baylibre.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [131009 14:25]:
> Add device tree support for twl4030 keypad driver and update the
> Documentation with twl4030 keypad device tree binding information.
> 
> This patch also adds a twl4030 keypad node to the twl4030.dtsi file,
> so that board files can just add the keymap.
> 
> Tested on Nokia N900.

Nice :) Just few cosmetic comments below.
>  
> +#ifdef CONFIG_OF
> +static int twl4030_keypad_parse_dt(struct device *dev,
> +				 struct twl4030_keypad *keypad_data)
> +{

I guess the way to go nowadays is to use #IS_ENABLED(CONFIG_OF) here
and later on in this patch.

> @@ -331,20 +358,12 @@ static int twl4030_kp_program(struct twl4030_keypad *kp)
>  static int twl4030_kp_probe(struct platform_device *pdev)
>  {
>  	struct twl4030_keypad_data *pdata = pdev->dev.platform_data;
> -	const struct matrix_keymap_data *keymap_data;
> +	const struct matrix_keymap_data *keymap_data = NULL;
>  	struct twl4030_keypad *kp;
>  	struct input_dev *input;
>  	u8 reg;
>  	int error;
>  
> -	if (!pdata || !pdata->rows || !pdata->cols || !pdata->keymap_data ||
> -	    pdata->rows > TWL4030_MAX_ROWS || pdata->cols > TWL4030_MAX_COLS) {
> -		dev_err(&pdev->dev, "Invalid platform_data\n");
> -		return -EINVAL;
> -	}
> -
> -	keymap_data = pdata->keymap_data;
> -
>  	kp = kzalloc(sizeof(*kp), GFP_KERNEL);
>  	input = input_allocate_device();
>  	if (!kp || !input) {

I assume you have tested the above so it does not break things
for legacy booting?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>

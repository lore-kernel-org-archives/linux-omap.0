From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v6 8/8] Input: omap4 - pm runtime
Date: Thu, 30 Sep 2010 06:51:25 -0700
Message-ID: <87aamzl4pu.fsf@deeprootsystems.com>
References: <1285825000-25622-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1285825000-25622-1-git-send-email-x0066660@ti.com> (Abraham
	Arce's message of "Thu, 30 Sep 2010 00:36:40 -0500")
Sender: linux-input-owner@vger.kernel.org
To: Abraham Arce <x0066660@ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Abraham Arce <x0066660@ti.com> writes:

> Enable pm runtime in driver

So power is enabled on probe and cut on _remove().  Did you consider
doing any more fine grained PM for this device?  For example, cutting
power after some inactivity timer and re-enabling on a
keypress/interrupt?

Kevin



> Reviewed-by: Basak, Partha <p-basak2@ti.com>
> Signed-off-by: Abraham Arce <x0066660@ti.com>
> ---
>  drivers/input/keyboard/omap4-keypad.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index 45bd097..ed47e9a 100644
> --- a/drivers/input/keyboard/omap4-keypad.c
> +++ b/drivers/input/keyboard/omap4-keypad.c
> @@ -29,6 +29,7 @@
>  #include <linux/io.h>
>  #include <linux/input.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <plat/omap4-keypad.h>
>  
> @@ -239,6 +240,9 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>  	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
>  			input_dev->keycode, input_dev->keybit);
>  
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
>  	omap4_keypad_config(keypad_data);
>  
>  	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
> @@ -277,6 +281,9 @@ static int __devexit omap4_keypad_remove(struct platform_device *pdev)
>  	struct omap4_keypad *keypad_data = platform_get_drvdata(pdev);
>  	struct resource *res;
>  
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
>  	free_irq(keypad_data->irq, keypad_data);
>  	input_unregister_device(keypad_data->input);

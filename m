From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v7] OMAP4:keypad: PM runtime
Date: Tue, 14 Dec 2010 09:25:43 -0800
Message-ID: <8739q0w9k8.fsf@deeprootsystems.com>
References: <1292341137-14783-1-git-send-email-a0393217@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42615 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759489Ab0LNRZv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 12:25:51 -0500
In-Reply-To: <1292341137-14783-1-git-send-email-a0393217@india.ti.com>
	(Shubhrajyoti D.'s message of "Tue, 14 Dec 2010 21:08:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <a0393217@india.ti.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Abraham Arce <x0066660@ti.com>

Shubhrajyoti D <a0393217@india.ti.com> writes:

> From: Abraham Arce <x0066660@ti.com>
>
> Enable Runtime PM functionality in OMAP4 driver based on the following assumptions
> - Runtime PM selected by ARCH_OMAP2PLUS_TYPICAL && ARCH_OMAP2PLUS,
>   which is the default OMAP2+ defconfig including OMAP4

this does not need to be stated in the changelog

> - Runtime PM APIs handles Clock Framework APIs

OMAP Runtime PM does much more than handle clocks.

> - Do not do the keypadconfig if the irq request fails

This is a separate fix, unrelated to enabling runtime PM.

> A minimal pm runtime get/put approach is implemented in probe/remove calls
> respectively based on:
>
> - Keyboard controller in wakeup domain so it is always on and
>   power impact may be minimal
> - Cutting of clocks will prevent interrupts

Again, please describe in more detail why preventing interrupts causes a
problem.    I understand it may seem obvious right now, but these
changelogs  need to be understandable many months/years down the road.

Kevin

> Signed-off-by: Abraham Arce <x0066660@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Updating the changelogs as per Kevin's suggestion
>
>  drivers/input/keyboard/omap4-keypad.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
> index 45bd097..36239e2 100644
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
> @@ -239,7 +240,8 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>  	matrix_keypad_build_keymap(pdata->keymap_data, row_shift,
>  			input_dev->keycode, input_dev->keybit);
>  
> -	omap4_keypad_config(keypad_data);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
>  
>  	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
>  			     IRQF_TRIGGER_RISING,
> @@ -255,8 +257,9 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
>  		goto err_free_irq;
>  	}
>  
> -
> +	omap4_keypad_config(keypad_data);
>  	platform_set_drvdata(pdev, keypad_data);
> +
>  	return 0;
>  
>  err_free_irq:
> @@ -278,6 +281,10 @@ static int __devexit omap4_keypad_remove(struct platform_device *pdev)
>  	struct resource *res;
>  
>  	free_irq(keypad_data->irq, keypad_data);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
>  	input_unregister_device(keypad_data->input);
>  
>  	iounmap(keypad_data->base);

From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 6/6] mfd: twl-core: Make it explicitly non-modular
Date: Fri, 5 Aug 2016 13:58:22 +0100
Message-ID: <20160805125822.GE5243@dell>
References: <20160705012544.14143-1-paul.gortmaker@windriver.com>
 <20160705012544.14143-7-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160705012544.14143-7-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 04 Jul 2016, Paul Gortmaker wrote:

> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config TWL4030_CORE
> drivers/mfd/Kconfig:    bool "TI TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove what modular code that we can, so that when reading the
> driver there is less doubt that it is builtin-only.  Note that we can't
> remove the twl_remove() itself ; it is still used by the probe unwind
> routine.  So we leave it linked into the .remove as well, even though
> it will most likely never be called via that path from an unbind.
> 
> Since module_i2c_driver() uses the same init level priority as
> builtin_i2c_driver() the init ordering remains unchanged with
> this commit.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/mfd/twl-core.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index a49d3db6d936..c64615dca2bd 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -30,7 +30,6 @@
>  
>  #include <linux/init.h>
>  #include <linux/mutex.h>
> -#include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/clk.h>
> @@ -1258,7 +1257,6 @@ static const struct i2c_device_id twl_ids[] = {
>  	{ "twl6032", TWL6030_CLASS | TWL6032_SUBCLASS }, /* "Phoenix lite" */
>  	{ /* end of list */ },
>  };
> -MODULE_DEVICE_TABLE(i2c, twl_ids);
>  
>  /* One Client Driver , 4 Clients */
>  static struct i2c_driver twl_driver = {
> @@ -1267,9 +1265,4 @@ static struct i2c_driver twl_driver = {
>  	.probe		= twl_probe,
>  	.remove		= twl_remove,
>  };
> -
> -module_i2c_driver(twl_driver);
> -
> -MODULE_AUTHOR("Texas Instruments, Inc.");
> -MODULE_DESCRIPTION("I2C Core interface for TWL");
> -MODULE_LICENSE("GPL");
> +builtin_i2c_driver(twl_driver);

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

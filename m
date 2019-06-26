From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 01/30] include: linux: platform_device: more helpers for
 declaring platform drivers
Date: Wed, 26 Jun 2019 08:14:05 +0200
Message-ID: <20190626061405.qsqq5na4oactuo6f@pengutronix.de>
References: <1560796871-18560-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560796871-18560-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, mcoquelin.stm32@gmail.com, thloh@altera.com, festevam@gmail.com, linus.walleij@linaro.org, khilman@kernel.org, patches@opensource.cirrus.com, bgolaszewski@baylibre.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, ssantosh@kernel.org, linux-tegra@vger.kernel.org, andriy.shevchenko@linux.intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de, alexandre.torgue@st.com
List-Id: linux-omap@vger.kernel.org

Hello,

On Mon, Jun 17, 2019 at 08:40:42PM +0200, Enrico Weigelt, metux IT consult wrote:
> From: Enrico Weigelt <info@metux.net>
> 
> Add more helper macros for trivial driver init cases, similar to the
> already existing module_platform_driver()+friends - now for those which
> are initialized at other stages. Lots of drivers couldn't use the existing
> macros, as they need to be called at different init stages, eg. subsys,
> postcore, arch.
> 
> This helps to further reduce driver init boilerplate.
> 
> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  include/linux/platform_device.h | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index beb25f2..5f3a967 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -259,6 +259,57 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
>  } \
>  module_exit(__platform_driver##_exit);
>  
> +/* postcore_platform_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces postcore_initcall() and module_exit()
> + */
> +#define postcore_platform_driver(__platform_driver) \
> +static int __init __platform_driver##_init(void) \
> +{ \
> +	return platform_driver_register(&(__platform_driver)); \
> +} \
> +postcore_initcall(__platform_driver##_init); \
> +static void __exit __platform_driver##_exit(void) \
> +{ \
> +	platform_driver_unregister(&(__platform_driver)); \
> +} \
> +module_exit(__platform_driver##_exit);
> +
> +/* subsys_platform_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces subsys_initcall() and module_exit()
> + */
> +#define subsys_platform_driver(__platform_driver) \
> +static int __init __platform_driver##_init(void) \
> +{ \
> +	return platform_driver_register(&(__platform_driver)); \
> +} \
> +subsys_initcall(__platform_driver##_init); \
> +static void __exit __platform_driver##_exit(void) \
> +{ \
> +	platform_driver_unregister(&(__platform_driver)); \
> +} \
> +module_exit(__platform_driver##_exit);

Would it make sense to do something like:

	#define __module_platform_driver(__platform_driver, __initlvl) \
	static int __init __platform_driver##_init(void) \
	{ \
		return platform_driver_register(&(__platform_driver)); \
	} \
	__initlvl ## _initcall(__platform_driver##_init); \
	static void __exit __platform_driver##_exit(void) \
	{ \
		platform_driver_unregister(&(__platform_driver)); \
	} \
	module_exit(__platform_driver##_exit);

	#define postcore_platform_driver(__platform_driver) __module_platform_driver(__platform_driver, postcore)
	#define subsys_platform_driver(__platform_driver) __module_platform_driver(__platform_driver, subsys)
	...

Which would be more compact and makes the difference between these
macros a bit more obvious.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 01/30] include: linux: platform_device: more helpers for
 declaring platform drivers
Date: Wed, 26 Jun 2019 19:27:02 +0200
Message-ID: <30f541a7-ef9d-d687-ab76-22a4544258f8@metux.net>
References: <1560796871-18560-1-git-send-email-info@metux.net>
 <20190626061405.qsqq5na4oactuo6f@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190626061405.qsqq5na4oactuo6f@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, mcoquelin.stm32@gmail.com, thloh@altera.com, festevam@gmail.com, linus.walleij@linaro.org, khilman@kernel.org, patches@opensource.cirrus.com, bgolaszewski@baylibre.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, ssantosh@kernel.org, linux-tegra@vger.kernel.org, andriy.shevchenko@linux.intel.com, shawnguo@kernel.org, s.hauer@pengutronix.de, alexandre.torgue@st.com
List-Id: linux-omap@vger.kernel.org

On 26.06.19 08:14, Uwe Kleine-König wrote:
Hi,

> Would it make sense to do something like:
>
> 	#define __module_platform_driver(__platform_driver, __initlvl) \
> 	static int __init __platform_driver##_init(void) \
> 	{ \
> 		return platform_driver_register(&(__platform_driver)); \
> 	} \
> 	__initlvl ## _initcall(__platform_driver##_init); \
> 	static void __exit __platform_driver##_exit(void) \
> 	{ \
> 		platform_driver_unregister(&(__platform_driver)); \
> 	} \
> 	module_exit(__platform_driver##_exit);
>
> 	#define postcore_platform_driver(__platform_driver)
__module_platform_driver(__platform_driver, postcore)
> 	#define subsys_platform_driver(__platform_driver)
__module_platform_driver(__platform_driver, subsys)
> 	...
>
> Which would be more compact and makes the difference between these
> macros a bit more obvious.
yeah, could do that, but not sure whether it's really good for
readability when we have so many nested macros :p

OTOH, I didn't want to touch the existing macros for now, just trim down
the actual init boilerplate, postponing further compactions for later.

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

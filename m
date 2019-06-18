From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 01/30] include: linux: platform_device: more helpers for
 declaring platform drivers
Date: Tue, 18 Jun 2019 11:57:27 +0300
Message-ID: <20190618085727.GJ9224@smile.fi.intel.com>
References: <1560796871-18560-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560796871-18560-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, thloh@altera.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, patches@opensource.cirrus.com
List-Id: linux-omap@vger.kernel.org

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

> +/* postcore_platform_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces postcore_initcall() and module_exit()
> + */

Perhaps you meant kernel-doc format?

-- 
With Best Regards,
Andy Shevchenko

From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v2 6/7] ARM: OMAP3: Use .teardown of twl4030-gpio to clean
 board requests
Date: Thu, 23 Feb 2012 16:55:35 +0200
Message-ID: <4F465367.3010205@compulab.co.il>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com> <1329997247-27342-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:32772
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755335Ab2BWOzw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 09:55:52 -0500
In-Reply-To: <1329997247-27342-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>, Steve Sakoman <sakoman@gmail.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Rajendra,

On 02/23/12 13:40, Rajendra Nayak wrote:
> All OMAP3 boards which register a .setup function with twl4030
> gpio driver do not seem to have a .teardown hook implemented.
> .setup mainly requests a few gpios and also in most cases
> does a omap_hsmmc_deferred_add(). Have a .teardown do a gpio_free()
> and of the requested gpios and also do a omap_hsmmc_deferred_del().
> This helps in case the twl4030 gpio driver is built as a module and
> added and removed multiple times. Without the .teardown a multiple
> insmod/rmmod can result in gpio request failues and also WARN messages
> stating addition of already registered mmc devices.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c          |   10 ++++++++++
>  arch/arm/mach-omap2/board-cm-t35.c           |    8 ++++++++
>  arch/arm/mach-omap2/board-devkit8000.c       |   10 ++++++++++
>  arch/arm/mach-omap2/board-igep0020.c         |   14 ++++++++++++++
>  arch/arm/mach-omap2/board-ldp.c              |    9 +++++++++
>  arch/arm/mach-omap2/board-omap3beagle.c      |   12 ++++++++++++
>  arch/arm/mach-omap2/board-omap3evm.c         |   10 ++++++++++
>  arch/arm/mach-omap2/board-omap3pandora.c     |    9 +++++++++
>  arch/arm/mach-omap2/board-omap3stalker.c     |   11 +++++++++++
>  arch/arm/mach-omap2/board-omap3touchbook.c   |   10 ++++++++++
>  arch/arm/mach-omap2/board-overo.c            |    8 ++++++++
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    8 ++++++++
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    9 +++++++++
>  arch/arm/mach-omap2/hsmmc.c                  |   11 +++++++++++
>  arch/arm/mach-omap2/hsmmc.h                  |    4 ++++
>  15 files changed, 143 insertions(+), 0 deletions(-)

[...]

> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 14df109..55e0180 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -475,11 +475,19 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
>  	return 0;
>  }
>  
> +static int cm_t35_twl_gpio_teardown(struct device *dev, unsigned gpio,
> +				 unsigned ngpio)
> +{
> +	omap_hsmmc_deferred_del(mmc);
> +	gpio_free(gpio + 2);
> +	return 0;
> +}

Can we have an empty line here?

>  static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
>  	.gpio_base	= OMAP_MAX_GPIO_LINES,
>  	.irq_base	= TWL4030_GPIO_IRQ_BASE,
>  	.irq_end	= TWL4030_GPIO_IRQ_END,
>  	.setup          = cm_t35_twl_gpio_setup,
> +	.teardown	= cm_t35_twl_gpio_teardown,
>  };
>  
>  static struct twl4030_platform_data cm_t35_twldata = {

[...]

> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 11a6aa4..1d0850f 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -435,12 +435,26 @@ static int igep_twl_gpio_setup(struct device *dev,
>  	return 0;
>  };
>  
> +static int igep_twl_gpio_teardown(struct device *dev,
> +		unsigned gpio, unsigned ngpio)
> +{
> +	omap_hsmmc_deferred_del(mmc);
> +	gpio_free(gpio + TWL4030_GPIO_MAX + 1);
> +	if (machine_is_igep0030())
> +		return 0;
> +
> +	gpio_free(gpio + 1);
> +	gpio_free(gpio + TWL4030_GPIO_MAX);

gpio_free_array()?

> +	return 0;
> +}
> +
>  static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
>  	.gpio_base	= OMAP_MAX_GPIO_LINES,
>  	.irq_base	= TWL4030_GPIO_IRQ_BASE,
>  	.irq_end	= TWL4030_GPIO_IRQ_END,
>  	.use_leds	= true,
>  	.setup		= igep_twl_gpio_setup,
> +	.teardown	= igep_twl_gpio_teardown,
>  };
>  
>  static int igep2_enable_dvi(struct omap_dss_device *dssdev)

[...]

> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index 8b6065b..e1f496d 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -419,12 +419,20 @@ static int overo_twl_gpio_setup(struct device *dev,
>  	return 0;
>  }
>  
> +static int overo_twl_gpio_teardown(struct device *dev,
> +		unsigned gpio, unsigned ngpio)
> +{
> +	omap_hsmmc_deferred_del(mmc);

If Overo will not have omap_hsmmc_deferred_add() (as for my comment to
the previous patch), then no need for the omap_hsmmc_deferred_del().

> +	return 0;
> +}
> +
>  static struct twl4030_gpio_platform_data overo_gpio_data = {
>  	.gpio_base	= OMAP_MAX_GPIO_LINES,
>  	.irq_base	= TWL4030_GPIO_IRQ_BASE,
>  	.irq_end	= TWL4030_GPIO_IRQ_END,
>  	.use_leds	= true,
>  	.setup		= overo_twl_gpio_setup,
> +	.teardown	= overo_twl_gpio_teardown,
>  };
>  
>  static struct regulator_init_data overo_vmmc1 = {

[...]

> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 51e3a2d..0f256ca 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -541,6 +541,17 @@ void omap_hsmmc_deferred_add(struct omap2_hsmmc_info *controllers)
>  	}
>  }
>  
> +void omap_hsmmc_deferred_del(struct omap2_hsmmc_info *controllers)
> +{
> +	struct platform_device *pdev;
> +	for (; controllers->mmc; controllers++) {
> +		if (!controllers->deferred)
> +			continue;
> +		pdev = controllers->pdev;
> +		omap_device_unregister(pdev);

Just:

if (controllers->deferred)
	omap_device_unregister(controllers->pdev);

and no need for the for loop brackets?

> +	}
> +}
> +
>  void omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  {
>  	u32 reg;

[...]


- -- 
Regards,
Igor.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPRlNnAAoJEBDE8YO64EfabxYP/0/4OVAirTFzPpyJfkAXHeKI
+CeAQN+/aPChvkJ2cuxarR/RdfJjOZNyLDh9t01Hs8RMgOQF2tIhxkHsxsATfQoa
80pXX+eyq4cDcyy+knDm/2Nhr6smsZLRGyw5IvuuVyL4yzyQDe8XZUnr2X58Us0F
0wm7+JtzGkFQxjhxj6Dqh5XaeOi6qTHsO9DG342d6/2ps/Dc/E0J4d9l06EykCzH
l/QFYA5NBuhbVXJOOheosr1z8yD+BQUg/oOUDU7yl3Dzhat9ka348iYrK1ndy4Us
DWV/4oOt7MOqKozscsLwLuWqfSQMupXc0AJGrFLrDeimj0vAlXSIUL7WRA7Kx9E1
DV4UZZYIRseqIia7FbIjxvevW5XIfm149G+4XFzrmCz48OCpVDs/KSJpqtNNpS0q
IkxQdE4AIpj6VzSzeARMSL0iqucB7BZGZFtv0E41RWHe5UFiQ/QnsBSc2nNJxBlt
UAyW/Baya+zL9F1SrcMwufKCFngxae5WBfEi1MqHPTBOmQm9kAlxGSHryZ1xPgL3
/xrJEeDw9kfyAFgWJHckHNyiDxx85yrv6zeX/hyk2j5VzmuEaW1+ETx07oF+sssB
+3Bz+qJJMSMl8bvzGMafZCRMfu4Hv0UbQh8gnY6Dx16zMAccCIu5qv3iAO+vwkSM
RH841I5wPtu6TTZRWGrj
=WzOO
-----END PGP SIGNATURE-----

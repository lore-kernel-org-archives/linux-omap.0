From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] gpio: Use new GPIO_LINE_DIRECTION
Date: Wed, 6 Nov 2019 16:22:26 +0200
Message-ID: <20191106142226.GB32742@smile.fi.intel.com>
References: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
 <42f40109e2926bca197b30fd9624c609653b23e5.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <42f40109e2926bca197b30fd9624c609653b23e5.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-aspeed@lists.ozlabs.org, David Daney <david.daney@cavium.com>, Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org, Peter Tyser <ptyser@xes-inc.com>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jonathan Hunter <jonathanh@nvidia.com>, Fabio Estevam <festevam@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Marek Vasut <marek.vasut+renesas@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Marek Behun <marek.behun@nic.cz>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, bcm-kernel-feedback-list@broadcom.com, Joel Stanley <joel@jms.id.au>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 06, 2019 at 10:54:12AM +0200, Matti Vaittinen wrote:
> It's hard for occasional GPIO code reader/writer to know if values 0/1
> equal to IN or OUT. Use defined GPIO_LINE_DIRECTION_IN and
> GPIO_LINE_DIRECTION_OUT to help them out.
> 
> NOTE - for gpio-amd-fch and gpio-bd9571mwv:
> This commit also changes the return value for direction get to equal 1
> for direction INPUT. Prior this commit these drivers might have
> returned some other positive value but 1 for INPUT.

>  drivers/gpio/gpio-ich.c             |  5 ++++-

>  drivers/gpio/gpio-merrifield.c      |  5 ++++-

>  drivers/gpio/gpio-pca953x.c         |  5 ++++-

>  drivers/gpio/gpio-sch.c             |  5 ++++-

>  drivers/gpio/gpio-wcove.c           |  7 +++++--

Since maintainers seems in favour of this and bloat-o-meter shows no difference
on selected module,

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for the stuff I'm involved in.

Thanks!

> diff --git a/drivers/gpio/gpio-ich.c b/drivers/gpio/gpio-ich.c
> index 90bf7742f9b0..2f086d0aa1f4 100644
> --- a/drivers/gpio/gpio-ich.c
> +++ b/drivers/gpio/gpio-ich.c
> @@ -159,7 +159,10 @@ static bool ichx_gpio_check_available(struct gpio_chip *gpio, unsigned nr)
>  
>  static int ichx_gpio_get_direction(struct gpio_chip *gpio, unsigned nr)
>  {
> -	return ichx_read_bit(GPIO_IO_SEL, nr);
> +	if (ichx_read_bit(GPIO_IO_SEL, nr))
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
>  }
>  
>  static int ichx_gpio_direction_input(struct gpio_chip *gpio, unsigned nr)

> diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
> index 2f1e9da81c1e..d4fa6e9560f3 100644
> --- a/drivers/gpio/gpio-merrifield.c
> +++ b/drivers/gpio/gpio-merrifield.c
> @@ -162,7 +162,10 @@ static int mrfld_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
>  {
>  	void __iomem *gpdr = gpio_reg(chip, offset, GPDR);
>  
> -	return !(readl(gpdr) & BIT(offset % 32));
> +	if (readl(gpdr) & BIT(offset % 32))
> +		return GPIO_LINE_DIRECTION_OUT;
> +
> +	return GPIO_LINE_DIRECTION_IN;
>  }
>  
>  static int mrfld_gpio_set_debounce(struct gpio_chip *chip, unsigned int offset,

> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index de5d1383f28d..82122c3c688a 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -449,7 +449,10 @@ static int pca953x_gpio_get_direction(struct gpio_chip *gc, unsigned off)
>  	if (ret < 0)
>  		return ret;
>  
> -	return !!(reg_val & bit);
> +	if (reg_val & bit)
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
>  }
>  
>  static void pca953x_gpio_set_multiple(struct gpio_chip *gc,

> diff --git a/drivers/gpio/gpio-sch.c b/drivers/gpio/gpio-sch.c
> index fb143f28c386..c65f35b68202 100644
> --- a/drivers/gpio/gpio-sch.c
> +++ b/drivers/gpio/gpio-sch.c
> @@ -127,7 +127,10 @@ static int sch_gpio_get_direction(struct gpio_chip *gc, unsigned gpio_num)
>  {
>  	struct sch_gpio *sch = gpiochip_get_data(gc);
>  
> -	return sch_gpio_reg_get(sch, gpio_num, GIO);
> +	if (sch_gpio_reg_get(sch, gpio_num, GIO))
> +		return GPIO_LINE_DIRECTION_IN;
> +
> +	return GPIO_LINE_DIRECTION_OUT;
>  }
>  
>  static const struct gpio_chip sch_gpio_chip = {

> diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
> index 444fe9e7f04a..8b481b3c1ebe 100644
> --- a/drivers/gpio/gpio-wcove.c
> +++ b/drivers/gpio/gpio-wcove.c
> @@ -170,13 +170,16 @@ static int wcove_gpio_get_direction(struct gpio_chip *chip, unsigned int gpio)
>  	int ret, reg = to_reg(gpio, CTRL_OUT);
>  
>  	if (reg < 0)
> -		return 0;
> +		return GPIO_LINE_DIRECTION_OUT;
>  
>  	ret = regmap_read(wg->regmap, reg, &val);
>  	if (ret)
>  		return ret;
>  
> -	return !(val & CTLO_DIR_OUT);
> +	if (val & CTLO_DIR_OUT)
> +		return GPIO_LINE_DIRECTION_OUT;
> +
> +	return GPIO_LINE_DIRECTION_IN;
>  }
>  
>  static int wcove_gpio_get(struct gpio_chip *chip, unsigned int gpio)


-- 
With Best Regards,
Andy Shevchenko

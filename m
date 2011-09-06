From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] OMAP: hsmmc: Fix mux for non-OMAP pins
Date: Tue, 6 Sep 2011 10:14:16 +0200
Message-ID: <20110906081416.GC28816@pengutronix.de>
References: <4E6538A1.5090204@gmail.com>
	<1315296483-8442-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1315296483-8442-1-git-send-email-weber@corscience.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Weber <weber@corscience.de>
Cc: Russell King <linux@arm.linux.org.uk>, silesh@ti.com, Tony Lindgren <tony@atomide.com>, open list <linux-kernel@vger.kernel.org>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hello Thomas,

On Tue, Sep 06, 2011 at 10:08:03AM +0200, Thomas Weber wrote:
> The Devkit8000 uses a TWL4030 pin for card detection.
> Thats why the error:
> _omap_mux_init_gpio: Could not set gpio192
> occurs.
> =

> This patch checks that the pin is on OMAP before
> calling omap_mux_init_gpio.
> =

> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
>  arch/arm/mach-omap2/hsmmc.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> =

> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index a9b45c7..783d0f1 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -214,10 +214,12 @@ static int nop_mmc_set_power(struct device *dev, in=
t slot, int power_on,
>  static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_con=
troller,
>  			int controller_nr)
>  {
> -	if (gpio_is_valid(mmc_controller->slots[0].switch_pin))
> +	if (gpio_is_valid(mmc_controller->slots[0].switch_pin) && \
That backslash at the line end is not needed and looks ugly.

> +		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
>  		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
>  					OMAP_PIN_INPUT_PULLUP);
> -	if (gpio_is_valid(mmc_controller->slots[0].gpio_wp))
> +	if (gpio_is_valid(mmc_controller->slots[0].gpio_wp) && \
> +		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
>  		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
>  					OMAP_PIN_INPUT_PULLUP);
>  	if (cpu_is_omap34xx()) {

Best regards
Uwe


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

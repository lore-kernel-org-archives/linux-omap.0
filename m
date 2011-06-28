From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] OMAP: HSMMC: Fix GPIO muxing
Date: Tue, 28 Jun 2011 17:07:05 +0530
Message-ID: <BANLkTin39hkDNa+v=29PLMZRdBtWGCfseA@mail.gmail.com>
References: <1309250759-18472-1-git-send-email-silesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309250759-18472-1-git-send-email-silesh@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Silesh C V <silesh@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "kishore.kadiyala" <kishore.kadiyala@ti.com>, balajitk <balajitk@ti.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jun 28, 2011 at 2:15 PM, Silesh C V <silesh@ti.com> wrote:
> Use generic gpio call to check the validity of the gpio. Note that
> this includes gpio 0 also which was missing before.
>
> Signed-off-by: Silesh C V <silesh@ti.com>
> ---
> =A0arch/arm/mach-omap2/hsmmc.c | =A0 =A07 +++----
> =A01 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 66868c5..a9b45c7 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -13,6 +13,7 @@
> =A0#include <linux/slab.h>
> =A0#include <linux/string.h>
> =A0#include <linux/delay.h>
> +#include <linux/gpio.h>
> =A0#include <mach/hardware.h>
> =A0#include <plat/mmc.h>
> =A0#include <plat/omap-pm.h>
> @@ -213,12 +214,10 @@ static int nop_mmc_set_power(struct device *dev, in=
t slot, int power_on,
> =A0static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_c=
ontroller,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int controller_nr)
> =A0{
> - =A0 =A0 =A0 if ((mmc_controller->slots[0].switch_pin > 0) && \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_controller->slots[0].switch_pin < OMAP=
_MAX_GPIO_LINES))
> + =A0 =A0 =A0 if (gpio_is_valid(mmc_controller->slots[0].switch_pin))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_mux_init_gpio(mmc_controller->slots[0=
].switch_pin,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0OMAP_PIN_INPUT_PULLUP);
> - =A0 =A0 =A0 if ((mmc_controller->slots[0].gpio_wp > 0) && \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_controller->slots[0].gpio_wp < OMAP_MA=
X_GPIO_LINES))
> + =A0 =A0 =A0 if (gpio_is_valid(mmc_controller->slots[0].gpio_wp))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_mux_init_gpio(mmc_controller->slots[0=
].gpio_wp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0OMAP_PIN_INPUT_PULLUP);
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx()) {
> --
> 1.7.1
>

Looks good to me.
Reviewed-by: Venkatraman S <svenkatr@ti.com>

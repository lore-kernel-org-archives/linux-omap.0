From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2] gpio: omap: refresh patch "be more aggressive with
 pm_runtime" against v3.12-rc5
Date: Fri, 29 Nov 2013 12:04:50 -0500
Message-ID: <5298C932.60709@ti.com>
References: <1385506004-14943-1-git-send-email-caesarxuchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1385506004-14943-1-git-send-email-caesarxuchao@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Chao Xu <caesarxuchao@gmail.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, balbi@ti.com, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

Adding Kevin's Linaro id, + Nishant,

On Tuesday 26 November 2013 05:46 PM, Chao Xu wrote:
> From: Felipe Balbi <balbi@ti.com>
>=20
> try to keep gpio block suspended as much as possible.
>=20
> Tested with pandaboard and a sysfs exported gpio.
>=20
> Signed-off-by: Felipe Balbi <balbi at ti.com>
>=20
> [caesarxuchao@gmail.com : Refreshed against v3.12-rc5, and added revi=
sion check to enable aggressive pm_runtime on OMAP4-only. Because am33x=
x_gpio_sysc.idlemodes seems to be wrongly marked as SIDLE_SMART_WKUP, w=
hich might cause missed interrupts with this patch. Tested on Pandaboar=
d rev A2.]
>=20
Please format the text and limit it to 80 char rule.

> Signed-off-by: Chao Xu <caesarxuchao@gmail.com>
> ---
> According to Mr. Felipe Balbi, the original patch was not accepted be=
cause interrupts would be missed when GPIO was used as IRQ source. But =
in my tests with pandaboard, interrupts were not missed. This is becaus=
e _idle_sysc() sets the idlemode of gpio module to smart-idle-wakeup, a=
nd according to OMAP4430 TRM, under this idlemode, the gpio can generat=
e an asynchronous wakeup request to the PRCM. And after GPIO is awake, =
the wake-up request is reflected into the interrupt status registers.=20
>=20
> A change made on the original patch is only applying the aggressive r=
untime pm scheme on OMAP4, because I don=E2=80=99t have HW to test OMAP=
3 or am33xx devices. According to the respective TRMs, their GPIO modul=
es also can generate wake-up request if the idlemode is set to smart-id=
le or smart-idle-wakeup. So the patch should work for them, too. But I =
suspect a potential SW bug may cause missed interrupts: the am33xx_gpio=
_sysc.idlemodes is marked as capable of SIDLE_SMART_WKUP in omap_hwmod_=
33xx.c. But according to AM335x TRM, _only_ gpio0 is capable of this mo=
de. This may make GPIO stuck in force-idle mode and unable to generate =
wakeup request. And thus interrupt will be missed. Again, I don=E2=80=99=
t have the HW to verify whether this is a bug or not :(
>=20
In general I am not against this idea but patch has many assumptions wh=
ich
are not entirely correct.

- SMART_WAKEUP will take care of waking IP etc not always true to power
domain getting into idle.

- If we want to go on this path then I would like to see we address
omap2_gpio_[prepare/resumne]_for_idle()

- GPIO though sound simple is one of the most notorious IP block
on PM front so this needs lot of testing. This patch not seems be
tested at all so I would have much liked it to be in RFC/RFT
state.

>  drivers/gpio/gpio-omap.c                |  103 +++++++++++++++++++++=
+++++-----
>  include/linux/platform_data/gpio-omap.h |    1 +
>  2 files changed, 87 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 89675f8..90661f2 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -76,6 +76,7 @@ struct gpio_bank {
>  	int context_loss_count;
>  	int power_mode;
>  	bool workaround_enabled;
> +	bool is_aggressive_pm;
> =20
>  	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
>  	int (*get_context_loss_count)(struct device *dev);
> @@ -473,8 +474,15 @@ static void _disable_gpio_module(struct gpio_ban=
k *bank, unsigned offset)
>  static int gpio_is_input(struct gpio_bank *bank, int mask)
>  {
>  	void __iomem *reg =3D bank->base + bank->regs->direction;
> +	u32 val;
> =20
> -	return __raw_readl(reg) & mask;
> +	if (bank->is_aggressive_pm)
> +		pm_runtime_get_sync(bank->dev);
> +	val =3D __raw_readl(reg) & mask;
> +	if (bank->is_aggressive_pm)
> +		pm_runtime_put(bank->dev);
> +
Move above in some wrapper instead of sprinkling the
'is_aggressive_pm' check everywhere.
 =20
> @@ -1585,18 +1651,21 @@ static const struct omap_gpio_platform_data o=
map2_pdata =3D {
>  	.regs =3D &omap2_gpio_regs,
>  	.bank_width =3D 32,
>  	.dbck_flag =3D false,
> +	.is_aggressive_pm =3D false,
>  };
> =20
>  static const struct omap_gpio_platform_data omap3_pdata =3D {
>  	.regs =3D &omap2_gpio_regs,
>  	.bank_width =3D 32,
>  	.dbck_flag =3D true,
> +	.is_aggressive_pm =3D false,
>  };
> =20
>  static const struct omap_gpio_platform_data omap4_pdata =3D {
>  	.regs =3D &omap4_gpio_regs,
>  	.bank_width =3D 32,
>  	.dbck_flag =3D true,
> +	.is_aggressive_pm =3D true,
>  };
> =20
Well OMAP IP shouldn't have different behavior on OMAP3 and
OMAP4 at least so something you can enable for OMAP4, you
should be able to do it for OMAP3 as well.

Kevin might have some more concerns to add.

Regards,
Santosh

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

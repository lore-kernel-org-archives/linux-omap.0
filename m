From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv3 1/2] OMAP3: Devkit8000: Change lcd power pin
Date: Tue, 18 Jan 2011 14:32:04 +0530
Message-ID: <AANLkTikK5z7LZCRMBzQ5i_W77HdKfU1iePZR6S_fsKOY@mail.gmail.com>
References: <1295333932-23935-1-git-send-email-weber@corscience.de> <1295333932-23935-2-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295333932-23935-2-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Morsing <daniel.morsing@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 12:28, Thomas Weber <weber@corscience.de> wrote=
:
> This patch fixes a wrongly used lcd enable pin.
>
> The Devkit8000 uses twl4030_ledA configured as output gpio only for t=
he
> lcd enable line. twl4030_gpio.1 is used through the generic gpio func=
tions
> while ledA is used via low level twl4030 calls.
>
> Remove the low level calls and use the generic gpio functions for
> initialization and use of ledA.
>
> This also fixes a bug where the lcd would not power down when blankin=
g.
>
> Fix indentation issue. The comment line uses 8 whitespace.
> This is replaced with one tabulator.
>
> Reported-by: Daniel Morsing <daniel.morsing@gmail.com>
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
> =A0arch/arm/mach-omap2/board-devkit8000.c | =A0 =A07 ++-----
> =A01 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-o=
map2/board-devkit8000.c
> index 451e7ff..719f4e5 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -114,9 +114,6 @@ static struct omap2_hsmmc_info mmc[] =3D {
>
> =A0static int devkit8000_panel_enable_lcd(struct omap_dss_device *dss=
dev)
> =A0{
> - =A0 =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_GPIO, 0x80, REG_GPIODAT=
ADIR1);
> - =A0 =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_LED, 0x0, 0x0);
> -
> =A0 =A0 =A0 =A0if (gpio_is_valid(dssdev->reset_gpio))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_set_value_cansleep(dssdev->reset_=
gpio, 1);
> =A0 =A0 =A0 =A0return 0;
> @@ -245,8 +242,8 @@ static int devkit8000_twl_gpio_setup(struct devic=
e *dev,
> =A0 =A0 =A0 =A0/* TWL4030_GPIO_MAX + 1 =3D=3D ledB, PMU_STAT (out, ac=
tive low LED) */
> =A0 =A0 =A0 =A0gpio_leds[2].gpio =3D gpio + TWL4030_GPIO_MAX + 1;
>
> - =A0 =A0 =A0 =A0/* gpio + 1 is "LCD_PWREN" (out, active high) */
> - =A0 =A0 =A0 devkit8000_lcd_device.reset_gpio =3D gpio + 1;
> + =A0 =A0 =A0 /* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active hig=
h) */
> + =A0 =A0 =A0 devkit8000_lcd_device.reset_gpio =3D gpio + TWL4030_GPI=
O_MAX + 0;
> =A0 =A0 =A0 =A0gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PW=
REN");

Consider checking the return value of gpio_request().

> =A0 =A0 =A0 =A0/* Disable until needed */
> =A0 =A0 =A0 =A0gpio_direction_output(devkit8000_lcd_device.reset_gpio=
, 0);
> --
> 1.7.4.rc2
>

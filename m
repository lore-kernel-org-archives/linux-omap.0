From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCHv5] OMAP3: Devkit8000: Change lcd power pin
Date: Tue, 1 Feb 2011 22:24:15 +0100
Message-ID: <AANLkTi=mbJrNSfRqRzqAvKmhU-LgRiYq0KDC2zekWdqm@mail.gmail.com>
References: <1295538108-26451-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295538108-26451-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Daniel Morsing <daniel.morsing@gmail.com>, charu@ti.com, sshtylyov@mvista.com, manjugk@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 20, 2011 at 4:41 PM, Thomas Weber <weber@corscience.de> wro=
te:
> This patch fixes a wrongly used lcd enable pin.
>
> The Devkit8000 uses twl4030_ledA configured as output gpio only for
> the lcd enable line. twl4030_gpio.1 is used through the generic
> gpio functions while ledA is used via low level twl4030 calls.
>
> This patch removes the low level calls and use the generic gpio funct=
ions
> for initialization and use of ledA. This patch also fixes a bug where=
 the
> lcd would not power down when blanking.
>
> Further this patch fixes an indentation issue. The comment line uses
> eight whitespace and is replaced with a hard tab.
>
> gpio_request + gpio_direction_output are replaced with gpio_request_o=
ne.
> The return value of gpio_request_one is used to set the value of the
> gpio to -EINVAL when unsuccessful, so that gpio_is_valid can detect t=
he
> unsuccessful request. But already successful requested gpios are not =
freed.
>
> Reported-by: Daniel Morsing <daniel.morsing@gmail.com>
> Signed-off-by: Thomas Weber <weber@corscience.de>
> ---
> Changes from v4:
> =A0 =A0 =A0 =A0Merge of two patches
> =A0 =A0 =A0 =A0Use of gpio_request_one instead of gpio_request + gpio=
_direction_output
> Changes from v3:
> =A0 =A0 =A0 =A0Use return value of gpio_request
> Changes from v2:
> =A0 =A0 =A0 =A0Fix indention =3D> indentation
> =A0 =A0 =A0 =A0Better comment for removing low level functions used f=
or twl4030 gpio
> Changes from v1:
> =A0 =A0 =A0 =A0Pull the indentation fix into this patch
> =A0 =A0 =A0 =A0Change the pin for lcd pwren
>
> =A0arch/arm/mach-omap2/board-devkit8000.c | =A0 27 ++++++++++++++++--=
---------
> =A01 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-o=
map2/board-devkit8000.c
> index a5eb955..e4c12fe 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -115,9 +115,6 @@ static struct omap2_hsmmc_info mmc[] =3D {
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
> @@ -247,6 +244,8 @@ static struct gpio_led gpio_leds[];
> =A0static int devkit8000_twl_gpio_setup(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned gpio, unsigned ngpio)
> =A0{
> + =A0 =A0 =A0 int ret;
> +
> =A0 =A0 =A0 =A0omap_mux_init_gpio(29, OMAP_PIN_INPUT);
> =A0 =A0 =A0 =A0/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> =A0 =A0 =A0 =A0mmc[0].gpio_cd =3D gpio + 0;
> @@ -255,17 +254,23 @@ static int devkit8000_twl_gpio_setup(struct dev=
ice *dev,
> =A0 =A0 =A0 =A0/* TWL4030_GPIO_MAX + 1 =3D=3D ledB, PMU_STAT (out, ac=
tive low LED) */
> =A0 =A0 =A0 =A0gpio_leds[2].gpio =3D gpio + TWL4030_GPIO_MAX + 1;
>
> - =A0 =A0 =A0 =A0/* gpio + 1 is "LCD_PWREN" (out, active high) */
> - =A0 =A0 =A0 devkit8000_lcd_device.reset_gpio =3D gpio + 1;
> - =A0 =A0 =A0 gpio_request(devkit8000_lcd_device.reset_gpio, "LCD_PWR=
EN");
> - =A0 =A0 =A0 /* Disable until needed */
> - =A0 =A0 =A0 gpio_direction_output(devkit8000_lcd_device.reset_gpio,=
 0);
> + =A0 =A0 =A0 /* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active hig=
h) */
> + =A0 =A0 =A0 devkit8000_lcd_device.reset_gpio =3D gpio + TWL4030_GPI=
O_MAX + 0;
> + =A0 =A0 =A0 ret =3D gpio_request_one(devkit8000_lcd_device.reset_gp=
io,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPIOF_DIR_OUT | GPIOF_I=
NIT_LOW, "LCD_PWREN");
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devkit8000_lcd_device.reset_gpio =3D -E=
INVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to request GPIO=
 for LCD_PWRN\n");
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* gpio + 7 is "DVI_PD" (out, active low) */
> =A0 =A0 =A0 =A0devkit8000_dvi_device.reset_gpio =3D gpio + 7;
> - =A0 =A0 =A0 gpio_request(devkit8000_dvi_device.reset_gpio, "DVI Pow=
erDown");
> - =A0 =A0 =A0 /* Disable until needed */
> - =A0 =A0 =A0 gpio_direction_output(devkit8000_dvi_device.reset_gpio,=
 0);
> + =A0 =A0 =A0 ret =3D gpio_request_one(devkit8000_dvi_device.reset_gp=
io,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GPIOF_DIR_OUT | GPIOF_I=
NIT_LOW, "DVI PowerDown");
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devkit8000_dvi_device.reset_gpio =3D -E=
INVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to request GPIO=
 for DVI PowerDown\n");
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.4.rc2
>
> --

Hello Tony,
can you apply this patch?

Thomas

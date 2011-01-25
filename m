From: "Semwal, Sumit" <sumit.semwal@ti.com>
Subject: Re: [PATCH-V2] OMAP3EVM: Made backlight GPIO default state to off
Date: Tue, 25 Jan 2011 08:04:36 +0530
Message-ID: <AANLkTi=d-MDTv3_u7O2WKvD597od6pefqpW5O+kdXgPv@mail.gmail.com>
References: <1295896947-30475-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41945 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab1AYCfA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 21:35:00 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so7151455bwz.15
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 18:34:57 -0800 (PST)
In-Reply-To: <1295896947-30475-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com

Vaibhav,

On Tue, Jan 25, 2011 at 12:52 AM, Vaibhav Hiremath <hvaibhav@ti.com> wr=
ote:
> If you choose default output to DVI, the LCD backlight used to
> stay on, since panel->disable function never gets called.
>
> So, during init put backlight GPIO to off state and the driver
> code will decide which output to enable.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> Changes from V1 -
> =A0 =A0 =A0 =A0- Added check for return value
>
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 15 +++++++++++++--
> =A01 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index 7119380..a888a7d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -411,6 +411,8 @@ static struct platform_device leds_gpio =3D {
> =A0static int omap3evm_twl_gpio_setup(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned gpio, unsigned ngpio)
> =A0{
> + =A0 =A0 =A0 int r;
> +
> =A0 =A0 =A0 =A0/* gpio + 0 is "mmc0_cd" (input/IRQ) */
> =A0 =A0 =A0 =A0omap_mux_init_gpio(63, OMAP_PIN_INPUT);
> =A0 =A0 =A0 =A0mmc[0].gpio_cd =3D gpio + 0;
> @@ -426,8 +428,17 @@ static int omap3evm_twl_gpio_setup(struct device=
 *dev,
> =A0 =A0 =A0 =A0 */
>
> =A0 =A0 =A0 =A0/* TWL4030_GPIO_MAX + 0 =3D=3D ledA, LCD Backlight con=
trol */
> - =A0 =A0 =A0 gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");
> - =A0 =A0 =A0 gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> + =A0 =A0 =A0 r =3D gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL=
");
> + =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to get lcd_bkl =
gpio\n");
So even if the gpio_request fails, this code prints an error and contin=
ues?
> +
> + =A0 =A0 =A0 if (get_omap3_evm_rev() >=3D OMAP3EVM_BOARD_GEN_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D gpio_direction_output(gpio + TWL4=
030_GPIO_MAX, 1);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D gpio_direction_output(gpio + TWL4=
030_GPIO_MAX, 0);
> +
> + =A0 =A0 =A0 if (r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed to set directio=
n of lcd_bkl gpio\n");
>
> =A0 =A0 =A0 =A0/* gpio + 7 =3D=3D DVI Enable */
> =A0 =A0 =A0 =A0gpio_request(gpio + 7, "EN_DVI");
> --
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

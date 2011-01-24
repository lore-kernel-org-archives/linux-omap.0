From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP3EVM: Made backlight GPIO default state to off
Date: Mon, 24 Jan 2011 20:11:51 +0530
Message-ID: <AANLkTinbJjrcP0EjjGTSL-9C4n5XTtON7byGq=8Ye0TG@mail.gmail.com>
References: <hvaibhav@ti.com> <1295879772-14086-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:51465 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753001Ab1AXOmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 09:42:32 -0500
Received: by mail-gy0-f174.google.com with SMTP id 11so1513480gyb.33
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 06:42:32 -0800 (PST)
In-Reply-To: <1295879772-14086-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, tony@atomide.com

On Mon, Jan 24, 2011 at 20:06,  <hvaibhav@ti.com> wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> If you choose default output to DVI, the LCD backlight stays on,
> since panel->disable function never gets called.
>
> So, during init put backlight GPIO to off state and the driver
> code will decide which output to enable.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index 1b8a806..3f5117a 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -448,7 +448,10 @@ static int omap3evm_twl_gpio_setup(struct device=
 *dev,
>
> =A0 =A0 =A0 =A0/* TWL4030_GPIO_MAX + 0 =3D=3D ledA, LCD Backlight con=
trol */
> =A0 =A0 =A0 =A0gpio_request(gpio + TWL4030_GPIO_MAX, "EN_LCD_BKL");

Check for the return value and then only proceed

> - =A0 =A0 =A0 gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> + =A0 =A0 =A0 if (get_omap3_evm_rev() >=3D OMAP3EVM_BOARD_GEN_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(gpio + TWL4030_GP=
IO_MAX, 1);

Check for the return value

> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(gpio + TWL4030_GP=
IO_MAX, 0);

Ditto

>
> =A0 =A0 =A0 =A0/* gpio + 7 =3D=3D DVI Enable */
> =A0 =A0 =A0 =A0gpio_request(gpio + 7, "EN_DVI");
> --
> 1.6.2.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

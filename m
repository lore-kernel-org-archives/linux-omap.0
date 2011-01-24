From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP:board-omap3evm: Change TWL related gpio API's to gpio*_cansleep
Date: Mon, 24 Jan 2011 20:19:13 +0530
Message-ID: <AANLkTimLn3b-uYE811koNR5WR-PKCr9o8xrNpEo5SpcE@mail.gmail.com>
References: <hvaibhav@ti.com> <1295879485-12656-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45578 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752993Ab1AXOz1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 09:55:27 -0500
Received: by yic13 with SMTP id 13so1590440yic.37
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 06:55:26 -0800 (PST)
In-Reply-To: <1295879485-12656-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, tony@atomide.com

On Mon, Jan 24, 2011 at 20:01,  <hvaibhav@ti.com> wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> Since TWL GPIO's can go into sleep, and using normal
> gpio_get/set_value() API will lead to kernel dump (WARN_ON()).
> So replacing standard gpio_get/set_value() to
> gpio_get_set_value_cansleep().
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>

Reviewed-by: Charulatha V <charu@ti.com

> ---
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 12 ++++++------
> =A01 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index 323c380..a158d21 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -235,9 +235,9 @@ static int omap3_evm_enable_lcd(struct omap_dss_d=
evice *dssdev)
> =A0 =A0 =A0 =A0gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 0);
>
> =A0 =A0 =A0 =A0if (get_omap3_evm_rev() >=3D OMAP3EVM_BOARD_GEN_2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIG=
HT_GPIO, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep(OMAP3EVM_LCD_PA=
NEL_BKLIGHT_GPIO, 0);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIG=
HT_GPIO, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep(OMAP3EVM_LCD_PA=
NEL_BKLIGHT_GPIO, 1);
>
> =A0 =A0 =A0 =A0lcd_enabled =3D 1;
> =A0 =A0 =A0 =A0return 0;
> @@ -248,9 +248,9 @@ static void omap3_evm_disable_lcd(struct omap_dss=
_device *dssdev)
> =A0 =A0 =A0 =A0gpio_set_value(OMAP3EVM_LCD_PANEL_ENVDD, 1);
>
> =A0 =A0 =A0 =A0if (get_omap3_evm_rev() >=3D OMAP3EVM_BOARD_GEN_2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIG=
HT_GPIO, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep(OMAP3EVM_LCD_PA=
NEL_BKLIGHT_GPIO, 1);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(OMAP3EVM_LCD_PANEL_BKLIG=
HT_GPIO, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value_cansleep(OMAP3EVM_LCD_PA=
NEL_BKLIGHT_GPIO, 0);
>
> =A0 =A0 =A0 =A0lcd_enabled =3D 0;
> =A0}
> @@ -289,7 +289,7 @@ static int omap3_evm_enable_dvi(struct omap_dss_d=
evice *dssdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);
> + =A0 =A0 =A0 gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 1);
>
> =A0 =A0 =A0 =A0dvi_enabled =3D 1;
> =A0 =A0 =A0 =A0return 0;
> @@ -297,7 +297,7 @@ static int omap3_evm_enable_dvi(struct omap_dss_d=
evice *dssdev)
>
> =A0static void omap3_evm_disable_dvi(struct omap_dss_device *dssdev)
> =A0{
> - =A0 =A0 =A0 gpio_set_value(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);
> + =A0 =A0 =A0 gpio_set_value_cansleep(OMAP3EVM_DVI_PANEL_EN_GPIO, 0);
>
> =A0 =A0 =A0 =A0dvi_enabled =3D 0;
> =A0}
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

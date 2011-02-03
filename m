From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ARM: omap1/nokia770: mark some functions __init
Date: Thu, 3 Feb 2011 09:15:08 +0100
Message-ID: <20110203081508.GC30452@pengutronix.de>
References: <20100902054630.GB14214@pengutronix.de>
 <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34555 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab1BCIPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 03:15:09 -0500
Content-Disposition: inline
In-Reply-To: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hey Tony,

this patch below is now 4 months old and I didn't get any feedback.  (T=
hough I
somehow missed to cc linux-omap@vger.kernel.org before, sorry for that.=
)

There are two more patches in this thread that are not yet
applied/commented.  Should I resend?

Best regards
Uwe

On Thu, Sep 02, 2010 at 08:17:10AM +0200, Uwe Kleine-K=F6nig wrote:
> These are only called from omap_nokia770_init which is in .init.text,=
 too.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-omap1/board-nokia770.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-oma=
p1/board-nokia770.c
> index 51a4539..09b3f46 100644
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -112,7 +112,7 @@ static struct mipid_platform_data nokia770_mipid_=
platform_data =3D {
>  	.shutdown =3D mipid_shutdown,
>  };
> =20
> -static void mipid_dev_init(void)
> +static void __init mipid_dev_init(void)
>  {
>  	const struct omap_lcd_config *conf;
> =20
> @@ -123,7 +123,7 @@ static void mipid_dev_init(void)
>  	}
>  }
> =20
> -static void ads7846_dev_init(void)
> +static void __init ads7846_dev_init(void)
>  {
>  	if (gpio_request(ADS7846_PENDOWN_GPIO, "ADS7846 pendown") < 0)
>  		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
> @@ -167,7 +167,7 @@ static struct hwa742_platform_data nokia770_hwa74=
2_platform_data =3D {
>  	.te_connected		=3D 1,
>  };
> =20
> -static void hwa742_dev_init(void)
> +static void __init hwa742_dev_init(void)
>  {
>  	clk_add_alias("hwa_sys_ck", NULL, "bclk", NULL);
>  	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
> --=20
> 1.7.1

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

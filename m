From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] arm: omap1: devices: need to return with a value
Date: Tue, 19 Oct 2010 10:01:50 +0200
Message-ID: <20101019080150.GC11713@pengutronix.de>
References: <1287473455-25773-1-git-send-email-balbi@ti.com> <1287473455-25773-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52331 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab0JSIBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 04:01:54 -0400
Content-Disposition: inline
In-Reply-To: <1287473455-25773-2-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Oct 19, 2010 at 10:30:54AM +0300, Felipe Balbi wrote:
> Get rid of the following warning:
>=20
> arch/arm/mach-omap1/devices.c: In function 'omap_init_wdt':
> arch/arm/mach-omap1/devices.c:298: warning: 'return' with
> no value, in function returning non-void
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap1/devices.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devi=
ces.c
> index 63d68cf..a037aba 100644
> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -295,7 +295,7 @@ static struct platform_device omap_wdt_device =3D=
 {
>  static int __init omap_init_wdt(void)
>  {
>  	if (!cpu_is_omap16xx())
> -		return;
> +		return -ENODEV;
> =20
>  	platform_device_register(&omap_wdt_device);
>  	return 0;
It's unrelated to this patch, but using

	return platform_device_register(&omap_wdt_device);

would be a bit cleaner.

Uwe

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

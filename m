From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl4030-power: Fix driver path in file comment
Date: Mon, 25 Apr 2016 15:09:34 +0100
Message-ID: <20160425140934.GG2713@dell>
References: <1461101066-27753-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461101066-27753-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 19 Apr 2016, Javier Martinez Canillas wrote:

> The driver's file path in the comment is wrong, use the correct one.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
>=20
>  drivers/mfd/twl4030-power.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 04b539850e72..f832233fd365 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -1,5 +1,5 @@
>  /*
> - * linux/drivers/i2c/chips/twl4030-power.c
> + * linux/drivers/mfd/twl4030-power.c

These have a nasty habit of getting out of date, and since they serve
very little purpose, I'd prefer it if you just removed the line
completely.

>   * Handle TWL4030 Power initialization
>   *

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog

From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] mfd: twl6040: match wait_for_completion_timeout return
 type
Date: Mon, 16 Mar 2015 12:48:54 +0200
Message-ID: <5506B516.9070206@ti.com>
References: <1426493822-10331-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40809 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbbCPKtI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 06:49:08 -0400
In-Reply-To: <1426493822-10331-1-git-send-email-hofrat@osadl.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>, Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/16/2015 10:17 AM, Nicholas Mc Guire wrote:
> Return type of wait_for_completion_timeout is unsigned long not int. =
As
> time_left is exclusively used for wait_for_completion_timeout here it=
s
> type is simply changed to unsigned long.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>=20
> Patch was compile tested with x86_64_defconfig + CONFIG_TWL6040_CORE=3D=
y
>=20
> Patch is against 4.0-rc3 (localversion-next is -next-20150316)
>=20
>  drivers/mfd/twl6040.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index f71ee3d..d6f9761 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -259,7 +259,7 @@ static irqreturn_t twl6040_thint_handler(int irq,=
 void *data)
> =20
>  static int twl6040_power_up_automatic(struct twl6040 *twl6040)
>  {
> -	int time_left;
> +	unsigned long time_left;
> =20
>  	gpio_set_value(twl6040->audpwron, 1);
> =20
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

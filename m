From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/7] mfd: twl4030-power: Fix some defines for SW_EVENTS
Date: Tue, 20 May 2014 16:03:58 +0100
Message-ID: <20140520150358.GX24991@lee--X1>
References: <1400031250-29542-1-git-send-email-tony@atomide.com>
 <1400031250-29542-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:51681 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbaETPEE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2014 11:04:04 -0400
Received: by mail-ie0-f169.google.com with SMTP id at1so580554iec.14
        for <linux-omap@vger.kernel.org>; Tue, 20 May 2014 08:04:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400031250-29542-3-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

> We have these bits partially defined in two different
> places, so let's fix them up and add defines for the
> missing bits. These bits are the same for P1_SW_EVENTS,
> P2_SW_EVENTS and P3_SW_EVENTS.
>=20
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl4030-power.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.=
c
> index 1b30d8a..c0e4fc3 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -35,7 +35,14 @@
>  static u8 twl4030_start_script_address =3D 0x2b;
> =20
>  #define PWR_P1_SW_EVENTS	0x10

BIT(4)?

> +#define PWR_STOPON_PRWON	(1 << 6)
> +#define PWR_STOPON_SYSEN	(1 << 5)
> +#define PWR_ENABLE_WARMRESET	(1 << 4)
> +#define PWR_LVL_WAKEUP		(1 << 3)
> +#define PWR_DEVACT		(1 << 2)
> +#define PWR_DEVSLP		(1 << 1)
>  #define PWR_DEVOFF		(1 << 0)
> +
>  #define SEQ_OFFSYNC		(1 << 0)

Please use the BIT() macro for these.

[...]

Once fixed, apply my Acked-by on re-submission.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

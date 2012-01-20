From: "Palande, Ameya" <ameya.palande@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: clock: fix mult and div mask for USB_DPLL
Date: Fri, 20 Jan 2012 11:52:17 -0800
Message-ID: <CAHFNHeXZKDnHUwjeahsNLk_2QDDuNJ12p2iZnEgCMSCRD99V4g@mail.gmail.com>
References: <1326929954-3912-1-git-send-email-ameya.palande@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34608 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755285Ab2ATTwS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 14:52:18 -0500
Received: by mail-tul01m020-f181.google.com with SMTP id up10so1356808obb.12
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 11:52:17 -0800 (PST)
In-Reply-To: <1326929954-3912-1-git-send-email-ameya.palande@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, ameya.palande@ti.com

Any update on this?

On Wed, Jan 18, 2012 at 3:39 PM, Ameya Palande <ameya.palande@ti.com> w=
rote:
>
> Signed-off-by: Ameya Palande <ameya.palande@ti.com>
> ---
> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-oma=
p2/clock44xx_data.c
> index 08e86d7..053cc15 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -953,8 +953,8 @@ static struct dpll_data dpll_usb_dd =3D {
> =A0 =A0 =A0 =A0.modes =A0 =A0 =A0 =A0 =A0=3D (1 << DPLL_LOW_POWER_BYP=
ASS) | (1 << DPLL_LOCKED),
> =A0 =A0 =A0 =A0.autoidle_reg =A0 =3D OMAP4430_CM_AUTOIDLE_DPLL_USB,
> =A0 =A0 =A0 =A0.idlest_reg =A0 =A0 =3D OMAP4430_CM_IDLEST_DPLL_USB,
> - =A0 =A0 =A0 .mult_mask =A0 =A0 =A0=3D OMAP4430_DPLL_MULT_MASK,
> - =A0 =A0 =A0 .div1_mask =A0 =A0 =A0=3D OMAP4430_DPLL_DIV_MASK,
> + =A0 =A0 =A0 .mult_mask =A0 =A0 =A0=3D OMAP4430_DPLL_MULT_USB_MASK,
> + =A0 =A0 =A0 .div1_mask =A0 =A0 =A0=3D OMAP4430_DPLL_DIV_0_7_MASK,
> =A0 =A0 =A0 =A0.enable_mask =A0 =A0=3D OMAP4430_DPLL_EN_MASK,
> =A0 =A0 =A0 =A0.autoidle_mask =A0=3D OMAP4430_AUTO_DPLL_MODE_MASK,
> =A0 =A0 =A0 =A0.idlest_mask =A0 =A0=3D OMAP4430_ST_DPLL_CLK_MASK,
> --
> 1.7.4.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

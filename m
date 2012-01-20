From: "Palande, Ameya" <ameya.palande@ti.com>
Subject: Re: [PATCH] OMAP4: Clock: Force a DPLL clkdm/pwrdm ON before a relock
Date: Fri, 20 Jan 2012 11:53:11 -0800
Message-ID: <CAHFNHeWH24iSwumFKwjB+8Tx=+t-XbWjO5YqzH2R9ta0FZWvAQ@mail.gmail.com>
References: <1327000976-30912-1-git-send-email-ameya.palande@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:36732 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755662Ab2ATTxM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 14:53:12 -0500
Received: by mail-tul01m020-f177.google.com with SMTP id uz6so1667544obc.22
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 11:53:11 -0800 (PST)
In-Reply-To: <1327000976-30912-1-git-send-email-ameya.palande@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, ameya.palande@ti.com, nm@ti.com

Any update on this?

On Thu, Jan 19, 2012 at 11:22 AM, Ameya Palande <ameya.palande@ti.com> =
wrote:
> From: Rajendra Nayak <rnayak@ti.com>
>
> All DPLLs except USB are in ALWON powerdomain. Make sure the
> clkdm/pwrdm for USB DPLL (l3init) is turned on before attempting
> a DPLL relock. So, mark the database accordingly.
>
> Without this fix, it was seen that DPLL relock fails while testing
> relock in a loop of USB DPLL.
>
> CC: Nishanth Menon <nm@ti.com>
> Tested-by: Ameya Palande <ameya.palande@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-oma=
p2/clock44xx_data.c
> index 08e86d7..9519374 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -974,6 +974,7 @@ static struct clk dpll_usb_ck =3D {
> =A0 =A0 =A0 =A0.recalc =A0 =A0 =A0 =A0 =3D &omap3_dpll_recalc,
> =A0 =A0 =A0 =A0.round_rate =A0 =A0 =3D &omap2_dpll_round_rate,
> =A0 =A0 =A0 =A0.set_rate =A0 =A0 =A0 =3D &omap3_noncore_dpll_set_rate=
,
> + =A0 =A0 =A0 .clkdm_name =A0 =A0 =3D "l3_init_clkdm",
> =A0};
>
> =A0static struct clk dpll_usb_clkdcoldo_ck =3D {
> --
> 1.7.4.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

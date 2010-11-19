From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 09/13] OMAP3: PM: Apply errata i540 before save secure ram
Date: Fri, 19 Nov 2010 11:09:45 +0100
Message-ID: <AANLkTi=Biq8y_FQunP9ih9fO1csvwkX_sCPR7yLA+n3U@mail.gmail.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<1290131698-6194-10-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47560 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab0KSKJq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 05:09:46 -0500
Received: by qwd7 with SMTP id 7so27360qwd.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 02:09:46 -0800 (PST)
In-Reply-To: <1290131698-6194-10-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin <khilman@deeprootsystems.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

On Fri, Nov 19, 2010 at 2:54 AM, Nishanth Menon <nm@ti.com> wrote:
> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
> We need to disable the autoidle bit from MPU INTC,
> otherwise INTC would get stall, and we would never
> come out of WFI. This must be done before save secure ram
> as well because save secure ram also does WFI.
>
> This patch is just a addition to the current W/A we have for i540,
> in order to cover the WFI inside the save secure ram.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
> =A0arch/arm/mach-omap2/pm34xx.c | =A0 10 ++++++++--
> =A01 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index f520b38..c7e2db0 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -422,6 +422,14 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_=
per_save_context();
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* We need to disable the autoidle bit from MPU INTC,
> + =A0 =A0 =A0 =A0* otherwise INTC would get stall, and we would never
> + =A0 =A0 =A0 =A0* come out of WFI. This is done here because
> + =A0 =A0 =A0 =A0* save secure ram also does WFI.
> + =A0 =A0 =A0 =A0*/
The comment should mention the errata ID i540, for easier readability
and maintenance.

> + =A0 =A0 =A0 omap3_intc_prepare_idle();
> +
> =A0 =A0 =A0 =A0/* CORE */
> =A0 =A0 =A0 =A0if (core_next_state < PWRDM_POWER_ON) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_uart_prepare_idle(0);
> @@ -433,8 +441,6 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 omap3_intc_prepare_idle();
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0* On EMU/HS devices ROM code restores a SRDC value
> =A0 =A0 =A0 =A0* from scratchpad which has automatic self refresh on =
timeout
> --
> 1.6.3.3
>
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

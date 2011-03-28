From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] OMAP3: l3: fix for "irq 10: nobody cared" message
Date: Mon, 28 Mar 2011 04:30:27 +0300
Message-ID: <AANLkTimj9cATwMiZwdDJSw53Qte5qT78VnhDrE3Sfh7T@mail.gmail.com>
References: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44416 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab1C1Ba3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Mar 2011 21:30:29 -0400
Received: by bwz15 with SMTP id 15so2088522bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 27 Mar 2011 18:30:28 -0700 (PDT)
In-Reply-To: <1301099396-30380-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>

On Sat, Mar 26, 2011 at 2:29 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> If an error occurs in the L3 on any other initiator than MPU,
> the interrupt goes unhandled given that the 'base' register
> was calculated with the initialized err_base value (which
> coincidentally points to MPU) and not with the actual source
> of the error.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> =C2=A0arch/arm/mach-omap2/omap_l3_smx.c | =C2=A0 =C2=A05 +++--
> =C2=A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/=
omap_l3_smx.c
> index 5f2da75..da917c2 100644
> --- a/arch/arm/mach-omap2/omap_l3_smx.c
> +++ b/arch/arm/mach-omap2/omap_l3_smx.c
> @@ -196,11 +196,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, vo=
id *_l3)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* No timeout =
error for debug sources */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 base =3D ((l3->rt) + (*(omap3_l3_bases[int_typ=
e] + err_source)));
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* identify the error source */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (err_source =3D 0; !(status & (1 << er=
r_source)); err_source++)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;
> +
> + =C2=A0 =C2=A0 =C2=A0 base =3D ((l3->rt) + (*(omap3_l3_bases[int_typ=
e] + err_source)));
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0error =3D omap3_l3_readll(base, L3_ERROR_L=
OG);

One extra space too much.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tommi Rantala <tt.rantala@gmail.com>
Subject: Re: [PATCH] OMAP: Fix race condition with autodeps
Date: Wed, 16 Sep 2009 15:07:05 +0300
Message-ID: <93e6a6040909160507j64eaa9efo38f69fea016d3933@mail.gmail.com>
References: <1253098386-30263-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:33873 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042AbZIPMHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Sep 2009 08:07:04 -0400
Received: by ewy2 with SMTP id 2so1343812ewy.17
        for <linux-omap@vger.kernel.org>; Wed, 16 Sep 2009 05:07:06 -0700 (PDT)
In-Reply-To: <1253098386-30263-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: paul@pwsan.com, khilman@deeprootsystems.com, tony@atomide.com, linux-omap@vger.kernel.org, ville.syrjala@nokia.com

2009/9/16 Kalle Jokiniemi <kalle.jokiniemi@digia.com>:
> There is a possible race condition in clockdomain
> code handling hw supported idle transitions.
>
> When multiple autodeps dependencies are being added
> or removed, a transition of still remaining dependent
> powerdomain can result in false readings of the
> state counter. This is especially fatal for off mode
> state counter, as it could result in a driver not
> noticing a context loss.
>
> Fixed by disabling hw supported state transitions
> when autodeps are being changed.
>
> Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
> ---
> =A0arch/arm/mach-omap2/clockdomain.c | =A0 74 ++++++++++++++++++++++-=
--------------
> =A01 files changed, 44 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/=
clockdomain.c
> index 4ef7b4f..1a8c386 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -137,6 +137,36 @@ static void _clkdm_del_autodeps(struct clockdoma=
in *clkdm)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +/*
> + * _omap2_clkdm_set_hwsup - set high the hwsup idle transition bit
> + * @clkdm: struct clockdomain *
> + * @enable: int 0 to disable, 1 to enable
> + *
> + * Internal helper for actually switching the bit that controls hwsu=
p
> + * idle transitions for clkdm.
> + */

"static" missing here.

> +void _omap2_clkdm_set_hwsup(struct clockdomain *clkdm, int enable)
> +{
> + =A0 =A0 =A0 u32 v;
> +
> + =A0 =A0 =A0 if (cpu_is_omap24xx()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D OMAP24XX_CLKSTCTR=
L_ENABLE_AUTO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D OMAP24XX_CLKSTCTR=
L_DISABLE_AUTO;
> + =A0 =A0 =A0 } else if (cpu_is_omap34xx()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D OMAP34XX_CLKSTCTR=
L_ENABLE_AUTO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v =3D OMAP34XX_CLKSTCTR=
L_DISABLE_AUTO;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 cm_rmw_mod_reg_bits(clkdm->clktrctrl_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 v << __ffs(clkd=
m->clktrctrl_mask),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm->pwrdm.pt=
r->prcm_offs, CM_CLKSTCTRL);
> +}
>
> =A0static struct clockdomain *_clkdm_lookup(const char *name)
> =A0{
[...]

Regards,
Tommi Rantala
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

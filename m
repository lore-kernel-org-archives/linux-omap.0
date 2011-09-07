From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 7/8] OMAP3+: ABB: initialization & transition functions
Date: Wed, 7 Sep 2011 22:09:13 +0200
Message-ID: <CAORVsuWzs46-kCqA4bOydQSgARB6m-wbAh4+M26yEwnx_tsP-A@mail.gmail.com>
References: <1309393560-8874-1-git-send-email-mturquette@ti.com>
	<1309393560-8874-8-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61303 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1IGUJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 16:09:13 -0400
Received: by vxj15 with SMTP id 15so24920vxj.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Sep 2011 13:09:13 -0700 (PDT)
In-Reply-To: <1309393560-8874-8-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, nm@ti.com

Mike,

I have a minor comment below.

On Thu, Jun 30, 2011 at 2:25 AM, Mike Turquette <mturquette@ti.com> wro=
te:
> The Adaptive Body-Bias ldo can be set to bypass or Forward Body-Bias
> after voltage scaling is performed.
>
> This patch implements the Adaptive Body-Bias ldo initialization routi=
ne
> and the transition sequence which is needed after a vc_bypass or
> vp_forceupdate sequence completes.
>
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> ---
=2E..

> diff --git a/arch/arm/mach-omap2/abb.c b/arch/arm/mach-omap2/abb.c
> new file mode 100644
> index 0000000..b8b6b4b
=2E..
> +/*
> + * omap_abb_disable - disable ABB ldo on a particular voltage domain
> + *
> + * @voltdm - pointer to particular voltage domain
> + *
> + * Included for completeness. =A0Not currently used but will be need=
ed in the
> + * future if ABB is converted to a loadable module.
> + */
> +void omap_abb_disable(struct voltagedomain *voltdm)
> +{
> + =A0 =A0 =A0 struct omap_abb_instance *abb =3D voltdm->abb;
> +
> + =A0 =A0 =A0 if (!abb->enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 abb->enabled =3D false;
> +
> + =A0 =A0 =A0 voltdm->rmw(abb->common->sr2en_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0 << __ffs(abb->common=
->sr2en_mask)),
(0 << x) can be replaced with 0.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 abb->setup_offs);
> +}
> +
=2E..

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

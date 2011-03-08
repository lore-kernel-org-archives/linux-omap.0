From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 3/3] OMAP2+: powerdomain: add pwrdm_can_ever_lose_context()
Date: Tue, 8 Mar 2011 14:46:04 +0530
Message-ID: <AANLkTimuYVuxiqifxPEqfxyVuSYcKL563TZCP5uNM8Ss@mail.gmail.com>
References: <20110308021018.31946.29962.stgit@twilight.localdomain> <20110308021551.31946.19903.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:46410 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750769Ab1CHJQp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 04:16:45 -0500
Received: by mail-fx0-f49.google.com with SMTP id 16so5505657fxm.36
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 01:16:44 -0800 (PST)
In-Reply-To: <20110308021551.31946.19903.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 8, 2011 at 07:45, Paul Walmsley <paul@pwsan.com> wrote:
> Some drivers wish to know whether the device that they control can
> ever lose context, for example, when the device's enclosing
> powerdomain loses power. =A0They can use this information to determin=
e
> whether it is necessary to save and restore device context, or whethe=
r
> it can be skipped. =A0Implement the powerdomain portion of this by
> adding the function pwrdm_can_ever_lose_context(). =A0This is not for
> use directly from driver code, but instead is intended to be called
> from driver-subarch integration code (i.e., arch/arm/*omap* code).
>
> Currently, the result from this function should be passed into the
> driver code via struct platform_data, but at some point this should
> be part of some common or OMAP-specific device code.
>
> While here, update file copyrights.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.c | =A0 43 +++++++++++++++++++++++=
+++++++++++++-
> =A0arch/arm/mach-omap2/powerdomain.h | =A0 18 +++++++--------
> =A02 files changed, 50 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index eaed0df..a11be81 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -2,7 +2,7 @@
> =A0* OMAP powerdomain control
> =A0*
> =A0* Copyright (C) 2007-2008 Texas Instruments, Inc.
> - * Copyright (C) 2007-2009 Nokia Corporation
> + * Copyright (C) 2007-2011 Nokia Corporation
> =A0*
> =A0* Written by Paul Walmsley
> =A0* Added OMAP4 specific support by Abhijit Pagare <abhijitpagare@ti=
=2Ecom>
> @@ -938,3 +938,44 @@ u32 pwrdm_get_context_loss_count(struct powerdom=
ain *pwrdm)
>
> =A0 =A0 =A0 =A0return count;
> =A0}
> +
> +/**
> + * pwrdm_can_ever_lose_context - can this powerdomain ever lose cont=
ext?
> + * @pwrdm: struct powerdomain *
> + *
> + * Given a struct powerdomain * @pwrdm, returns 1 if the powerdomain
> + * can lose either memory or logic context or if @pwrdm is invalid, =
or
> + * returns 0 otherwise. =A0This function is not concerned with how t=
he
> + * powerdomain registers are programmed (i.e., to go off or not); it=
's
> + * concerned with whether it's ever possible for this powerdomain to
> + * go off while some other part of the chip is active. =A0This funct=
ion
> + * assumes that every powerdomain can go to either ON or INACTIVE.
> + */
> +bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(pwrdm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("powerdomain: %s: invalid powe=
rdomain pointer\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;

Do you really want to return 1 in case of invalid powerdomain pointer?

-V Charulatha

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pwrdm->pwrsts & PWRSTS_OFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 if (pwrdm->pwrsts & PWRSTS_RET) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrdm->pwrsts_logic_ret & PWRSTS_OF=
=46)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < pwrdm->banks; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrdm->pwrsts_mem_r=
et[i] & PWRSTS_OFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < pwrdm->banks; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrdm->pwrsts_mem_on[i] & PWRSTS_OF=
=46)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> +
> + =A0 =A0 =A0 return 0;
> +}

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC 1/1] omap3: PM: MPU and CORE should stay awake if there is
 CAM domain ACTIVE
Date: Fri, 27 Jan 2012 12:06:37 +0100
Message-ID: <CAORVsuWYvvZ_kp=9OTYMjDBibbsOSuBmkUU+u9mb_hKpL80d1Q@mail.gmail.com>
References: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64419 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160Ab2A0LGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 06:06:38 -0500
Received: by vbbfc26 with SMTP id fc26so1149676vbb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jan 2012 03:06:37 -0800 (PST)
In-Reply-To: <1327658401-28441-1-git-send-email-sakari.ailus@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com, khilman@ti.com

Hi,

On Fri, Jan 27, 2012 at 11:00 AM, Sakari Ailus <sakari.ailus@iki.fi> wr=
ote:
> MPU and CORE should stay awake if there is CAM domain ACTIVE. This is
> because that module doesn't have wake-up capability.
>
> The original patch was written by Jouni H=F6gander in 2008 and this i=
s the
> last part left of it which is not in upstream yet.
>
> I wonder if the approach taken in the patch is valid these days;
> nevertheless it seems to do the job...
The code in the function omap3_enter_idle_bm from
arch/arm/mach-omap2/cpuidle34xx.c is doing exactly the same thing: it
is choosing the cpuidle safe_state if the CAM power domain is active.

Please note that this only works if CPU_IDLE is selected, which is
needed to reach any decent low power mode.

Regards,
Jean

>
> Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
> ---
> =A0arch/arm/mach-omap2/pm34xx.c | =A0 =A03 +++
> =A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index fc69875..4ef682d 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -295,6 +295,9 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0pwrdm_clear_all_prev_pwrst(core_pwrdm);
> =A0 =A0 =A0 =A0pwrdm_clear_all_prev_pwrst(per_pwrdm);
>
> + =A0 =A0 =A0 if (pwrdm_read_pwrst(cam_pwrdm) =3D=3D PWRDM_POWER_ON)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms=
[0]);
> +
> =A0 =A0 =A0 =A0mpu_next_state =3D pwrdm_read_next_pwrst(mpu_pwrdm);
> =A0 =A0 =A0 =A0switch (mpu_next_state) {
> =A0 =A0 =A0 =A0case PWRDM_POWER_ON:
> --
> 1.7.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

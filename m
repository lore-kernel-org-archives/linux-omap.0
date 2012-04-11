From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: remove redundant sysconfig context restore
Date: Wed, 11 Apr 2012 14:13:21 +0530
Message-ID: <CAMQu2gw0feL22aVi-ZDffBzest0+sdMnL2Hwa6GwwVKiKF118Q@mail.gmail.com>
References: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:36087 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751175Ab2DKInn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 04:43:43 -0400
Received: by qcro28 with SMTP id o28so473733qcr.5
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 01:43:41 -0700 (PDT)
In-Reply-To: <1334133256-20475-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm <linux-arm-kernel@lists.infradead.org>

CC'ing LAKML

On Wed, Apr 11, 2012 at 2:04 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> Since hwmod framework now manages sysconfig context save/restore
> there is no more need to touch this register in driver. Hence,
> remove restore of sysconfig register in omap_timer_restore_context.
> This was causing incorrect context restore of sysconfig register.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
> =A0arch/arm/plat-omap/dmtimer.c | =A0 =A02 --
> =A01 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtime=
r.c
> index 652139c..15e7882 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -82,8 +82,6 @@ static void omap_dm_timer_write_reg(struct omap_dm_=
timer *timer, u32 reg,
>
> =A0static void omap_timer_restore_context(struct omap_dm_timer *timer=
)
> =A0{
> - =A0 =A0 =A0 __raw_writel(timer->context.tiocp_cfg,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->io_base + OMAP_T=
IMER_OCP_CFG_OFFSET);
> =A0 =A0 =A0 =A0if (timer->revision =3D=3D 1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_writel(timer->context.tistat, ti=
mer->sys_stat);
>

Looks good to me.

Acked-by: Santosh Shilimkar <santosh.shilimka@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

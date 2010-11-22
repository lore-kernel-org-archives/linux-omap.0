From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 14/14] OMAP: dmtimer: pm_runtime support
Date: Mon, 22 Nov 2010 12:34:01 +0530
Message-ID: <AANLkTinmjrVQTZ6Mw+LCTvVUbe0tkNU6jVy1301j0TB8@mail.gmail.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com> <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com> <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com> <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-14-git-send-email-tarun.kanti@ti.com> <1290220778-22244-15-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:42876 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913Ab0KVHEm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 02:04:42 -0500
Received: by iwn33 with SMTP id 33so3079067iwn.0
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 23:04:42 -0800 (PST)
In-Reply-To: <1290220778-22244-15-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>

On Sat, Nov 20, 2010 at 08:09, Tarun Kanti DebBarma <tarun.kanti@ti.com=
> wrote:
> Add pm_runtime support to dmtimer. Since dmtimer is used during
> early boot before pm_runtime is initialized completely there are
> provisions to enable/disable clocks directly in the code during
> early boot.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> [p-basak2@ti.com: added pm_runtime logic in probe()]
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> ---
> =A0arch/arm/plat-omap/dmtimer.c | =A0 31 ++++++++++++++++++++++++++++=
+--
> =A01 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtime=
r.c
> index f9285b1..83d0b66 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -45,6 +45,7 @@
> =A0#include <linux/module.h>
> =A0#include <linux/slab.h>
> =A0#include <mach/hardware.h>
> +#include <linux/pm_runtime.h>
> =A0#include <plat/dmtimer.h>
> =A0#include <mach/irqs.h>
> =A0#include <linux/err.h>
> @@ -345,10 +346,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
>
> =A0void omap_dm_timer_enable(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
> +
> =A0 =A0 =A0 =A0if (timer->enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 clk_enable(timer->fclk);
> + =A0 =A0 =A0 if (unlikely(pdata->is_early_init)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(timer->fclk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->enabled =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }

If timer->fclk is not going to be used after "pdata->is_early_init" is
made zero,
you may do a clk_put( ) of the timer->fclk because pm_runtime_* APIs ar=
e
going to be used after pdata->is_early_init is made zero.

> +
> + =A0 =A0 =A0 if (pm_runtime_get_sync(&timer->pdev->dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&timer->pdev->dev, "%s:pm_runti=
me_get_sync() FAILED\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0timer->enabled =3D 1;
> =A0}
> @@ -356,10 +369,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
>
> =A0void omap_dm_timer_disable(struct omap_dm_timer *timer)
> =A0{
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev->de=
v.platform_data;
> +
> =A0 =A0 =A0 =A0if (!timer->enabled)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 clk_disable(timer->fclk);
> + =A0 =A0 =A0 if (unlikely(pdata->is_early_init)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(timer->fclk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->enabled =3D 0;

Ditto

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pm_runtime_put_sync(&timer->pdev->dev)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&timer->pdev->dev, "%s:pm_runti=
me_put_sync() FAILED\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0timer->enabled =3D 0;
> =A0}

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv4 14/14] OMAP: dmtimer: pm_runtime support
Date: Mon, 22 Nov 2010 12:37:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0372E3FF96@dbde02.ent.ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-13-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-14-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-15-git-send-email-tarun.kanti@ti.com>
 <AANLkTinmjrVQTZ6Mw+LCTvVUbe0tkNU6jVy1301j0TB8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38681 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab0KVHHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 02:07:14 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAM77B97021545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 01:07:13 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAM77AHp024233
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 12:37:10 +0530 (IST)
In-Reply-To: <AANLkTinmjrVQTZ6Mw+LCTvVUbe0tkNU6jVy1301j0TB8@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>

> -----Original Message-----
> From: Varadarajan, Charulatha [mailto:charu@ti.com]
> Sent: Monday, November 22, 2010 12:34 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Basak, Partha
> Subject: Re: [PATCHv4 14/14] OMAP: dmtimer: pm_runtime support
>=20
> On Sat, Nov 20, 2010 at 08:09, Tarun Kanti DebBarma <tarun.kanti@ti.c=
om>
> wrote:
> > Add pm_runtime support to dmtimer. Since dmtimer is used during
> > early boot before pm_runtime is initialized completely there are
> > provisions to enable/disable clocks directly in the code during
> > early boot.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > [p-basak2@ti.com: added pm_runtime logic in probe()]
> > Signed-off-by: Partha Basak <p-basak2@ti.com>
> > ---
> > =A0arch/arm/plat-omap/dmtimer.c | =A0 31 ++++++++++++++++++++++++++=
+++--
> > =A01 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmti=
mer.c
> > index f9285b1..83d0b66 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -45,6 +45,7 @@
> > =A0#include <linux/module.h>
> > =A0#include <linux/slab.h>
> > =A0#include <mach/hardware.h>
> > +#include <linux/pm_runtime.h>
> > =A0#include <plat/dmtimer.h>
> > =A0#include <mach/irqs.h>
> > =A0#include <linux/err.h>
> > @@ -345,10 +346,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
> >
> > =A0void omap_dm_timer_enable(struct omap_dm_timer *timer)
> > =A0{
> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev-
> >dev.platform_data;
> > +
> > =A0 =A0 =A0 =A0if (timer->enabled)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> >
> > - =A0 =A0 =A0 clk_enable(timer->fclk);
> > + =A0 =A0 =A0 if (unlikely(pdata->is_early_init)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(timer->fclk);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->enabled =3D 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
>=20
> If timer->fclk is not going to be used after "pdata->is_early_init" i=
s
> made zero,
> you may do a clk_put( ) of the timer->fclk because pm_runtime_* APIs =
are
> going to be used after pdata->is_early_init is made zero.
We need fclk throughout to be used by client driver for computing rate.
--
Tarun
>=20
> > +
> > + =A0 =A0 =A0 if (pm_runtime_get_sync(&timer->pdev->dev)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&timer->pdev->dev, "%s:pm_run=
time_get_sync()
> FAILED\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0timer->enabled =3D 1;
> > =A0}
> > @@ -356,10 +369,22 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
> >
> > =A0void omap_dm_timer_disable(struct omap_dm_timer *timer)
> > =A0{
> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D timer->pdev-
> >dev.platform_data;
> > +
> > =A0 =A0 =A0 =A0if (!timer->enabled)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> >
> > - =A0 =A0 =A0 clk_disable(timer->fclk);
> > + =A0 =A0 =A0 if (unlikely(pdata->is_early_init)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(timer->fclk);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timer->enabled =3D 0;
>=20
> Ditto
>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (pm_runtime_put_sync(&timer->pdev->dev)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&timer->pdev->dev, "%s:pm_run=
time_put_sync()
> FAILED\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0timer->enabled =3D 0;
> > =A0}
>=20
> <<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

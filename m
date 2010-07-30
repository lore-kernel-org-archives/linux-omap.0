From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: OMAP DSS2 coming out of OFF mode without restoring context
Date: Fri, 30 Jul 2010 10:15:23 -0500
Message-ID: <A24693684029E5489D1D202277BE894456C0B56C@dlee02.ent.ti.com>
References: <1280488167.6035.5.camel@Nokia-N900>
 <1280488679.2427.121.camel@tubuntu.research.nokia.com>
 <4C52CD26.8010908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33593 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab0G3PPb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jul 2010 11:15:31 -0400
In-Reply-To: <4C52CD26.8010908@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Laine Walker-Avina <lwalkera@pasco.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Friday, July 30, 2010 8:01 AM
> To: Tomi Valkeinen
> Cc: ext Laine Walker-Avina; linux-omap@vger.kernel.org; linux-
> fbdev@vger.kernel.org
> Subject: Re: OMAP DSS2 coming out of OFF mode without restoring context
> 
> Tomi Valkeinen had written, on 07/30/2010 06:17 AM, the following:
> > On Fri, 2010-07-30 at 13:09 +0200, ext Menon, Nishanth wrote:
> >> ----- Original message -----
> >>> Hi,
> >>>
> >>> On Thu, 2010-07-29 at 23:29 +0200, ext Laine Walker-Avina wrote:
> >>>> Hi,
> >>>>
> >>>> I'm having a problem where the DSS driver isn't restoring the
> >>>> framebuffer parameters after going in and out of blanking with OFF
> >>>> mode enabled. The problem appears to be in dss_get_ctx_id() in that
> >>>> pdata->get_last_off_on_transaction_id is 0. Commenting out the call
> to
> >>>> dss_need_ctx_restore() in dss_clk_enable() appears to do the right
> >>>> thing. I'm using the current master branch of linux-omap.
> >>> You need to fill the func pointer in the board file:
> >>>
> >>> static struct omap_dss_board_info xxx_dss_data = {
> >>>                 .get_last_off_on_transaction_id =
> >>> omap_pm_get_dev_context_loss_count,
> >>>
> >> none of l-o board files seem to do this. I guess
> >> with off capable master, we need this to be
> >> defaulted under CONFIG_PM within dss/core itself?
> >> I mean the defaults prevent display function
> >> at off, so why ask all boards to fill it up?
> >
> > If the PM stuff in linux tree starts to be in working order, then yes,
> > we need some better solution.
> >
> > I'm not quite sure what the options are, but I was told that the correct
> > way to get context loss count is as above, fill the platform_data in the
> > board file with a pointer to omap_pm_get_dev_context_loss_count().
> >
> > So if that is still the proper way, then we need a "DSS platform
> > initialization" function that the board files can call, which then fills
> > the platform_data with correct data.
> >
> > But this will still require modifying every board file that uses DSS.
> > Then again, every board file needs anyway DSS code, so perhaps that's
> > not such a big issue.
> >
> > For this particular case there's not much benefit having a separate
> > initialization function. On the contrary, it'll just have more code
> > lines. But I think there will be some more platform DSS stuff (like
> > pinmuxing) which can then use the same mechanism.
> >
> >  Tomi
> >
> >
> 
> I was thinking more of the lines of this:
> a) omap_pm_get_dev_context_loss_count is exported
> OR
> b) there is a file arch/arm/mach-omap2/dss.c which would take this..

I'm curious about something...

Why this can't be part of the platform code per-cpu?

It makes no sense to me (unless I'm missing something here) to put this
In mach-omap2/ files... It should be on plat-omap/ somewhere.

What do you think?

Regards,
Sergio

> 
> 
> diff --git a/drivers/video/omap2/dss/core.c
> b/drivers/video/omap2/dss/core.c
> index b3a498f..0b9041a 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -35,6 +35,7 @@
> 
>   #include <plat/display.h>
>   #include <plat/clock.h>
> +#include <plat/omap-pm.h>
> 
>   #include "dss.h"
> 
> @@ -502,6 +503,10 @@ static int omap_dss_probe(struct platform_device
> *pdev)
> 
>          core.pdev = pdev;
> 
> +       if (!core.pdev->get_last_off_on_transaction_id)
> +               core.pdev->get_last_off_on_transaction_id =
> +                       omap_pm_get_dev_context_loss_count;
> +
>          dss_init_overlay_managers(pdev);
>          dss_init_overlays(pdev);
> 
> 
> 
> --
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

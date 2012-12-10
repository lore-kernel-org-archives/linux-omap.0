From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 5/5] OMAPFB: connect ovl managers to all dssdevs
Date: Mon, 10 Dec 2012 13:04:54 +0530
Message-ID: <50C5909E.8030800@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com> <1354881309-17625-5-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56227 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752522Ab2LJHf3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 02:35:29 -0500
In-Reply-To: <1354881309-17625-5-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi,

On Friday 07 December 2012 05:25 PM, Tomi Valkeinen wrote:
> Commit 5d89bcc341771d95e3a2996218e5949a6627f59e (OMAPDSS: remove initial
> display code from omapdss) moved setting up the initial overlay, overlay
> manager, output and display connections from omapdss to omapfb.
>
> However, currently omapfb only handles the connection related to the
> default display, which means that no overlay managers are connected to
> other displays.
>
> This patch changes omapfb to go through all dssdevs, and connect an
> overlay manager to them.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/omapfb/omapfb-main.c |   38 +++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
> index 1df973e..24739fc 100644
> --- a/drivers/video/omap2/omapfb/omapfb-main.c
> +++ b/drivers/video/omap2/omapfb/omapfb-main.c
> @@ -2353,27 +2353,37 @@ static int omapfb_init_display(struct omapfb2_device *fbdev,
>   }
>
>   static int omapfb_init_connections(struct omapfb2_device *fbdev,
> -		struct omap_dss_device *dssdev)
> +		struct omap_dss_device *def_dssdev)
>   {
>   	int i, r;
> -	struct omap_overlay_manager *mgr = NULL;
> +	struct omap_overlay_manager *mgr;
>
> -	for (i = 0; i < fbdev->num_managers; i++) {
> -		mgr = fbdev->managers[i];
> -
> -		if (dssdev->channel == mgr->id)
> -			break;
> +	if (!def_dssdev->output) {
> +		dev_err(fbdev->dev, "no output for the default display\n");
> +		return -EINVAL;
>   	}
>
> -	if (i == fbdev->num_managers)
> -		return -ENODEV;
> +	for (i = 0; i < fbdev->num_displays; ++i) {
> +		struct omap_dss_device *dssdev = fbdev->displays[i].dssdev;
> +		struct omap_dss_output *out = dssdev->output;
>
> -	if (mgr->output)
> -		mgr->unset_output(mgr);
> +		mgr = omap_dss_get_overlay_manager(dssdev->channel);

This dssdev->channel reference is something we would want to get rid of 
eventually, right?

At the point omapfb_init_connections() is called, we would have all the 
omap_dss_devices registered, right? So at this point, omapfb will have 
an overall view of how the panels need to be connected to DSS.

I think we can try to find a manager here for dssdev rather than using 
dssdev->channel directly. The dssdev's output could connect to a few 
managers. We would want to chose managers for each dssdev output in such 
a way that all outputs have a manager. I guess there would be multiple 
combinations for this, but it would be okay to pick any one of them.

I think we would need some recursive or backtracking sort of approach to 
get a desired combination. We can figure about how to make it work 
later, but do you agree if this is a right way to get rid of 
dssdev->channel?

Also, we would need to do this for omapdrm separately using it's own 
encoder/connector entities.

Archit

>
> -	r = mgr->set_output(mgr, dssdev->output);
> -	if (r)
> -		return r;
> +		if (!mgr || !out)
> +			continue;
> +
> +		if (mgr->output)
> +			mgr->unset_output(mgr);
> +
> +		mgr->set_output(mgr, out);
> +	}
> +
> +	mgr = def_dssdev->output->manager;
> +
> +	if (!mgr) {
> +		dev_err(fbdev->dev, "no ovl manager for the default display\n");
> +		return -EINVAL;
> +	}
>
>   	for (i = 0; i < fbdev->num_overlays; i++) {
>   		struct omap_overlay *ovl = fbdev->overlays[i];
>


From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 08/65] OMAPDSS: remove partial update from panel-taal
Date: Tue, 22 Nov 2011 17:23:29 +0530
Message-ID: <4ECB8D39.4000005@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com> <1321953724-6350-9-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43775 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab1KVLx6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 06:53:58 -0500
In-Reply-To: <1321953724-6350-9-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:
> Partial update for manual update displays has never worked quite well:
> * The HW has limitations on the update area, and the x and width need to
>    be even.
> * Showing a part of a scaled overlay causes artifacts.
> * Makes the management of dispc very complex
>
> Considering the above points and the fact that partial update is not
> used anywhere, this and the following patches remove the partial update
> support. This will greatly simplify the following re-write of the apply
> mechanism to get proper locking and additional features like fifo-merge.
>
> This patch removes the partial update from the panel-taal.c.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/displays/panel-taal.c |   16 ++++------------
>   1 files changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
> index 0aa6c5d..dd64bd1 100644
> --- a/drivers/video/omap2/displays/panel-taal.c
> +++ b/drivers/video/omap2/displays/panel-taal.c
> @@ -198,12 +198,6 @@ struct taal_data {
>   	bool te_enabled;
>
>   	atomic_t do_update;
> -	struct {
> -		u16 x;
> -		u16 y;
> -		u16 w;
> -		u16 h;
> -	} update_region;
>   	int channel;
>
>   	struct delayed_work te_timeout_work;
> @@ -1440,16 +1434,14 @@ static int taal_update(struct omap_dss_device *dssdev,
>   		goto err;
>   	}
>
> -	r = taal_set_update_window(td, x, y, w, h);
> +	/* XXX no need to send this every frame, but dsi break if not done */
> +	r = taal_set_update_window(td, 0, 0,
> +			td->panel_config->timings.x_res,
> +			td->panel_config->timings.y_res);

How about sending a null short packet, and a BTA after that. This will 
keep automatic TE mode in place, and we'll need to send 1 short packet 
instead of 2 long packets every frame.

We should of course do this if we aren't planning to get partial update 
back in the near future.

Archit

>   	if (r)
>   		goto err;
>
>   	if (td->te_enabled&&  panel_data->use_ext_te) {
> -		td->update_region.x = x;
> -		td->update_region.y = y;
> -		td->update_region.w = w;
> -		td->update_region.h = h;
> -		barrier();
>   		schedule_delayed_work(&td->te_timeout_work,
>   				msecs_to_jiffies(250));
>   		atomic_set(&td->do_update, 1);


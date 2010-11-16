From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v4 3/7] OMAP: DSS2: Introduce omap_channel as a
 omap_dss_device parameter
Date: Tue, 16 Nov 2010 12:55:57 +0200
Message-ID: <1289904957.2668.75.camel@tubuntu>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
	 <1289219065-1362-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:17926 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933067Ab0KPK4E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 05:56:04 -0500
In-Reply-To: <1289219065-1362-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sumit Semwal <sumit.semwal@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

Hi,

On Mon, 2010-11-08 at 13:24 +0100, ext Archit Taneja wrote:
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> A new member 'channel' is introduced in omap_dss_device structure to determine
> which channel the panel uses. The dispc functions used by interface drivers
> (dsi, sdi etc) will use this member to differentiate between the 2 channels.
> 
> The following dispc functions are changed to incorporate channel as an argument:
>         -dispc_enable_fifohandcheck()
>         -dispc_set_lcd_size()
>         -dispc_set_parallel_interface_mode()
>         -dispc_set_tft_data_lines()
>         -dispc_set_lcd_display_type()
>         -dispc_set_lcd_timings()
> 
> The calls to these functions from the interface drivers have been changed to
> incorporate the new channel argument.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Samreen <samreen@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |    1 +
>  drivers/video/omap2/dss/dispc.c           |   49 ++++++++++++++++-------------
>  drivers/video/omap2/dss/dpi.c             |   11 +++---
>  drivers/video/omap2/dss/dsi.c             |   13 ++++---
>  drivers/video/omap2/dss/dss.h             |   19 ++++++-----
>  drivers/video/omap2/dss/rfbi.c            |   19 ++++++-----
>  drivers/video/omap2/dss/sdi.c             |   14 +++++---
>  7 files changed, 70 insertions(+), 56 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index 586944d..3e6eec1 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -434,6 +434,7 @@ struct omap_dss_device {
>         struct omap_overlay_manager *manager;
> 
>         enum omap_dss_display_state state;
> +       enum omap_channel channel;

Isn't this the same as dssdev->manager->id?

Yes, this channel stuff is a bit confusing, even the enum "omap_channel"
is badly named (should at least have "dss" in it). But
omap_overlay_manager should represent the output pipe, so I don't think
there's need for channel field in dss_device.

I think in many places we could even pass omap_overlay_manager pointer
around, instead of omap_channel. However, for low level dispc functions
it's perhaps cleaner to pass the channel ID though.

 Tomi



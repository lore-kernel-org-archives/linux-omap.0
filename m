From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/10] OMAP: DSS2: string parsing cleanups
Date: Mon, 22 Aug 2011 15:22:25 +0300
Message-ID: <1314015745.2168.41.camel@deskari>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
	 <1314001671-18123-6-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:56246 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751635Ab1HVMWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 08:22:34 -0400
In-Reply-To: <1314001671-18123-6-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org

On Mon, 2011-08-22 at 11:27 +0300, Tomi Valkeinen wrote:
> Use strtobool and kstrto* functions when parsing sysfs inputs.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/omap2/dss/display.c |   21 +++++++++------------
>  drivers/video/omap2/dss/manager.c |   37 +++++++++++++++++++------------------
>  drivers/video/omap2/dss/overlay.c |    7 +++----
>  3 files changed, 31 insertions(+), 34 deletions(-)

<snip>

> diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
> index a95f25e..b2a5685 100644
> --- a/drivers/video/omap2/dss/overlay.c
> +++ b/drivers/video/omap2/dss/overlay.c
> @@ -211,17 +211,16 @@ static ssize_t overlay_enabled_show(struct omap_overlay *ovl, char *buf)
>  static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
>  		size_t size)
>  {
> -	int r, enable;
> +	int r;
> +	bool enable;
>  	struct omap_overlay_info info;
>  
>  	ovl->get_overlay_info(ovl, &info);
>  
> -	r = kstrtoint(buf, 0, &enable);
> +	r = strtobool(buf, &enable);
>  	if (r)
>  		return r;
>  
> -	info.enabled = !!enable;
> -
>  	r = ovl->set_overlay_info(ovl, &info);
>  	if (r)
>  		return r;

Oops. This removes the lines that write the new value to overlay_info,
thus making it impossible to change the enable-status. I'll fix this.

 Tomi



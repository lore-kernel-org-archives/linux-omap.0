From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/8] OMAP4: DSS: HDMI: Use specific HDMI timings
 structure
Date: Thu, 23 Jun 2011 11:30:43 +0300
Message-ID: <1308817843.1834.40.camel@deskari>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
	 <1308298637-29753-2-git-send-email-mythripk@ti.com>
	 <1308298637-29753-3-git-send-email-mythripk@ti.com>
	 <1308298637-29753-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38138 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754166Ab1FWIau (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 04:30:50 -0400
Received: by bwg12 with SMTP id 12so1710288bwg.12
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 01:30:47 -0700 (PDT)
In-Reply-To: <1308298637-29753-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mythri P K <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 2011-06-17 at 13:47 +0530, Mythri P K wrote:
> Define new HDMI timings structure to replace the OMAP DSS timing strucutre in hdmi.c
> to have the HDMI include defintion out of DSS.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |   23 ++++++++++++++++++++---
>  drivers/video/omap2/dss/hdmi.h |   15 ++++++++++++++-
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 4ee879a..c24d573 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -593,6 +593,20 @@ static int read_edid(struct hdmi_ip_data *ip_data, u8 *pedid, u16 max_length)
>  	return 0;
>  }
>  
> +static void copy_hdmi_to_dss_timings(struct hdmi_video_timings hdmi_timings,
> +			struct omap_video_timings *timings)

There's no reason to pass hdmi_timings as a value, so it should be a
pointer.

> +{
> +	timings->x_res = hdmi_timings.x_res;
> +	timings->y_res = hdmi_timings.y_res;
> +	timings->pixel_clock = hdmi_timings.pixel_clock;
> +	timings->hbp = hdmi_timings.hbp;
> +	timings->hfp = hdmi_timings.hfp;
> +	timings->hsw = hdmi_timings.hsw;
> +	timings->vbp = hdmi_timings.vbp;
> +	timings->vfp = hdmi_timings.vfp;
> +	timings->vsw = hdmi_timings.vsw;
> +}
> +
>  static int get_timings_index(void)
>  {
>  	int code;
> @@ -617,7 +631,7 @@ static struct hdmi_cm hdmi_get_code(struct omap_video_timings *timing)
>  {
>  	int i = 0, code = -1, temp_vsync = 0, temp_hsync = 0;
>  	int timing_vsync = 0, timing_hsync = 0;
> -	struct omap_video_timings temp;
> +	struct hdmi_video_timings temp;
>  	struct hdmi_cm cm = {-1};
>  	DSSDBG("hdmi_get_code\n");
>  
> @@ -775,7 +789,8 @@ static void hdmi_read_edid(struct omap_video_timings *dp)

"dp" feels a rather odd name for video timings variable. What does it
stand for?

 Tomi



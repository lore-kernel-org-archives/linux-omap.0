From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 3/8] OMAP4: DSS: HDMI: Use specific HDMI timings
 structure
Date: Mon, 20 Jun 2011 18:16:31 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D625AA8@dbde02.ent.ti.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com>
 <1308298637-29753-3-git-send-email-mythripk@ti.com>
 <1308298637-29753-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40306 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847Ab1FTMql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 08:46:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5KCkbPU008666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 20 Jun 2011 07:46:40 -0500
In-Reply-To: <1308298637-29753-4-git-send-email-mythripk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of K, Mythri P
> Sent: Friday, June 17, 2011 1:47 PM
> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
> Cc: K, Mythri P
> Subject: [PATCH 3/8] OMAP4: DSS: HDMI: Use specific HDMI 
> timings structure
> 
> Define new HDMI timings structure to replace the OMAP DSS 
> timing strucutre in hdmi.c

[sp] Fix spelling of structure.

> to have the HDMI include defintion out of DSS.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/hdmi.c |   23 ++++++++++++++++++++---
>  drivers/video/omap2/dss/hdmi.h |   15 ++++++++++++++-
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/hdmi.c 
> b/drivers/video/omap2/dss/hdmi.c
> index 4ee879a..c24d573 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -593,6 +593,20 @@ static int read_edid(struct hdmi_ip_data 
> *ip_data, u8 *pedid, u16 max_length)
>  	return 0;
>  }
>  
> +static void copy_hdmi_to_dss_timings(struct 
> hdmi_video_timings hdmi_timings,
> +			struct omap_video_timings *timings)

[sp] Assuming that we really need 2 separate structures, suggest
     renaming function to "copy_hdmi_timings_to_dss" or
     "copy_timings_hdmi_to_dss" for better readability.

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
> @@ -617,7 +631,7 @@ static struct hdmi_cm 
> hdmi_get_code(struct omap_video_timings *timing)
>  {
>  	int i = 0, code = -1, temp_vsync = 0, temp_hsync = 0;
>  	int timing_vsync = 0, timing_hsync = 0;
> -	struct omap_video_timings temp;
> +	struct hdmi_video_timings temp;
>  	struct hdmi_cm cm = {-1};
>  	DSSDBG("hdmi_get_code\n");
>  
> @@ -775,7 +789,8 @@ static void hdmi_read_edid(struct 
> omap_video_timings *dp)
>  
>  	code = get_timings_index();
>  
> -	*dp = cea_vesa_timings[code].timings;
> +	copy_hdmi_to_dss_timings(cea_vesa_timings[code].timings, dp);
> +
>  }
>  
>  static void hdmi_core_init(struct hdmi_core_video_config *video_cfg,
> @@ -1234,7 +1249,9 @@ static int hdmi_power_on(struct 
> omap_dss_device *dssdev)
>  		hdmi_read_edid(p);
>  	}
>  	code = get_timings_index();
> -	dssdev->panel.timings = cea_vesa_timings[code].timings;
> +	copy_hdmi_to_dss_timings(cea_vesa_timings[code].timings,
> +			&dssdev->panel.timings);
> +
>  	update_hdmi_timings(&hdmi.cfg, p, code);
>  
>  	phy = p->pixel_clock;
> diff --git a/drivers/video/omap2/dss/hdmi.h 
> b/drivers/video/omap2/dss/hdmi.h
> index f57ef4a..dcc30b7 100644
> --- a/drivers/video/omap2/dss/hdmi.h
> +++ b/drivers/video/omap2/dss/hdmi.h
> @@ -188,9 +188,22 @@ struct hdmi_reg { u16 idx; };
>  #define REG_GET(base, idx, start, end) \
>  	FLD_GET(hdmi_read_reg(base, idx), start, end)
>  
> +struct hdmi_video_timings {
> +	u16 x_res;
> +	u16 y_res;
> +	/* Unit: KHz */
> +	u32 pixel_clock;

[sp] Could be:
	u32 pixel_clock; /* unit: KHz */

> +	u16 hsw;
> +	u16 hfp;
> +	u16 hbp;
> +	u16 vsw;
> +	u16 vfp;
> +	u16 vbp;
> +};
> +
>  /* HDMI timing structure */
>  struct hdmi_timings {
> -	struct omap_video_timings timings;
> +	struct hdmi_video_timings timings;
>  	int vsync_pol;
>  	int hsync_pol;
>  };
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
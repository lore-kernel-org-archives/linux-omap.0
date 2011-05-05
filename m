From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 03/10] OMAP4 : DSS2 : HDMI: Dispc gamma enable set/reset function for TV.
Date: Thu, 5 May 2011 15:50:08 +0200
Message-ID: <201105051550.09323.laurent.pinchart@ideasonboard.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com> <1299753858-12222-3-git-send-email-mythripk@ti.com> <1299753858-12222-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33873 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab1EENtf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 09:49:35 -0400
In-Reply-To: <1299753858-12222-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mythri P K <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com

Hi Mythri,

Sorry for the late reply, I've only noticed this issue today.

On Thursday 10 March 2011 11:44:11 Mythri P K wrote:
> Adding function to reset/set gamma table bit for TV interface
> currentl only support for disabled is added.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   13 +++++++++++++
>  drivers/video/omap2/dss/dss.h   |    1 +
>  2 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c index b8c576a..9b86f5f 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1008,6 +1008,19 @@ void dispc_set_burst_size(enum omap_plane plane,
>  	enable_clocks(0);
>  }
> 
> +void dispc_enable_gamma_table(bool enable)
> +{
> +	/* This is partially implemented to support only
> +	 *  disabling of the gamma table.
> +	 */
> +	if (enable) {
> +		DSSWARN("Gamma table enabling for TV not yet supported");
> +		return;
> +	}
> +
> +	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);

Bit 9 in the DISPC_CONFIG register is as FUNCGATED for the OMAP3. From a quick 
glance at the OMAP36xx and OMAP4430 public TRMs, that's the only DISPC_CONFIG 
bit that has been changed between OMAP3 and OMAP4.

> +}
> +
>  static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
>  {
>  	u32 val;
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index c2c0fcf..9f563a6 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -376,6 +376,7 @@ void dispc_set_plane_size(enum omap_plane plane, u16
> width, u16 height); void dispc_set_channel_out(enum omap_plane plane,
>  		enum omap_channel channel_out);
> 
> +void dispc_enable_gamma_table(bool enable);
>  int dispc_setup_plane(enum omap_plane plane,
>  		      u32 paddr, u16 screen_width,
>  		      u16 pos_x, u16 pos_y,

-- 
Regards,

Laurent Pinchart

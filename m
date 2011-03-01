From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 2/8] OMAP4 : DSS2 : HDMI: HDMI specific display
 controller and dss change.
Date: Tue, 1 Mar 2011 19:01:45 +0200
Message-ID: <1298998905.2049.34.camel@deskari>
References: <1298988988-28429-1-git-send-email-mythripk@ti.com>
	 <1298988988-28429-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53510 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466Ab1CARBr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 12:01:47 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21H1kOX028614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 11:01:46 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p21H1kci018375
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 11:01:46 -0600 (CST)
In-Reply-To: <1298988988-28429-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-01 at 08:16 -0600, K, Mythri P wrote:
> Adding changes to set gamma table bit for TV interface and function to select
> between VENC and HDMI.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    5 +++++
>  drivers/video/omap2/dss/dss.c   |    5 +++++
>  drivers/video/omap2/dss/dss.h   |    7 +++++++
>  3 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 69e1e9d..cf385f8 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1224,6 +1224,11 @@ void dispc_enable_zorder(enum omap_plane plane, bool enable)
>  	dispc_write_reg(dispc_reg_att[plane], val);
>  }
>  
> +void dispc_enable_gamma_table(bool enable)
> +{
> +	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
> +}

I would separate the gamma function out from this patch. These two
things are not related in any way.

And I'm not quite happy with this partial gamma implementation, as only
the enable function is implemented. At the minimum, put BUG_ON(enable);
there, and a comment that this can currently only be used to disable
gamma support.

> +
>  static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
>  {
>  	u32 val;
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 99de4e1..ca76e68 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -559,6 +559,11 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>  	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
>  }
>  
> +void dss_select_hdmi_venc(enum dss_hdmi_venc_select hdmi)
> +{
> +	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* 0x1 for HDMI, 0x0 VENC */

That comment is not needed, but you could put "VENC_HDMI_SWITCH" there
in the comments.

> +}
> +
>  static int dss_init(bool skip_init)
>  {
>  	int r;
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index b6f27fe..5b5b90c 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -123,6 +123,11 @@ enum dss_clk_source {
>  	DSS_SRC_DSS1_ALWON_FCLK,
>  };
>  
> +enum dss_hdmi_venc_select {
> +	DSS_VENC_SELECT,	/* Select VENC */
> +	DSS_HDMI_SELECT,	/* Select HDMI */
> +};

If the integer value of the enum is important, like in this case, you
need to define the value: DSS_VENC_SELECT = 0.

Also, the comments are not needed, they just say the same thing as the
enum itself.

And only now I realized that this is a clock source switch. The enum and
the function should be named appropriately, for example enum
dss_tv_clk_out_source. And the sources are TV_CLK and HDMI_M_PCLK, so
the the enum values should use those as part of their name.

 Tomi



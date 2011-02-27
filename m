From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/8] OMAP4 : DSS : HDMI: HDMI specific display
 controller and dss change.
Date: Sun, 27 Feb 2011 11:23:03 +0200
Message-ID: <1298798583.1977.13.camel@deskari>
References: <1298643715-21540-1-git-send-email-mythripk@ti.com>
	 <1298643715-21540-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59360 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849Ab1B0JXH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 04:23:07 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1R9N6A2022782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 03:23:06 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1R9N5Ei011399
	for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 03:23:05 -0600 (CST)
In-Reply-To: <1298643715-21540-4-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-02-25 at 08:21 -0600, K, Mythri P wrote:
> Adding changes to set gamma table bit for TV interface and function to select
> between VENC and HDMI.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |    5 +++++
>  drivers/video/omap2/dss/dss.c   |    7 +++++++
>  drivers/video/omap2/dss/dss.h   |    2 ++
>  3 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 6d9bb17..16f1106 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1213,6 +1213,11 @@ void dispc_enable_zorder(enum omap_plane plane, bool enable)
>  	dispc_write_reg(dispc_reg_att[plane], val);
>  }
>  
> +void dispc_enable_gamma_table(bool enable)
> +{
> +	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);
> +}
> +
>  static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
>  {
>  	u32 val;
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 99de4e1..127d42e 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -559,6 +559,13 @@ void dss_set_dac_pwrdn_bgz(bool enable)
>  	REG_FLD_MOD(DSS_CONTROL, enable, 5, 5);	/* DAC Power-Down Control */
>  }
>  
> +void dss_select_hdmi_venc(bool hdmi)
> +{
> +	REG_FLD_MOD(DSS_CONTROL, hdmi, 15, 15);	/* 0x1 for HDMI, 0x0 VENC */
> +	if (hdmi)
> +		REG_FLD_MOD(DSS_CONTROL, 0, 9, 8);
> +}

bool argument for this function is very confusing. Which one is true?
Perhaps this could use an enum.

I've tried to keep the habit of having the name of the register field in
comments to make the code easier to read. For example, /*
VENC_HDMI_SWITCH */ for the bit 15.

The bits 8 and 9 are FCK_CLK_SWITCH. Why do you set it here? Looks
rather dangerous to change the clock source like that.

 Tomi




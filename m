From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH v4 3/9] OMAP4 : DSS2 : HDMI: HDMI dispc gamma table
 disable.
Date: Wed, 9 Mar 2011 20:19:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024C192274@dbde02.ent.ti.com>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
 <1299671118-20839-2-git-send-email-mythripk@ti.com>
 <1299671118-20839-3-git-send-email-mythripk@ti.com>
 <1299671118-20839-4-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41768 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695Ab1CIOtR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 09:49:17 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p29EnEVS032004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 9 Mar 2011 08:49:16 -0600
In-Reply-To: <1299671118-20839-4-git-send-email-mythripk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of K, Mythri P
> Sent: Wednesday, March 09, 2011 5:15 PM
> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
> Cc: K, Mythri P
> Subject: [PATCH v4 3/9] OMAP4 : DSS2 : HDMI: HDMI dispc gamma table
> disable.
[sp] HDMI seems repetitive in the subject in this and some of the subsequent
     Patches.
> 
> Adding changes to set gamma table bit for TV interface to make sure it is
> disabled

[sp] Is this bit expected to be "enabled" by default? If no, how can/would
     this bit get enabled.

     The subject and description of the patch doesn't match the contents.
     The patch is adding a function that can *both* enable/disable gamma
     table - not just disable.

> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |   10 ++++++++++
>  drivers/video/omap2/dss/dss.h   |    1 +
>  2 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index 4a368c4..0defe16 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1008,6 +1008,16 @@ void dispc_set_burst_size(enum omap_plane plane,
>  	enable_clocks(0);
>  }
> 
> +void dispc_enable_gamma_table(bool enable)
> +{
> +	/* This is partially implemented to support only
> +	 *  disabling of the gamma table.
> +	 */
> +	BUG_ON(enable);
[sp] Is BUG_ON really needed. Can't this be a WARN or equiv?

> +
> +	REG_FLD_MOD(DISPC_CONFIG, enable, 9, 9);

[sp] I don't understand HDMI much, but if enabling gamma causes BUG_ON,
     then why would we need implementation to disable it.

     Instead, shouldn't the function be empty - if it can't be avoided
     altogether?

> +}
> +
>  static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
>  {
>  	u32 val;
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 29f31fd..008cbf4 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -363,6 +363,7 @@ void dispc_set_plane_size(enum omap_plane plane, u16
> width, u16 height);
>  void dispc_set_channel_out(enum omap_plane plane,
>  		enum omap_channel channel_out);
> 
> +void dispc_enable_gamma_table(bool enable);

[sp] Is this patch really standalone? I suggest merging it with the patch
     where the API is actually used.

     In effect, nothing gets disabled in this patch.

>  int dispc_setup_plane(enum omap_plane plane,
>  		      u32 paddr, u16 screen_width,
>  		      u16 pos_x, u16 pos_y,
> --
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

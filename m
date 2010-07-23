From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 5/5] OMAP: DSS2: Context Save and Restore of Video3
 pipeline registers
Date: Fri, 23 Jul 2010 11:15:19 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044ED62F6B@dbde02.ent.ti.com>
References: <1279540544-12682-1-git-send-email-archit@ti.com>
 <1279540544-12682-2-git-send-email-archit@ti.com>
 <1279540544-12682-3-git-send-email-archit@ti.com>
 <1279540544-12682-4-git-send-email-archit@ti.com>
 <1279540544-12682-5-git-send-email-archit@ti.com>
 <1279540544-12682-6-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab0GWFp3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 01:45:29 -0400
In-Reply-To: <1279540544-12682-6-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Janorkar, Mayuresh" <mayur@ti.com>, "Mittal, Mukund" <mmittal@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Taneja, Archit
> Sent: Monday, July 19, 2010 5:26 PM
> To: tomi.valkeinen@nokia.com
> Cc: linux-omap@vger.kernel.org; Janorkar, Mayuresh; Mittal, Mukund; Taneja,
> Archit
> Subject: [PATCH 5/5] OMAP: DSS2: Context Save and Restore of Video3 pipeline
> registers
> 
> From: Mayuresh Janorkar <mayur@ti.com>
> 
> Context Save and Restore of Video3 pipeline registers.
[Hiremath, Vaibhav] I still fill, we are un-necessary dividing the patch here. This patch can very well be part of another patch, 

[PATCH 2/5] OMAP: DSS2: Add Video 3 pipeline functionality in DISPC

In-fact, for me this should be consolidated single patch, something like, 

OMAP: DSS2: Add Video-3 pipeline functionality


I don't see any reason why we are fragmenting this into multiple patches.

Thanks,
Vaibhav

> 
> Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |  104
> +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 104 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index 8cda961..5a6c10e
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -397,6 +397,58 @@ void dispc_save_context(void)
>  	SR(VID_FIR_COEF_V(1, 7));
> 
>  	SR(VID_PRELOAD(1));
> +
> +	/* VID3 */
> +	if (cpu_is_omap44xx()) {
> +		SR(VID3_WB_BA0(0));
> +		SR(VID3_WB_BA1(0));
> +		SR(VID3_POSITION);
> +		SR(VID3_WB_SIZE(0));
> +		SR(VID3_WB_ATTRIBUTES(0));
> +		SR(VID3_WB_BUF_THRESHOLD(0));
> +		SR(VID3_WB_BUF_SIZE_STATUS(0));
> +		SR(VID3_WB_ROW_INC(0));
> +		SR(VID3_WB_PIXEL_INC(0));
> +		SR(VID3_WB_FIR(0));
> +		SR(VID3_WB_PICTURE_SIZE(0));
> +		SR(VID3_WB_ACCU0(0));
> +		SR(VID3_WB_ACCU1(0));
> +
> +		SR(VID3_WB_FIR_COEF_H(0, 0));
> +		SR(VID3_WB_FIR_COEF_H(0, 1));
> +		SR(VID3_WB_FIR_COEF_H(0, 2));
> +		SR(VID3_WB_FIR_COEF_H(0, 3));
> +		SR(VID3_WB_FIR_COEF_H(0, 4));
> +		SR(VID3_WB_FIR_COEF_H(0, 5));
> +		SR(VID3_WB_FIR_COEF_H(0, 6));
> +		SR(VID3_WB_FIR_COEF_H(0, 7));
> +
> +		SR(VID3_WB_FIR_COEF_HV(0, 0));
> +		SR(VID3_WB_FIR_COEF_HV(0, 1));
> +		SR(VID3_WB_FIR_COEF_HV(0, 2));
> +		SR(VID3_WB_FIR_COEF_HV(0, 3));
> +		SR(VID3_WB_FIR_COEF_HV(0, 4));
> +		SR(VID3_WB_FIR_COEF_HV(0, 5));
> +		SR(VID3_WB_FIR_COEF_HV(0, 6));
> +		SR(VID3_WB_FIR_COEF_HV(0, 7));
> +
> +		SR(VID3_WB_CONV_COEF(0, 0));
> +		SR(VID3_WB_CONV_COEF(0, 1));
> +		SR(VID3_WB_CONV_COEF(0, 2));
> +		SR(VID3_WB_CONV_COEF(0, 3));
> +		SR(VID3_WB_CONV_COEF(0, 4));
> +
> +		SR(VID3_WB_FIR_COEF_V(0, 0));
> +		SR(VID3_WB_FIR_COEF_V(0, 1));
> +		SR(VID3_WB_FIR_COEF_V(0, 2));
> +		SR(VID3_WB_FIR_COEF_V(0, 3));
> +		SR(VID3_WB_FIR_COEF_V(0, 4));
> +		SR(VID3_WB_FIR_COEF_V(0, 5));
> +		SR(VID3_WB_FIR_COEF_V(0, 6));
> +		SR(VID3_WB_FIR_COEF_V(0, 7));
> +
> +		SR(VID3_PRELOAD);
> +	}
>  }
> 
>  void dispc_restore_context(void)
> @@ -553,6 +605,58 @@ void dispc_restore_context(void)
> 
>  	RR(VID_PRELOAD(1));
> 
> +	/* VID3 */
> +	if (cpu_is_omap44xx()) {
> +		SR(VID3_WB_BA0(0));
> +		SR(VID3_WB_BA1(0));
> +		SR(VID3_POSITION);
> +		SR(VID3_WB_SIZE(0));
> +		SR(VID3_WB_ATTRIBUTES(0));
> +		SR(VID3_WB_BUF_THRESHOLD(0));
> +		SR(VID3_WB_BUF_SIZE_STATUS(0));
> +		SR(VID3_WB_ROW_INC(0));
> +		SR(VID3_WB_PIXEL_INC(0));
> +		SR(VID3_WB_FIR(0));
> +		SR(VID3_WB_PICTURE_SIZE(0));
> +		SR(VID3_WB_ACCU0(0));
> +		SR(VID3_WB_ACCU1(0));
> +
> +		SR(VID3_WB_FIR_COEF_H(0, 0));
> +		SR(VID3_WB_FIR_COEF_H(0, 1));
> +		SR(VID3_WB_FIR_COEF_H(0, 2));
> +		SR(VID3_WB_FIR_COEF_H(0, 3));
> +		SR(VID3_WB_FIR_COEF_H(0, 4));
> +		SR(VID3_WB_FIR_COEF_H(0, 5));
> +		SR(VID3_WB_FIR_COEF_H(0, 6));
> +		SR(VID3_WB_FIR_COEF_H(0, 7));
> +
> +		SR(VID3_WB_FIR_COEF_HV(0, 0));
> +		SR(VID3_WB_FIR_COEF_HV(0, 1));
> +		SR(VID3_WB_FIR_COEF_HV(0, 2));
> +		SR(VID3_WB_FIR_COEF_HV(0, 3));
> +		SR(VID3_WB_FIR_COEF_HV(0, 4));
> +		SR(VID3_WB_FIR_COEF_HV(0, 5));
> +		SR(VID3_WB_FIR_COEF_HV(0, 6));
> +		SR(VID3_WB_FIR_COEF_HV(0, 7));
> +
> +		SR(VID3_WB_CONV_COEF(0, 0));
> +		SR(VID3_WB_CONV_COEF(0, 1));
> +		SR(VID3_WB_CONV_COEF(0, 2));
> +		SR(VID3_WB_CONV_COEF(0, 3));
> +		SR(VID3_WB_CONV_COEF(0, 4));
> +
> +		SR(VID3_WB_FIR_COEF_V(0, 0));
> +		SR(VID3_WB_FIR_COEF_V(0, 1));
> +		SR(VID3_WB_FIR_COEF_V(0, 2));
> +		SR(VID3_WB_FIR_COEF_V(0, 3));
> +		SR(VID3_WB_FIR_COEF_V(0, 4));
> +		SR(VID3_WB_FIR_COEF_V(0, 5));
> +		SR(VID3_WB_FIR_COEF_V(0, 6));
> +		SR(VID3_WB_FIR_COEF_V(0, 7));
> +
> +		SR(VID3_PRELOAD);
> +	}
> +
>  	/* enable last, because LCD & DIGIT enable are here */
>  	RR(CONTROL(0));
>  	if (cpu_is_omap44xx())
> --
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: archit taneja <archit@ti.com>
Subject: Re: [PATCH 3/4] OMAP: DSS2: FEATURES: Remove DSI & SDI from OMAP2
Date: Fri, 25 Feb 2011 10:36:32 +0530
Message-ID: <4D6738D8.4050605@ti.com>
References: <1298554461-9879-1-git-send-email-tomi.valkeinen@ti.com> <1298554461-9879-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48627 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab1BYFES (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 00:04:18 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1P54FLf002993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 23:04:17 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1P54EZP014339
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 10:34:14 +0530 (IST)
In-Reply-To: <1298554461-9879-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thursday 24 February 2011 07:04 PM, Valkeinen, Tomi wrote:
> OMAP2 doesn't support SDI or DSI. Remove them from
> omap2_dss_supported_displays.
>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dss_features.c |    3 +--
>   1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
> index f4367f6..fe22d11 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -66,8 +66,7 @@ static const struct dss_reg_field omap3_dss_reg_fields[] = {
>
>   static const enum omap_display_type omap2_dss_supported_displays[] = {
>   	/* OMAP_DSS_CHANNEL_LCD */
> -	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
> -	OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI,
> +	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI,

That's a blunder from my end! Thanks for the fix.

Archit

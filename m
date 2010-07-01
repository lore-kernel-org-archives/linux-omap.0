From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] [RFC][PATCH 2/8] OMAP: DSS2: Add new Overlay Manager
Date: Thu, 01 Jul 2010 14:34:33 +0300
Message-ID: <1277984073.2474.322.camel@tubuntu.research.nokia.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
	 <1277980285-20996-2-git-send-email-archit@ti.com>
	 <1277980285-20996-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51049 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569Ab0GALfS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 07:35:18 -0400
In-Reply-To: <1277980285-20996-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

On Thu, 2010-07-01 at 12:31 +0200, ext Archit Taneja wrote:
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> Add new Overlay Manager in manager.c, make secondary channel changes
> and update supported displays for the managers in OMAP4
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Mukund Mittal <mmittal@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> Signed-off-by: Samreen <samreen@ti.com>
> ---

<snip>
 
> @@ -1471,15 +1471,25 @@ int dss_init_overlay_managers(struct platform_device *pdev)
>  		case 0:
>  			mgr->name = "lcd";
>  			mgr->id = OMAP_DSS_CHANNEL_LCD;
> -			mgr->supported_displays =
> -				OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
> -				OMAP_DISPLAY_TYPE_SDI | OMAP_DISPLAY_TYPE_DSI;
> +			mgr->supported_displays = OMAP_DISPLAY_TYPE_DBI |
> +				OMAP_DISPLAY_TYPE_DSI;
> +			if (cpu_is_omap34xx())
> +				mgr->supported_displays |=
> +					OMAP_DISPLAY_TYPE_DPI |
> +					OMAP_DISPLAY_TYPE_SDI;

How about OMAP2?

 Tomi


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 6/9] OMAP4 : DSS2 : HDMI: HDMI panel driver addition
 in the DSS
Date: Wed, 9 Mar 2011 16:23:56 +0200
Message-ID: <1299680636.2151.96.camel@deskari>
References: <1299671118-20839-1-git-send-email-mythripk@ti.com>
	 <1299671118-20839-2-git-send-email-mythripk@ti.com>
	 <1299671118-20839-3-git-send-email-mythripk@ti.com>
	 <1299671118-20839-4-git-send-email-mythripk@ti.com>
	 <1299671118-20839-5-git-send-email-mythripk@ti.com>
	 <1299671118-20839-6-git-send-email-mythripk@ti.com>
	 <1299671118-20839-7-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40093 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757001Ab1CIOYA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 09:24:00 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p29ENxAV015736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 9 Mar 2011 08:23:59 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p29ENxRG018165
	for <linux-omap@vger.kernel.org>; Wed, 9 Mar 2011 08:23:59 -0600 (CST)
In-Reply-To: <1299671118-20839-7-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 2011-03-09 at 05:45 -0600, K, Mythri P wrote:
> The panel driver(hdmi_omap4_panel.c) in omap2/dss acts as a controller
> to manage the enable and disable requests and synchronize audio and video.
> 
> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/Kconfig            |    8 +
>  drivers/video/omap2/dss/Makefile           |    1 +
>  drivers/video/omap2/dss/hdmi_omap4_panel.c |  209 ++++++++++++++++++++++++++++
>  3 files changed, 218 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/omap2/dss/hdmi_omap4_panel.c
> 
> diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
> index 7749ddb..f66043f 100644
> --- a/drivers/video/omap2/dss/Kconfig
> +++ b/drivers/video/omap2/dss/Kconfig
> @@ -125,4 +125,12 @@ config OMAP2_DSS_MIN_FCK_PER_PCK
>  	  Max FCK is 173MHz, so this doesn't work if your PCK
>  	  is very high.
>  
> +config OMAP4_PANEL_HDMI
> +	bool "HDMI panel support"
> +	depends on OMAP2_DSS_HDMI
> +        default n
> +	help
> +	  HDMI panel. This adds the High Definition Multimedia panel.
> +	  See http://www.hdmi.org/ for HDMI specification.
> +
>  endif
> diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
> index 5998b69..7ee4093 100644
> --- a/drivers/video/omap2/dss/Makefile
> +++ b/drivers/video/omap2/dss/Makefile
> @@ -6,3 +6,4 @@ omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o
>  omapdss-$(CONFIG_OMAP2_DSS_SDI) += sdi.o
>  omapdss-$(CONFIG_OMAP2_DSS_DSI) += dsi.o
>  omapdss-$(CONFIG_OMAP2_DSS_HDMI) += hdmi.o
> +omapdss-$(CONFIG_OMAP4_PANEL_HDMI) += hdmi_omap4_panel.o

You don't need CONFIG_OMAP4_PANEL_HDMI. In fact, you cannot have it:
hdmi.c calls the panel driver, so they must be compiled in or out
together.

Also, as they depend on each other, adding them in patches like this
breaks compilation. Do it so that first add hdmi.c in a patch. Then
hdmi_omap4_panel.c. After those, add Kconfig and Makefile changes. This
way the kernel stays compilable, and you can still have the additions
divided into separate patches.

 Tomi



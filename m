From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 0/7] OMAP: DSS2: DSI2 for secondary lcd panel on
 OMAP4
Date: Fri, 13 May 2011 08:51:42 +0300
Message-ID: <1305265902.2268.0.camel@deskari>
References: <1305201390-9724-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:38387 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261Ab1EMFvs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 01:51:48 -0400
Received: by mail-ew0-f48.google.com with SMTP id 22so903891ewy.21
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 22:51:46 -0700 (PDT)
In-Reply-To: <1305201390-9724-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2011-05-12 at 17:26 +0530, Archit Taneja wrote:
> OMAP4 has a DSI2 module, whose lanes are connected to the secondary lcd panel on
> blaze and 4430sdp.
> Modify dsi.c driver to register and work multiple DSI devices. Make the
> necessary changes needed to introduce DSI2 PLL clocks.
> 
> Changes since v1:
> -Rename functions used for getting dsidev
> -Remove FEAT_DSS_DSI2
> -Rework debugfs usage for dsi
> 
> Applies over:
> 
> https://gitorious.org/linux-omap-dss2/linux/commits/master
> 
> Archit Taneja (7):
>   OMAP: DSS2: DSI: Add extra omap_dss_device argument in functions
>     exported by dsi
>   OMAP: DSS2: Remove omap_dss_device argument from dsi_pll_init()
>   OMAP: DSS2: Pass platform_device as an argument in dsi functions
>   OMAP: DSS2: DSI: Use platform_device pointer to get dsi data
>   OMAP: DSS2: DSI: Pass pointer to struct to packet_sent_handler isrs
>   OMAP4: DSS2: DSI: Changes for DSI2 on OMAP4
>   OMAP: DSS2: Taal: Use device name in backlight_device_register
> 
>  drivers/video/omap2/displays/panel-taal.c |  124 +-
>  drivers/video/omap2/dss/core.c            |    6 +-
>  drivers/video/omap2/dss/dispc.c           |   16 +-
>  drivers/video/omap2/dss/dpi.c             |   36 +-
>  drivers/video/omap2/dss/dsi.c             | 1783 +++++++++++++++++------------
>  drivers/video/omap2/dss/dss.c             |   44 +-
>  drivers/video/omap2/dss/dss.h             |   45 +-
>  drivers/video/omap2/dss/dss_features.c    |    2 +
>  drivers/video/omap2/dss/dss_features.h    |    1 +
>  include/video/omapdss.h                   |   39 +-
>  10 files changed, 1261 insertions(+), 835 deletions(-)

Thanks, applied.

 Tomi



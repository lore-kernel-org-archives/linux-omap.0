From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/4] OMAP2PLUS: DSS2: Clock configuration enhancements
 and fixes
Date: Wed, 13 Apr 2011 10:19:25 +0300
Message-ID: <1302679165.2130.36.camel@deskari>
References: <1302596546-14888-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45843 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754607Ab1DMHTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Apr 2011 03:19:30 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so379025wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 13 Apr 2011 00:19:28 -0700 (PDT)
In-Reply-To: <1302596546-14888-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2011-04-12 at 13:52 +0530, Archit Taneja wrote:
> Currently, the clock sources for internal DSS clocks are hardcoded in DSS2, this
> causes issues when displays want to configure clocks differently, or when there
> are multiple displays trying to configure the clock sources for the same clocks.
> 
> Move the clock sources to dssdev.clocks struct, and perform cleanup related to
> this.
> 
> Note: Patches apply over:
> https://gitorious.org/linux-omap-dss2/linux/commits/master
> 
> Archit Taneja (4):
>   OMAP2PLUS: DSS2: Change enum "dss_clk_source" to
>     "omap_dss_clk_source"
>   OMAP2PLUS: DSS2: Add clock sources to dss device clock configuration
>   OMAP: DSS2: HDMI: Use dss_device clock configuration for HDMI PLL
>     parameters
>   OMAP2PLUS: DSS2: Remove hack config "CONFIG_OMAP2_DSS_USE_DSI_PLL"
> 
>  arch/arm/mach-omap2/board-4430sdp.c       |   18 ++++++-
>  arch/arm/plat-omap/include/plat/display.h |   24 ++++++++-
>  drivers/video/omap2/dss/Kconfig           |    8 ---
>  drivers/video/omap2/dss/dispc.c           |   12 ++--
>  drivers/video/omap2/dss/dpi.c             |   83 +++++++++++++++--------------
>  drivers/video/omap2/dss/dsi.c             |   49 +++++++----------
>  drivers/video/omap2/dss/dss.c             |   50 +++++++++---------
>  drivers/video/omap2/dss/dss.h             |   23 +++------
>  drivers/video/omap2/dss/dss_features.c    |   20 ++++----
>  drivers/video/omap2/dss/dss_features.h    |    2 +-
>  drivers/video/omap2/dss/hdmi.c            |   27 +++++-----
>  11 files changed, 164 insertions(+), 152 deletions(-)

I think this patch set looks fine. I'll apply.

 Tomi




From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 0/9] OMAPDSS: OMAP5 related patches
Date: Tue, 25 Sep 2012 10:50:29 +0530
Message-ID: <50613F1D.30006@ti.com>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47069 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953Ab2IYFU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Sep 2012 01:20:28 -0400
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 24 September 2012 07:28 PM, Tomi Valkeinen wrote:
> Hi,
>
> This series adds basic OMAP5 DSS functionality, mainly related to DSS core, DPI
> and DSI.

Looks good to me.

Archit

>
>   Tomi
>
> Archit Taneja (1):
>    OMAPDSS: Add basic omap5 features to dss and dispc
>
> Tomi Valkeinen (8):
>    OMAPDSS: DSI: improve DSI clock calcs for DISPC
>    OMAPDSS: move dss feats to the end of dss.c
>    OMAPDSS: Add support for DPI source selection
>    OMAPDSS: DSI: Add FEAT_DSI_PLL_SELFREQDCO
>    OMAPDSS: DSI: Add FEAT_DSI_PLL_REFSEL
>    OMAPDSS: DSI: Add new linebuffer size for OMAP5
>    OMAPDSS: DSI: Add code to disable PHY DCC
>    OMAPDSS: DSI: make OMAP2_DSS_DSI depend on ARCH_OMAP5
>
>   drivers/video/omap2/dss/Kconfig        |    2 +-
>   drivers/video/omap2/dss/dispc.c        |    2 +
>   drivers/video/omap2/dss/dpi.c          |    5 +
>   drivers/video/omap2/dss/dsi.c          |  167 +++++++++++++++++++++++++-------
>   drivers/video/omap2/dss/dss.c          |  121 ++++++++++++++++++-----
>   drivers/video/omap2/dss/dss.h          |    1 +
>   drivers/video/omap2/dss/dss_features.c |   96 ++++++++++++++++++
>   drivers/video/omap2/dss/dss_features.h |    3 +
>   8 files changed, 337 insertions(+), 60 deletions(-)
>


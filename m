From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/4] OMAP: DSS2: Miscellaneous DSI cleanup and fixes
Date: Tue, 17 May 2011 14:58:39 +0300
Message-ID: <1305633519.1847.12.camel@deskari>
References: <1305539229-28560-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:39148 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753939Ab1EQL6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 May 2011 07:58:43 -0400
Received: by mail-ey0-f179.google.com with SMTP id 5so130760eyg.10
        for <linux-omap@vger.kernel.org>; Tue, 17 May 2011 04:58:42 -0700 (PDT)
In-Reply-To: <1305539229-28560-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2011-05-16 at 15:17 +0530, Archit Taneja wrote:
> Some minor fixes/cleanup for DSI:
> - Remove some debug prints in dsi_dump_clocks().
> - Use system workqueue instead of creating a private one.
> - Add num_data_lanes and line_buffer_size and get the from DSI_GNQ register.
> 
> Archit Taneja (4):
>   OMAP: DSS2: DSI: Remove DISPC pixel clock related info in
>     dsi_dump_clocks()
>   OMAP: DSS2: DSI: Use system workqueue for delayed work instead of a
>     private workqueue
>   OMAP: DSS2: DSI: Get number of DSI data lanes using DSI_GNQ register
>   OMAP: DSS2: DSI: Get line buffer size from DSI_GNQ register
> 
>  drivers/video/omap2/dss/dsi.c          |  163 +++++++++++++++++++++++++-------
>  drivers/video/omap2/dss/dss_features.c |    3 +-
>  drivers/video/omap2/dss/dss_features.h |    1 +
>  include/video/omapdss.h                |    4 +
>  4 files changed, 134 insertions(+), 37 deletions(-)

Thanks, applied.

 Tomi



From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 18/20] OMAPDSS: DSI: delay dispc initialization
Date: Mon, 11 Mar 2013 11:35:24 +0530
Message-ID: <513D7424.1000609@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com> <1362743515-10152-19-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50668 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab3CKGGH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 02:06:07 -0400
In-Reply-To: <1362743515-10152-19-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 08 March 2013 05:21 PM, Tomi Valkeinen wrote:
> We currently setup both DSI and DISPC related things when the DSI bus is
> enabled. There's no need for DISPC related thing at that point, though,
> but only later when the video output is enabled.
>
> To make it possible to use the DSI bus before DISPC overlay manager is
> selected, this patch moves DSI's DISPC initialization to
> dsi_enable_video_output(), from omapdss_dsi_display_enable(). We also
> move the selection of DISPC's LCD clock to dsi_enable_video_output.
>
> This way there are no DISPC dependencies until the video output is
> enabled.

This is a good patch. I hope CDF also makes sure the Display controller 
and DSI bus are made more independent in this manner.

One thing which we should eventually add is to ensure that 
omap_dsi_update() for command mode panels is called only after 
dsi_enable_video_output() is called. I think we manage this in our panel 
driver, but maybe some sort of check could help there.

<snip>

Archit


From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 0/2] OMAP3 ISP: Simplify clock usage
Date: Mon, 14 Jan 2013 17:10:15 -0800
Message-ID: <20130115011015.23734.75232@quantum>
References: <1357652634-17668-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:50971 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754Ab3AOBKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jan 2013 20:10:31 -0500
Received: by mail-pa0-f53.google.com with SMTP id hz1so2553039pad.40
        for <linux-omap@vger.kernel.org>; Mon, 14 Jan 2013 17:10:31 -0800 (PST)
In-Reply-To: <1357652634-17668-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@iki.fi>

Quoting Laurent Pinchart (2013-01-08 05:43:52)
> Hello,
> 
> Now that the OMAP3 supports the common clock framework, clock rate
> back-propagation is available for the ISP clocks. Instead of setting the
> cam_mclk parent clock rate to control the cam_mclk clock rate, we can mark the
> dpll4_m5x2_ck_3630 and cam_mclk clocks as supporting back-propagation, and set
> the cam_mclk rate directly. This simplifies the ISP clocks configuration.
>

I'm pleased to see this feature get used on OMAP.  Plus your driver gets
a negative diffstat :)

Reviewed-by: Mike Turquette <mturquette@linaro.org>
 
> Laurent Pinchart (2):
>   ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to
>     dpll4_m5
>   omap3isp: Set cam_mclk rate directly
> 
>  arch/arm/mach-omap2/cclock3xxx_data.c |   10 +++++++++-
>  drivers/media/platform/omap3isp/isp.c |   18 ++----------------
>  drivers/media/platform/omap3isp/isp.h |    8 +++-----
>  3 files changed, 14 insertions(+), 22 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart

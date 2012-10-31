From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 09/12] OMAPDSS: hide dss_select_dispc_clk_source()
Date: Wed, 31 Oct 2012 12:24:15 +0530
Message-ID: <5090CB17.4070400@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-10-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44624 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881Ab2JaGyc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Oct 2012 02:54:32 -0400
In-Reply-To: <1351613409-21186-10-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
> dss.c currently exposes functions to configure the dispc source clock
> and lcd source clock. There are configured separately from the output
> drivers.
>
> However, there is no safe way for the output drivers to handle dispc
> clock, as it's shared between the outputs. Thus, if, say, the DSI driver
> sets up DSI PLL and configures both the dispc and lcd clock sources to
> that DSI PLL, the resulting dispc clock could be too low for, say, HDMI.
>
> Thus the output drivers should really only be concerned about the lcd
> clock, which is what the output drivers actually use. There's lot to do
> to clean up the dss clock handling, but this patch takes one step
> forward and removes the use of dss_select_dispc_clk_source() from the
> output drivers.
>
> After this patch, the output drivers only configure the lcd source
> clock. On omap4+ the dispc src clock is never changed from the default
> PRCM source. On omap3, where the dispc and lcd clocks are actually the
> same, setting the lcd clock source sets the dispc clock source.

Maybe we could have one call to dss_select_dispc_clk_source() in 
omap_dsshw_porbe(). This is not necessary now, but if we support a 
splash screen on bootloader, and skip the hwmod resets, we might want to 
switch back our dispc clock source to PRCM if the output drivers don't 
to it. This is just a point though, we don't necessarily need it right now.

Archit

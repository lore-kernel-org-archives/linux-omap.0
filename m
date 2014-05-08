From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Thu, 8 May 2014 04:37:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37573 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbaEHEhb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 00:37:31 -0400
In-Reply-To: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Wed, 12 Mar 2014, Tomi Valkeinen wrote:

> This patch adds hwmod data for omap5 display subsystem. I have tested this on
> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet, as the
> mainline is missing omap5 HDMI driver.
> 
> I do see this when booting:
> 
>   omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>   omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>   omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>   omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>   omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
> 
> But at least DSI works just fine.

Am looking at this for v3.16.  But I think someone needs to take a look at 
those warnings and figure out why they are happening.

Is the soc_ops.wait_target_ready() call failing in omap_hwmod.c:_enable() 
? 


- Paul

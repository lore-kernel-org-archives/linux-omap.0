From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [Query] OMAP: DSS2: Margin for downscaling in clock
 calculations
Date: Tue, 18 Jan 2011 16:19:29 +0200
Message-ID: <1295360369.27310.18.camel@tubuntu>
References: <FCCFB4CDC6E5564B9182F639FC356087035F86FA74@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:53787 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668Ab1AROTg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 09:19:36 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087035F86FA74@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-01-18 at 10:45 +0530, ext Taneja, Archit wrote:
> Hi,
> 
> I was going through the DSS2 code which sets up the FCLK
> coming from PRCM and the DISPC divivors to get the required pixel
> clock. 
>  
> The function dss_calc_clock_div() does a brute force search across
> all possible values of: a) DPLL divisor whose output goes to DSS, b)
> DISPC_DIVISOR.LCD, c) DISPC_DIVISOR.pcd
> 
> The combination which gives a clock frequency closest to the
> required pixel clock is chosen.
> 
> Hence, it seems that the resultant DISPC_FCLK clock frequency doesn't
> take into account the extra margin needed for downscaling:
> 
> Req dispc_fclk >= pck * hscale_ratio * vscale_ration * K
> 
> Do you thing putting a further constraint (like DISPC_FCLK needs to be
> greater than a given value) should be a part of the calculations to
> ensure successful scaling?

It's been a while since I looked at the fclk requirements, but isn't the
current CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK enough? It is quite hackish and
static, but a proper implementation is much harder (dynamically changing
the clocks depending on the scaling).

Or were there some additional restrictions?

 Tomi



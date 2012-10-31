From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 05/12] OMAPDSS: DSI: skip odd dividers when pck >= 100MHz
Date: Wed, 31 Oct 2012 12:15:13 +0530
Message-ID: <5090C8F9.4060103@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-6-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40734 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2JaGpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 02:45:30 -0400
In-Reply-To: <1351613409-21186-6-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com

On Tuesday 30 October 2012 09:40 PM, Tomi Valkeinen wrote:
> The DSI PLL and HSDivider can be used to generate the pixel clock for
> LCD overlay manager, which then goes to DPI output. On the DPI output
> pin the voltage of the signal is shifted from the OMAP's internal
> minimal voltage to 1.8V range. The shifting is not instant, and the
> higher the clock frequency, the less time there is to shift the signal
> to nominal voltage.
>
> If the HSDivider's divider is greater than one and odd, the resulting
> pixel clock does not have 50% duty cycle. For example, with a divider of
> 3, the duty cycle is 33%.
>
> When combining high frequency (in the area of 140MHz+) and non-50% duty
> cycle, it has been observed the the shifter does not have enough time to
> shift the voltage enough, and this leads to bad signal which is rejected
> by monitors.

Is this something seen on OMAP3 also? I guess it must be since it's the 
same DSI IP.

>
> As a workaround this patch makes the divider calculation skip all odd
> dividers when the required pixel clock is over 100MHz.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dsi.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 7d0db2b..d0e35da 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -1386,6 +1386,11 @@ retry:
>   				cur.dsi_pll_hsdiv_dispc_clk =
>   					cur.clkin4ddr / cur.regm_dispc;
>
> +				if (cur.regm_dispc > 1 &&
> +						cur.regm_dispc % 2 != 0 &&
> +						req_pck >= 1000000)
> +					continue;
> +

Why do we do the req_pck check here? Can't we do it much earlier? We 
could bail out right in the beginning of dsi_pll_calc_clock_div_pck() if 
we see that req_pck is greater than 100 Mhz.

Also, we could maybe have a comment (or in the commit message) saying 
that we chose the 100 Mhz to make it a safe bet.

Archit


From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: OMAP: board-4430sdp: MUX configuration for sys_nirq2
Date: Fri, 06 Jul 2012 07:16:25 -0700
Message-ID: <874nplc6va.fsf@ti.com>
References: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
	<1341580752-5501-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35849 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752181Ab2GFOQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 10:16:18 -0400
Received: by pbbro8 with SMTP id ro8so17579761pbb.39
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 07:16:11 -0700 (PDT)
In-Reply-To: <1341580752-5501-2-git-send-email-peter.ujfalusi@ti.com> (Peter
	Ujfalusi's message of "Fri, 6 Jul 2012 15:19:11 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:

> The sys_nirq2 is used for twl6040, make sure the pin is configured
> correctly.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index c4e17641..72cd206 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -827,6 +827,9 @@ static void __init omap_4430sdp_display_init(void)
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
>  	OMAP4_MUX(USBB2_ULPITLL_CLK, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> +	/* NIRQ2 for twl6040 */
> +	OMAP4_MUX(SYS_NIRQ2, OMAP_MUX_MODE0 |
> +		  OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),

Since this is TWL6030 specific, it should rather be done in TWL code
like I did for sys_nirq1:
   
   http://marc.info/?l=linux-omap&m=134090312118873&w=2

That would avoid having to do this in both board files.

I thought about adding sys_nirq2 in my patch too, but did not know how
to properly test it.

Kevin

>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };

From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 01/10] omap: Use separate init_irq functions to avoid cpu_is_omap tests early
Date: Mon, 27 Jun 2011 10:08:48 -0700
Message-ID: <87fwmvcicf.fsf@ti.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092327.357.92354.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:54366 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762Ab1F0RIx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Jun 2011 13:08:53 -0400
Received: by mail-pv0-f175.google.com with SMTP id 24so3157482pvf.6
        for <linux-omap@vger.kernel.org>; Mon, 27 Jun 2011 10:08:51 -0700 (PDT)
In-Reply-To: <20110620092327.357.92354.stgit@kaulin> (Tony Lindgren's message
	of "Mon, 20 Jun 2011 02:23:28 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> This allows us to remove cpu_is_omap calls from init_irq functions.
> There should not be any need for cpu_is_omap calls as at this point.
> During the timer init we only care about SoC generation, and not about
> subrevisions.
>
> The main reason for the patch is that we want to initialize only
> minimal omap specific code from the init_early call.
>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c      |    2 +-
>  arch/arm/mach-omap1/board-fsample.c        |    2 +-
>  arch/arm/mach-omap1/board-generic.c        |    2 +-
>  arch/arm/mach-omap1/board-h2.c             |    2 +-
>  arch/arm/mach-omap1/board-h3.c             |    2 +-
>  arch/arm/mach-omap1/board-htcherald.c      |    2 +-
>  arch/arm/mach-omap1/board-innovator.c      |    2 +-
>  arch/arm/mach-omap1/board-nokia770.c       |    2 +-
>  arch/arm/mach-omap1/board-osk.c            |    2 +-
>  arch/arm/mach-omap1/board-palmte.c         |    2 +-
>  arch/arm/mach-omap1/board-palmtt.c         |    2 +-
>  arch/arm/mach-omap1/board-palmz71.c        |    2 +-
>  arch/arm/mach-omap1/board-perseus2.c       |    2 +-
>  arch/arm/mach-omap1/board-sx1.c            |    2 +-
>  arch/arm/mach-omap1/board-voiceblue.c      |    2 +-
>  arch/arm/mach-omap1/irq.c                  |    2 +-
>  arch/arm/mach-omap2/board-2430sdp.c        |    2 +-
>  arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
>  arch/arm/mach-omap2/board-3630sdp.c        |    2 +-
>  arch/arm/mach-omap2/board-am3517crane.c    |    2 +-
>  arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
>  arch/arm/mach-omap2/board-apollon.c        |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c         |    2 +-

Note this board has another machine_desc added in devel-board which
doesn't have the changes necessary for this.

When using devel-timer + devel-board, this is also needed to compile, so
devel-timer should probably be rebased on devel-board (or vice versa.)

Kevin

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 43dda76..b5d0d77 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -687,7 +687,7 @@ MACHINE_START(CM_T3730, "Compulab CM-T3730")
 	.reserve        = omap_reserve,
 	.map_io         = omap3_map_io,
 	.init_early     = cm_t35_init_early,
-	.init_irq       = omap_init_irq,
+	.init_irq       = omap3_init_irq,
 	.init_machine   = cm_t3730_init,
-	.timer          = &omap_timer,
+	.timer          = &omap3_timer,
 MACHINE_END

From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [RFC part1/2 merge v3][PATCH 00/10] omap2/3/4: uart4 fixes +
 zoom2/3 changes
Date: Tue, 9 Mar 2010 10:33:47 -0600
Message-ID: <A24693684029E5489D1D202277BE894453E4D741@dlee02.ent.ti.com>
References: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60393 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab0CIQdz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Mar 2010 11:33:55 -0500
In-Reply-To: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>

Hi,

On a general note.

To avoid spamming with frequent resends and version changes, I'll better
wait for any of you to review it today, and tomorrow I'll resend, grouping
all comments I'll receive today.

Thanks for your attention, comments and time!

Regards,
Sergio


> -----Original Message-----
> From: Aguirre, Sergio
> Sent: Tuesday, March 09, 2010 10:17 AM
> To: linux-omap@vger.kernel.org
> Cc: Kevin Hilman; Pandita, Vikram; Paul Walmsley; Tony Lindgren; Felipe
> Balbi; Aguirre, Sergio
> Subject: [RFC part1/2 merge v3][PATCH 00/10] omap2/3/4: uart4 fixes +
> zoom2/3 changes
> 
> Hi,
> 
> This is v3 of my serial work series merge found here: [1].
> 
> And it's meant to be applied on top of Thomas's patch: [2]
> 
> Changelog compared to previous version:
>  - Added WARN_ON when no clocks acquired for a uart to be
>    initialized. (Thanks Felipe and Kevin)
>  - Added missing patch description to patch:
>      "OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs"
>  - Replaced unexisting word "initted" -> "initialized" (Thanks Kevin)
> 
> Please let me know your comments and thoughts.
> 
> Thanks to:
>  - Vikram Pandita
>  - Paul Walmsley
>  - Kevin Hilman
>  - Manjunath Kondaiah
>  - Felipe Balbi
> 
> For the feedback recieved so far. I really appreciate it.
> 
> Regards,
> Sergio
> 
> Detailed changelog:
> 
> Sergio Aguirre (10):
>   OMAP3: serial: Check for zero-based physical addr
>   omap2/3/4: serial: Remove condition for getting uart4_phys
>   ARM: OMAP3630: PRCM: Add UART4 control bits
>   OMAP clock: Add uart4_ick/fck definitions for 3630
>   OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
>   omap3: serial: Fix uart4 handling for 3630
>   omap3: zoom2/3 / 3630sdp: Don't init always all uarts
>   omap3: 3630sdp: Explicitly enable all UARTs
>   omap3: zoom 2/3: Change debugboard serial port id
>   omap3: zoom2/3: Register only 1 8250 port
> 
>  arch/arm/configs/omap_zoom2_defconfig        |    2 +-
>  arch/arm/configs/omap_zoom3_defconfig        |    2 +-
>  arch/arm/mach-omap2/board-3630sdp.c          |    1 +
>  arch/arm/mach-omap2/board-zoom-debugboard.c  |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 -
>  arch/arm/mach-omap2/clock3xxx_data.c         |   22 +++++++++++++++
>  arch/arm/mach-omap2/cm-regbits-34xx.h        |    2 +
>  arch/arm/mach-omap2/pm34xx.c                 |    8 ++++-
>  arch/arm/mach-omap2/prcm-common.h            |    4 +++
>  arch/arm/mach-omap2/serial.c                 |   37 ++++++++++++++++-----
> -----
>  arch/arm/plat-omap/include/plat/irqs.h       |    2 +
>  11 files changed, 63 insertions(+), 20 deletions(-)
>  mode change 100755 => 100644 arch/arm/mach-omap2/board-3630sdp.c
>  mode change 100755 => 100644 arch/arm/mach-omap2/board-zoom-peripherals.c
> 
> [1] http://marc.info/?l=linux-omap&m=126806929506991&w=2
> [2] http://marc.info/?l=linux-kernel&m=126709078514087&w=2


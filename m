From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5] Initial change for merge of new board
Date: Thu, 22 Apr 2010 18:48:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004221844040.24256@utopia.booyaka.com>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59450 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754511Ab0DWAsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Apr 2010 20:48:25 -0400
In-Reply-To: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laine Walker-Avina <lwalkera@ieee.org>
Cc: linux-omap@vger.kernel.org

Hello Laine,

On Tue, 6 Apr 2010, Laine Walker-Avina wrote:

> I'm beginning to merge some of the changes for my new board. These include:
>    * Adding macros to compute the ACTIM values for the SDRAM timings, 
> eliminating magic numbers. The original authors may want to verify their 
> timings were converted correctly.

Have you verified that your changes result in the correct values?

Also, have you looked at the approach used in 
arch/arm/mach-omap2/board-rx51-sdram.c.  That seems like a better way?

>    * Adding the ability to use the clock API to select the divider for sys_clkout2
>    * Making the GPRC timing API aware of the time-granularity flag
> 
> Let me know if there are any comments or questions.
> 
> Cheers,
> Laine Walker-Avina
> PASCO scientific
> 
> ----
> 
> Laine Walker-Avina (5):
>   OMAP: Add in helper macros for the SDRAM timings
>   OMAP: Convert the sdram-*.h timings to use the SDRAM timing macros
>   OMAP: Add SDRAM timings for Micron mt46h16m32lf-6
>   OMAP: Add support for setting the divider for sys_clkout2 using
>     clk_set_rate
>   OMAP: Make set_gpmc_timing_reg aware of the TIMEPARAGRANULARITY flag
> 
>  arch/arm/mach-omap2/clock3xxx_data.c               |    1 +
>  arch/arm/mach-omap2/gpmc.c                         |   14 +++-
>  arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   44 ++++++++-----
>  arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h  |   67 ++++++++++++++++++++
>  arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   44 ++++++++-----
>  arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h     |   52 +++++++++------
>  .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   50 +++++++++------
>  arch/arm/plat-omap/include/plat/sdrc.h             |   23 +++++++
>  8 files changed, 220 insertions(+), 75 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul

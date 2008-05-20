From: "Chandra shekhar" <x0044955@ti.com>
Subject: RE: [PATCH 0/4] Updates on mcbsp driver (take #2)
Date: Tue, 20 May 2008 12:17:40 +0530
Message-ID: <003701c8ba45$6800c5d0$318918ac@ent.ti.com>
References: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36657 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbYETGr7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2008 02:47:59 -0400
In-Reply-To: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Eduardo Valentin' <edubezval@gmail.com>, linux-omap@vger.kernel.org
Cc: 'Tony Lindgren' <tony@atomide.com>, 'Eduardo Valentin' <eduardo.valentin@indt.org.br>

Acking mcbsp patch which transforms cureent mcbsp into a platform driver. 

Regards,
Chandra

> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com] 
> Sent: Tuesday, May 06, 2008 2:53 AM
> To: linux-omap@vger.kernel.org
> Cc: Tony Lindgren; Chandra shekhar; Eduardo Valentin
> Subject: [PATCH 0/4] Updates on mcbsp driver (take #2)
> 
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> Hi Tony,
> 
> Here is the updated version of my previous patches.
> DMA and IRQ definitions were left as they are. Chandra is 
> going to send his work on top of this series.
> 
> This patch series updates mcbsp driver by transforming it 
> into a platform driver. This is a very initial implementation.
> Basically it moves machine specific code to their correct 
> place and creates the platform driver necessary structures.
> 
> It must be working for previous boards. For omap34xx it 
> should work for mcbsp 1 and 2.
> 
> In order to do not break other places, I tryied to do not 
> change previous API. But future improvements are needed.
> 
> Clock definitions for  mcbsp 1 and 2 were also modified to 
> add correct support for omap34xx.
> 
> Comments are wellcome.
> 
> Cheers,
> 
> 
> Eduardo Valentin (4):
>   PLAT-OMAP: MCBSP: Tranform into platform driver
>   MACH-OMAP1: MCBSP: Add support for mcbsp on mach-omap1
>   Fix mcbsp clock definition on clock34xx.h
>   MACH-OMAP2: MCBSP: Add support for mcbsp on mach-omap2
> 
>  arch/arm/mach-omap1/Makefile      |    2 +
>  arch/arm/mach-omap1/mcbsp.c       |  165 +++++++++
>  arch/arm/mach-omap2/Makefile      |    2 +
>  arch/arm/mach-omap2/clock34xx.h   |   30 ++-
>  arch/arm/mach-omap2/mcbsp.c       |  105 ++++++
>  arch/arm/plat-omap/devices.c      |   45 +++
>  arch/arm/plat-omap/mcbsp.c        |  660 
> ++++++++++++++-----------------------
>  include/asm-arm/arch-omap/mcbsp.h |   73 ++++-
>  8 files changed, 661 insertions(+), 421 deletions(-)  create 
> mode 100644 arch/arm/mach-omap1/mcbsp.c  create mode 100644 
> arch/arm/mach-omap2/mcbsp.c
> 
> 


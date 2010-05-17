From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: RE: [PATCH 00/14] dspbridge: rewrite deh
Date: Mon, 17 May 2010 14:08:08 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602CB6CB3C9@dlee06.ent.ti.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48456 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419Ab0EQTIL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 15:08:11 -0400
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, "Liu, Stanley" <stanley_liu@ti.com>, "Jansson, Cris" <cjansson@ti.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>


+Cris
+Stanley
Loop in DSP guys in case they would have something to add.


> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Sunday, May 16, 2010 10:46 AM
> To: linux-omap
> Cc: Ramirez Luna, Omar; Guzman Lugo, Fernando; Felipe Contreras
> Subject: [PATCH 00/14] dspbridge: rewrite deh
> 
> Hi,
> 
> Investigating the MMU fault corruption issue I found a lot of areas of
> improvements of the exception handling code.
> 
> Moreover, even though the obvious memory corruption is fixed on kernel
> side,
> there are still some rare cases where corruption in user-space might be
> possible if some buffers are still mapped. This came up in a discussion
> with
> Fernando Lugo, and we both agreed on a fix (patch #7).
> 
> The rest is mostly reorganization.
> 
> These apply on top of the MMU fault fix patch.
> 
> Felipe Contreras (14):
>   dspbridge: deh: refactor into wait_for_timer()
>   dspbridge: deh: trivial cleanups
>   dspbridge: mmufault: trivial cleanups
>   dspbridge: deh: free dummy page immediately
>   dspbridge: remove unused code
>   dspbridge: mmu: add hw_mmu_tlb_flush_all()
>   dspbridge: deh: ensure only tlb #0 is enabled
>   dspbridge: deh: refactor in mmu_fault_print_stack()
>   dspbridge: deh: remove get_info
>   dspbridge: deh: remove err_info
>   dspbridge: access deh directly
>   dspbridge: move mmufault to deh
>   dspbridge: deh: tidying up
>   dspbridge: deh: update copyright notice
> 
>  arch/arm/plat-omap/include/dspbridge/dbdefs.h  |    1 -
>  arch/arm/plat-omap/include/dspbridge/dspdefs.h |   75 -----
>  arch/arm/plat-omap/include/dspbridge/dspdeh.h  |   20 +-
>  drivers/dsp/bridge/Makefile                    |    2 +-
>  drivers/dsp/bridge/core/_deh.h                 |    2 +-
>  drivers/dsp/bridge/core/_tiomap.h              |    6 +-
>  drivers/dsp/bridge/core/mmu_fault.c            |  141 --------
>  drivers/dsp/bridge/core/mmu_fault.h            |   36 --
>  drivers/dsp/bridge/core/tiomap3430.c           |   17 +-
>  drivers/dsp/bridge/core/ue_deh.c               |  407 +++++++++++--------
> -----
>  drivers/dsp/bridge/hw/hw_mmu.c                 |    6 +
>  drivers/dsp/bridge/hw/hw_mmu.h                 |    2 +
>  drivers/dsp/bridge/pmgr/dev.c                  |   17 +-
>  drivers/dsp/bridge/rmgr/node.c                 |    5 +-
>  drivers/dsp/bridge/rmgr/proc.c                 |   29 +--
>  15 files changed, 215 insertions(+), 551 deletions(-)
>  delete mode 100644 drivers/dsp/bridge/core/mmu_fault.c
>  delete mode 100644 drivers/dsp/bridge/core/mmu_fault.h


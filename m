From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 0/4] DPC Removal from services
Date: Mon, 18 Jan 2010 13:15:20 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DE50E21@dlee03.ent.ti.com>
References: <1263598504-2353-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55095 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266Ab0ARTPv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 14:15:51 -0500
In-Reply-To: <1263598504-2353-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Ramirez Luna, Omar on Friday, January 15, 2010 5:35 PM
>
>This patches remove the DPC custom implementation and wrappers.
>
>They should be applied on top of "trivial cleanups" set and are
>part of the current patch queue.
>
>Omar Ramirez Luna (4):
>  DSPBRIDGE: Remove DPC, create, destroy and schedule wrappers
>  DSPBRIDGE: Remove main DPC wrapper for IO and MMUfault
>  DSPBRIDGE: Remove DPC module from SERVICES layer
>  DSPBRIDGE: Remove DPC object structure
>
> arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    1 -
> arch/arm/plat-omap/include/dspbridge/dpc.h      |  145 -------------
> arch/arm/plat-omap/include/dspbridge/io_sm.h    |    2 +-
> drivers/dsp/bridge/Makefile                     |    3 +-
> drivers/dsp/bridge/pmgr/chnl.c                  |    1 -
> drivers/dsp/bridge/services/dpc.c               |  246 -----------------------
> drivers/dsp/bridge/services/services.c          |   10 +-
> drivers/dsp/bridge/wmd/_deh.h                   |    5 +-
> drivers/dsp/bridge/wmd/io_sm.c                  |   86 ++++++--
> drivers/dsp/bridge/wmd/mmu_fault.c              |   12 +-
> drivers/dsp/bridge/wmd/mmu_fault.h              |    2 +-
> drivers/dsp/bridge/wmd/ue_deh.c                 |   13 +-
> 12 files changed, 87 insertions(+), 439 deletions(-)
> delete mode 100644 arch/arm/plat-omap/include/dspbridge/dpc.h
> delete mode 100644 drivers/dsp/bridge/services/dpc.c

Pushed to dspbridge

- omar

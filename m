From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 0/6] DSPBRIDGE: fixes from current patch queue
Date: Wed, 20 Jan 2010 16:53:04 -0600
Message-ID: <27F9C60D11D683428E133F85D2BB4A53042DF3B227@dlee03.ent.ti.com>
References: <1263934449-16891-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56438 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754835Ab0ATWxJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 17:53:09 -0500
In-Reply-To: <1263934449-16891-1-git-send-email-omar.ramirez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

>From: Ramirez Luna, Omar on Tuesday, January 19, 2010 2:54 PM
>
>Fixes and cleanups accumulated due to baseline sync.
>
>This set should be applied after "Return right error codes" patch set.
>
>Fernando Guzman Lugo (4):
>  DSPBRIDGE: remove NLDR_Free wrapper function
>  DSPBRIDGE: Optimize remove resource functions
>  DSPBRIDGE: remove wrong comment from RequestBridgeResources
>  DSPBRIDGE: Always print DSP traces
>
>Omar Ramirez Luna (2):
>  DSPBRIDGE: Rename DEBUG define to use menuconfig style
>  DSPBRIDGE: Remove unused variables from resource cleanup
>
> arch/arm/plat-omap/include/dspbridge/dbg.h         |    4 +-
> arch/arm/plat-omap/include/dspbridge/nldr.h        |    1 -
> arch/arm/plat-omap/include/dspbridge/nldrdefs.h    |    1 -
> .../plat-omap/include/dspbridge/resourcecleanup.h  |    3 +-
> drivers/dsp/bridge/Makefile                        |    2 +-
> drivers/dsp/bridge/gen/_gt_para.c                  |    2 +-
> drivers/dsp/bridge/gen/gt.c                        |    2 +-
> drivers/dsp/bridge/rmgr/drv.c                      |   98 ++++++++------------
> drivers/dsp/bridge/rmgr/drv_interface.c            |    4 +-
> drivers/dsp/bridge/rmgr/nldr.c                     |   19 +---
> drivers/dsp/bridge/rmgr/node.c                     |   13 +--
> drivers/dsp/bridge/rmgr/proc.c                     |   18 ++--
> drivers/dsp/bridge/rmgr/strm.c                     |    4 +-
> drivers/dsp/bridge/services/cfg.c                  |   14 ++--
> drivers/dsp/bridge/services/dbg.c                  |    4 +-
> drivers/dsp/bridge/services/mem.c                  |    2 +-
> drivers/dsp/bridge/wmd/io_sm.c                     |   10 +-
> 17 files changed, 82 insertions(+), 119 deletions(-)

Pushed to dspbridge

- omar

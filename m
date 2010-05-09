From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 4/5] DSPBRIDGE: Remove checkpatch errors regarding
 typedefs
Date: Sat, 8 May 2010 23:27:29 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD4963@dlee03.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90EC26227F0@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53549 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab0EIE1e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 May 2010 00:27:34 -0400
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90EC26227F0@dlee04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Uribe de Leon, Armando" <x0095078@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From b0957e554e4778c3d0136a408c703f46649539c8 Mon Sep 17 00:00:00 2001
>From: Armando Uribe De Leon <x0095078@ti.com>
>Date: Thu, 8 Apr 2010 18:49:12 -0500
>Subject: [PATCH 4/5] DSPBRIDGE: Remove checkpatch errors regarding typedefs
>
>This patch is intended to remove the checkpatch errors due to the use of tyoedefs.
>
>Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/_chnl_sm.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/chnldefs.h    |    4 +-
> arch/arm/plat-omap/include/dspbridge/chnlpriv.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/cod.h         |    4 +-
> arch/arm/plat-omap/include/dspbridge/dbdefs.h      |    4 +-
> arch/arm/plat-omap/include/dspbridge/dbtype.h      |    2 -
> arch/arm/plat-omap/include/dspbridge/dispdefs.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/drv.h         |    2 +-
> .../plat-omap/include/dspbridge/dynamic_loader.h   |    8 +--
> arch/arm/plat-omap/include/dspbridge/gb.h          |   14 +++---
> arch/arm/plat-omap/include/dspbridge/getsection.h  |   11 ++---
> arch/arm/plat-omap/include/dspbridge/msgdefs.h     |    2 +-
> arch/arm/plat-omap/include/dspbridge/node.h        |    2 +-
> .../plat-omap/include/dspbridge/resourcecleanup.h  |   46 ++++++++++----------
> arch/arm/plat-omap/include/dspbridge/rms_sh.h      |    2 +-
> arch/arm/plat-omap/include/dspbridge/rmstypes.h    |    1 -
> arch/arm/plat-omap/include/dspbridge/strm.h        |    2 +-
> arch/arm/plat-omap/include/dspbridge/strmdefs.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/wcdioctl.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/wmd.h         |    2 +-
> arch/arm/plat-omap/include/dspbridge/wmdmsg.h      |    2 +-
> drivers/dsp/bridge/dynload/cload.c                 |    6 +-
> drivers/dsp/bridge/dynload/dload_internal.h        |    3 +-
> drivers/dsp/bridge/dynload/getsection.c            |    8 ++--
> drivers/dsp/bridge/dynload/header.h                |    2 -
> drivers/dsp/bridge/dynload/reloc.c                 |    4 +-
> drivers/dsp/bridge/gen/gb.c                        |   29 ++++++------
> drivers/dsp/bridge/hw/GlobalTypes.h                |    4 +-
> drivers/dsp/bridge/pmgr/cod.c                      |    2 +-
> drivers/dsp/bridge/pmgr/dbll.c                     |    4 +-
> drivers/dsp/bridge/rmgr/drv.c                      |   36 ++++++++--------
> drivers/dsp/bridge/rmgr/drv_interface.c            |    4 +-
> drivers/dsp/bridge/rmgr/node.c                     |   10 ++--
> drivers/dsp/bridge/rmgr/strm.c                     |   10 ++--
> drivers/dsp/bridge/wmd/_msg_sm.h                   |    2 +-
> drivers/dsp/bridge/wmd/io_sm.c                     |    2 +-
> drivers/dsp/bridge/wmd/msg_sm.c                    |    2 +-
> 37 files changed, 116 insertions(+), 130 deletions(-)
>

Pushed to dspbridge.

- omar

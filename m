From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 3/5] DSPBRIDGE: Remove checkpatch errors: externs
Date: Sat, 8 May 2010 23:27:09 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD4962@dlee03.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90EC26227EF@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53519 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0EIE1R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 May 2010 00:27:17 -0400
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90EC26227EF@dlee04.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Uribe de Leon, Armando" <x0095078@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.DOYU@nokia.com" <hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From e1d6cb8395225dc9b74ccf33440b819555c948c9 Mon Sep 17 00:00:00 2001
>From: Armando Uribe De Leon <x0095078@ti.com>
>Date: Thu, 8 Apr 2010 16:35:05 -0500
>Subject: [PATCH 3/5] DSPBRIDGE: Remove checkpatch errors: externs
>
>This patche is intented to remove the
>checkpatch errors due to the definition
>of externs in c source files.
>
>Signed-off-by: Armando Uribe De Leon <x0095078@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/dbll.h  |    1 +
> arch/arm/plat-omap/include/dspbridge/dmm.h   |    5 +++++
> arch/arm/plat-omap/include/dspbridge/io_sm.h |   11 +++++++++++
> arch/arm/plat-omap/include/dspbridge/node.h  |    2 ++
> arch/arm/plat-omap/include/dspbridge/proc.h  |    2 ++
> drivers/dsp/bridge/pmgr/dbll.c               |    1 -
> drivers/dsp/bridge/pmgr/dmm.c                |    3 ---
> drivers/dsp/bridge/rmgr/drv.c                |    1 -
> drivers/dsp/bridge/rmgr/node.c               |    4 +---
> drivers/dsp/bridge/rmgr/proc.c               |    2 --
> drivers/dsp/bridge/wmd/_tiomap.h             |    6 ++++++
> drivers/dsp/bridge/wmd/_tiomap_pwr.h         |    6 ++++++
> drivers/dsp/bridge/wmd/io_sm.c               |   10 ----------
> drivers/dsp/bridge/wmd/mmu_fault.h           |    2 ++
> drivers/dsp/bridge/wmd/tiomap3430.c          |    6 ------
> drivers/dsp/bridge/wmd/tiomap3430_pwr.c      |    4 ----
> drivers/dsp/bridge/wmd/tiomap_io.c           |    2 +-
> drivers/dsp/bridge/wmd/ue_deh.c              |    1 -
> 18 files changed, 37 insertions(+), 32 deletions(-)
>

Pushed to dspbridge.

- omar

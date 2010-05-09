From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 01/11] DSPBRIDGE: Rename wmd_dev_context structure by
 bridge_dev_context
Date: Sat, 8 May 2010 23:30:08 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043DFD4966@dlee03.ent.ti.com>
References: <1272674751-21557-1-git-send-email-ivan.gomez@ti.com>
 <1272674751-21557-2-git-send-email-ivan.gomez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54951 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801Ab0EIEaM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 May 2010 00:30:12 -0400
In-Reply-To: <1272674751-21557-2-git-send-email-ivan.gomez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>Subject: [PATCH 01/11] DSPBRIDGE: Rename wmd_dev_context structure by bridge_dev_context
>
>This change is done because "wmd" refers to Windows OS.
>
>wmd = windows mini driver
>
>And the new name "bridge_dev_context" make more sense.
>
>Signed-off-by: Ivan Gomez Castellanos <ivan.gomez@ti.com>
>---
> arch/arm/plat-omap/include/dspbridge/dev.h   |    2 +-
> arch/arm/plat-omap/include/dspbridge/io_sm.h |   14 ++--
> arch/arm/plat-omap/include/dspbridge/wmd.h   |   30 ++++----
> drivers/dsp/bridge/pmgr/dev.c                |    4 +-
> drivers/dsp/bridge/pmgr/ioobj.h              |    3 +-
> drivers/dsp/bridge/rmgr/node.c               |    4 +-
> drivers/dsp/bridge/rmgr/proc.c               |    2 +-
> drivers/dsp/bridge/rmgr/pwr.c                |   16 ++--
> drivers/dsp/bridge/wmd/_deh.h                |    3 +-
> drivers/dsp/bridge/wmd/_tiomap.h             |   12 ++--
> drivers/dsp/bridge/wmd/_tiomap_mmu.h         |    2 +-
> drivers/dsp/bridge/wmd/_tiomap_pwr.h         |   26 ++++---
> drivers/dsp/bridge/wmd/_tiomap_util.h        |    2 +-
> drivers/dsp/bridge/wmd/io_sm.c               |   18 ++--
> drivers/dsp/bridge/wmd/mmu_fault.c           |    8 +-
> drivers/dsp/bridge/wmd/tiomap3430.c          |  116 +++++++++++++-------------
> drivers/dsp/bridge/wmd/tiomap3430_pwr.c      |   19 ++--
> drivers/dsp/bridge/wmd/tiomap_io.h           |   12 ++--
> drivers/dsp/bridge/wmd/ue_deh.c              |    8 +-
> 19 files changed, 154 insertions(+), 147 deletions(-)
>

Pushed the entire series to dspbridge.

- omar

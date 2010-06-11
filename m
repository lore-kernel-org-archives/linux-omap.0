From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 0/4] DSPBRIDGE: Remove comments refering to Windows OS.
Date: Fri, 11 Jun 2010 00:23:55 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E7CD942@dlee03.ent.ti.com>
References: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36764 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab0FKFYD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2010 01:24:03 -0400
In-Reply-To: <1274307702-22637-1-git-send-email-ivan.gomez@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gomez
>Castellanos, Ivan
>Sent: Wednesday, May 19, 2010 5:22 PM
>To: linux-omap@vger.kernel.org
>Cc: Hiroshi.DOYU@nokia.com; ameya.palande@nokia.com; felipe.contreras@nokia.com; Gomez Castellanos,
>Ivan
>Subject: [PATCH 0/4] DSPBRIDGE: Remove comments refering to Windows OS.
>
>This patch series remove comments refering to:
>
>WMD (Windows Mini Driver)
>WCD (Windows Class Driver)
>Mini-driver
>Class-driver
>
>As they refer to the Windows Driver Model. Instead of using these,
>they are replaced as follows:
>WMD => Bridge driver (Contain only hardware specific functionallity)
>WCD => DSP API (Since WCD provides an interface between the different
>layers of the Windows Driver Model and Applications)
>
>This patch series is a compliment of the patch series to remove code
>refering to other OS.
>
>Ivan Gomez Castellanos (4):
>  DSPBRIDGE: Remove comments refering to WMD.
>  DSPBRIDGE: Remove comments refering to WCD.
>  DSPBRIDGE: Remove comments refering to "mini driver"
>  DSPBRIDGE: Remove comments refering to "class driver"
>
> arch/arm/plat-omap/include/dspbridge/_chnl_sm.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/brddefs.h     |    2 +-
> arch/arm/plat-omap/include/dspbridge/cfg.h         |    6 +-
> arch/arm/plat-omap/include/dspbridge/cfgdefs.h     |    2 +-
> arch/arm/plat-omap/include/dspbridge/chnl.h        |    4 +-
> arch/arm/plat-omap/include/dspbridge/chnlpriv.h    |    3 +-
> arch/arm/plat-omap/include/dspbridge/dehdefs.h     |    2 +-
> arch/arm/plat-omap/include/dspbridge/dev.h         |   65 ++++++------
> arch/arm/plat-omap/include/dspbridge/devdefs.h     |    4 +-
> arch/arm/plat-omap/include/dspbridge/drvdefs.h     |    2 +-
> .../arm/plat-omap/include/dspbridge/dspapi-ioctl.h |    2 +-
> arch/arm/plat-omap/include/dspbridge/dspchnl.h     |    4 +-
> arch/arm/plat-omap/include/dspbridge/dspdefs.h     |  115 ++++++++++----------
> arch/arm/plat-omap/include/dspbridge/dspdeh.h      |    2 +-
> arch/arm/plat-omap/include/dspbridge/dspdrv.h      |    2 +-
> arch/arm/plat-omap/include/dspbridge/dspio.h       |    4 +-
> arch/arm/plat-omap/include/dspbridge/dspioctl.h    |    4 +-
> arch/arm/plat-omap/include/dspbridge/dspmsg.h      |    4 +-
> arch/arm/plat-omap/include/dspbridge/io_sm.h       |    6 +-
> arch/arm/plat-omap/include/dspbridge/ldr.h         |    2 +-
> arch/arm/plat-omap/include/dspbridge/memdefs.h     |    2 +-
> arch/arm/plat-omap/include/dspbridge/mgr.h         |    2 +-
> arch/arm/plat-omap/include/dspbridge/mgrpriv.h     |    2 +-
> arch/arm/plat-omap/include/dspbridge/node.h        |    2 +-
> arch/arm/plat-omap/include/dspbridge/proc.h        |    4 +-
> arch/arm/plat-omap/include/dspbridge/procpriv.h    |    2 +-
> arch/arm/plat-omap/include/dspbridge/utildefs.h    |    2 +-
> drivers/dsp/bridge/core/_msg_sm.h                  |    4 +-
> drivers/dsp/bridge/core/_tiomap.h                  |   10 +-
> drivers/dsp/bridge/core/chnl_sm.c                  |    8 +-
> drivers/dsp/bridge/core/io_sm.c                    |   20 ++--
> drivers/dsp/bridge/core/msg_sm.c                   |    2 +-
> drivers/dsp/bridge/core/tiomap3430.c               |   12 +-
> drivers/dsp/bridge/core/tiomap3430_pwr.c           |    6 +-
> drivers/dsp/bridge/core/ue_deh.c                   |    2 +-
> drivers/dsp/bridge/pmgr/chnl.c                     |   10 +-
> drivers/dsp/bridge/pmgr/chnlobj.h                  |   16 ++--
> drivers/dsp/bridge/pmgr/dev.c                      |   48 +++++----
> drivers/dsp/bridge/pmgr/dspapi.c                   |    2 +-
> drivers/dsp/bridge/pmgr/io.c                       |    4 +-
> drivers/dsp/bridge/pmgr/ioobj.h                    |   10 +-
> drivers/dsp/bridge/pmgr/msg.c                      |    8 +-
> drivers/dsp/bridge/pmgr/msgobj.h                   |   11 +-
> drivers/dsp/bridge/rmgr/disp.c                     |    5 +-
> drivers/dsp/bridge/rmgr/node.c                     |    9 +-
> drivers/dsp/bridge/rmgr/proc.c                     |   11 +-
> drivers/dsp/bridge/rmgr/strm.c                     |    7 +-
> drivers/dsp/bridge/services/cfg.c                  |    2 +-
> 48 files changed, 235 insertions(+), 225 deletions(-)
>

Pushed to dspbridge.

- Omar

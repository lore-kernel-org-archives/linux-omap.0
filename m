From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCH 0/4] dspbridge: miscellaneous fixes and cleanups
Date: Wed, 16 Jun 2010 18:19:18 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E8E436F@dlee03.ent.ti.com>
References: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55896 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab0FPXTV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 19:19:21 -0400
In-Reply-To: <1274024702-20961-1-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

>From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
>
>Hi,
>
>A few trivial patches. The important one is the fix to build when MCBSP is
>disabled.
>
>Felipe Contreras (4):
>  dspbridge: fix build when OMAP_MCBSP=n
>  dspbridge: dev: fix dev_create_device()
>  dspbridge: remove _tiomap_mmu.h
>  dspbridge: remove _tiomap_util.h
>
> drivers/dsp/bridge/core/_tiomap_mmu.h    |   41 --------------
> drivers/dsp/bridge/core/_tiomap_util.h   |   43 --------------
> drivers/dsp/bridge/core/dsp-clock.c      |    6 ++
> drivers/dsp/bridge/core/mmu_fault.c      |    1 -
> drivers/dsp/bridge/core/tiomap3430.c     |   89 ++++++++++--------------------
> drivers/dsp/bridge/core/tiomap3430_pwr.c |    3 +-
> drivers/dsp/bridge/core/ue_deh.c         |    1 -
> drivers/dsp/bridge/pmgr/dev.c            |   22 ++++---
> 8 files changed, 49 insertions(+), 157 deletions(-)
> delete mode 100644 drivers/dsp/bridge/core/_tiomap_mmu.h
> delete mode 100644 drivers/dsp/bridge/core/_tiomap_util.h

Pushed to dspbridge.

- omar

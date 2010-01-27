From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: Remove enum definitions and replace with
 macros
Date: Tue, 26 Jan 2010 19:31:47 -0600
Message-ID: <4B5F9783.8070908@ti.com>
References: <1264221870-11178-1-git-send-email-omar.ramirez@ti.com> <1264221870-11178-2-git-send-email-omar.ramirez@ti.com> <1264221870-11178-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50447 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab0A0Bbw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 20:31:52 -0500
In-Reply-To: <1264221870-11178-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Hebbar, Shivananda" <x0hebbar@ti.com>

On 1/22/2010 10:44 PM, Omar Ramirez Luna wrote:
> From: Shivananda Hebbar<x0hebbar@ti.com>
>
> This patch removes unrelated enum constants and replaces it with
> the macros
>
> Signed-off-by: Shivananda Hebbar<x0hebbar@ti.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |   11 +++++------
>   arch/arm/plat-omap/include/dspbridge/cmm.h      |    2 +-
>   arch/arm/plat-omap/include/dspbridge/cmmdefs.h  |   10 ++--------
>   arch/arm/plat-omap/include/dspbridge/dbdefs.h   |   10 +++-------
>   arch/arm/plat-omap/include/dspbridge/io_sm.h    |    5 ++---
>   drivers/dsp/bridge/hw/hw_defs.h                 |    8 +++-----
>   drivers/dsp/bridge/hw/hw_mmu.c                  |    3 +--
>   drivers/dsp/bridge/hw/hw_mmu.h                  |    3 +--
>   drivers/dsp/bridge/hw/hw_prcm.c                 |    6 ++----
>   drivers/dsp/bridge/pmgr/cmm.c                   |    5 ++---
>   drivers/dsp/bridge/wmd/_tiomap.h                |    8 ++------
>   drivers/dsp/bridge/wmd/io_sm.c                  |    3 +--
>   12 files changed, 25 insertions(+), 49 deletions(-)
>

Pushed to dspbridge.

- omar

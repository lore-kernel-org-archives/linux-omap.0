From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: Resource clean up always enabled.
Date: Tue, 2 Feb 2010 14:22:40 -0600
Message-ID: <4B688990.5000304@ti.com>
References: <1265141887-8329-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38074 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab0BBUWp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 15:22:45 -0500
In-Reply-To: <1265141887-8329-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

On 2/2/2010 2:18 PM, Omar Ramirez Luna wrote:
> From: Ernesto Ramos<ernesto@ti.com>
>
> Remove flag RES_CLEANUP_DISABLE to have dspbridge
> resource cleanup allways enabled.
>
> Signed-off-by: Ernesto Ramos<ernesto@ti.com>
> Acked-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/_dcd.h        |    3 --
>   arch/arm/plat-omap/include/dspbridge/drv.h         |    3 +-
>   .../plat-omap/include/dspbridge/resourcecleanup.h  |    2 -
>   arch/arm/plat-omap/include/dspbridge/wcdioctl.h    |    5 +---
>   drivers/dsp/bridge/pmgr/wcd.c                      |    8 ------
>   drivers/dsp/bridge/rmgr/drv.c                      |    4 ---
>   drivers/dsp/bridge/rmgr/drv_interface.c            |    4 ---
>   drivers/dsp/bridge/rmgr/node.c                     |   14 +---------
>   drivers/dsp/bridge/rmgr/proc.c                     |   12 +-------
>   drivers/dsp/bridge/rmgr/strm.c                     |   27 ++++++--------------
>   drivers/dsp/bridge/wmd/chnl_sm.c                   |    2 -
>   11 files changed, 14 insertions(+), 70 deletions(-)
>

sorry for the noise :/

Pushed to dspbridge.

- omar

From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/3] DSPBRIDGE: Change dspbridge for open source mailbox
 implementation
Date: Tue, 23 Mar 2010 12:31:50 -0500
Message-ID: <4BA8FB06.2000709@ti.com>
References: <496565EC904933469F292DDA3F1663E602AA7C18E1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42901 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180Ab0CWRby (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 13:31:54 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602AA7C18E1@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>

On 2/12/2010 8:03 PM, Guzman Lugo, Fernando wrote:
>  From 627fb103cb73202128b8c5d2a51c879c52ebf076 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Fri, 12 Feb 2010 02:26:58 -0600
> Subject: [PATCH] DSPBRIDGE: Change dspbridge for open source mailbox implementation
>
> This patch removes our dspbridge for opensource mailbox
> implementation.
>
> Signed-off-by: Fernando Guzman Lugo<x0095840@ti.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/cfgdefs.h |    1 -
>   arch/arm/plat-omap/include/dspbridge/clk.h     |    3 +-
>   arch/arm/plat-omap/include/dspbridge/drv.h     |    3 -
>   arch/arm/plat-omap/include/dspbridge/host_os.h |    2 +-
>   arch/arm/plat-omap/include/dspbridge/io_sm.h   |    7 +-
>   drivers/dsp/bridge/Makefile                    |    2 +-
>   drivers/dsp/bridge/rmgr/drv.c                  |    9 -
>   drivers/dsp/bridge/services/clk.c              |    1 -
>   drivers/dsp/bridge/wmd/_tiomap.h               |    4 +-
>   drivers/dsp/bridge/wmd/chnl_sm.c               |   26 +++-
>   drivers/dsp/bridge/wmd/io_sm.c                 |  196 ++++++++---------------
>   drivers/dsp/bridge/wmd/tiomap3430.c            |   49 ++++---
>   drivers/dsp/bridge/wmd/tiomap3430_pwr.c        |   13 +-
>   drivers/dsp/bridge/wmd/tiomap_sm.c             |  109 +------------
>   drivers/dsp/bridge/wmd/ue_deh.c                |    4 +-
>   15 files changed, 143 insertions(+), 286 deletions(-)
>

Rebased and pushed to dspbridge.

- omar

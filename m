From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 0/4] DSPBRIDGE: Simplify and optimize sync module
Date: Mon, 5 Apr 2010 21:49:09 -0500
Message-ID: <4BBAA125.6030605@ti.com>
References: <496565EC904933469F292DDA3F1663E602CACBE04C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35531 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757169Ab0DFCtL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Apr 2010 22:49:11 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602CACBE04C@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

On 3/23/2010 8:56 PM, Guzman Lugo, Fernando wrote:
>  From 16f7a1a33d7f76ea3e2962421fea8d5b5f15e4e1 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo<x0095840@ti.com>
> Date: Tue, 23 Mar 2010 20:04:33 -0600
> Subject: [PATCH] DSPBRIDGE: Simplify and optimize sync module
>
> This set of patches simplifies and optimizes the sync module.
>
> Fernando Guzman Lugo (4):
>    DSPBRIDGE: replace sync_enter/leave_cs with mutexts or spinlocks
>    DSPBRIDGE: replace sync_enter/leave_cs for tasklets with spin_lock_bh
>    DSPBRIDGE: modify sync event functions to use completions instead of
>      sems
>    DSPBRIDGE: cleanup to sync module
>
>   arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    4 +-
>   arch/arm/plat-omap/include/dspbridge/chnlpriv.h |    4 -
>   arch/arm/plat-omap/include/dspbridge/sync.h     |  327 ++++-------------
>   drivers/dsp/bridge/pmgr/cmm.c                   |   30 +-
>   drivers/dsp/bridge/pmgr/dmm.c                   |   47 +--
>   drivers/dsp/bridge/rmgr/node.c                  |  281 ++++++--------
>   drivers/dsp/bridge/rmgr/proc.c                  |   16 +-
>   drivers/dsp/bridge/rmgr/strm.c                  |   14 +-
>   drivers/dsp/bridge/services/ntfy.c              |   50 ++--
>   drivers/dsp/bridge/services/services.c          |    9 +-
>   drivers/dsp/bridge/services/sync.c              |  465 +++--------------------
>   drivers/dsp/bridge/wmd/_msg_sm.h                |    2 +-
>   drivers/dsp/bridge/wmd/chnl_sm.c                |   42 +-
>   drivers/dsp/bridge/wmd/io_sm.c                  |    4 -
>   drivers/dsp/bridge/wmd/msg_sm.c                 |   88 +++--
>   drivers/dsp/bridge/wmd/tiomap3430.c             |   22 +-
>   16 files changed, 398 insertions(+), 1007 deletions(-)
> --

Pushed to dspbridge.

- omar

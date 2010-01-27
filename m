From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/4] dspbridge: Change LST_ELEM to list_head entirely
Date: Tue, 26 Jan 2010 19:29:19 -0600
Message-ID: <4B5F96EF.7090203@ti.com>
References: <1264216995-7863-1-git-send-email-omar.ramirez@ti.com> <1264216995-7863-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50313 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866Ab0A0B3W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 20:29:22 -0500
In-Reply-To: <1264216995-7863-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On 1/22/2010 9:23 PM, Ramirez Luna, Omar wrote:
> From: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
>
> * Change struct LST_ELEM to struct list_head in whole dsp bridge driver
> * Remove useless commentaries
> * Minor change in the services/mem.c:
>    ...
>      struct list_head *last =&mMan.lst.head;
>      struct list_head *curr = last->next; /* was: mMan.lst.head.next */
>    ...
>
> Signed-off-by: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>

> ---
>   arch/arm/plat-omap/include/dspbridge/_chnl_sm.h |    2 +-
>   arch/arm/plat-omap/include/dspbridge/list.h     |    1 -
>   drivers/dsp/bridge/pmgr/cmm.c                   |   51 +++++++++++------------
>   drivers/dsp/bridge/pmgr/dev.c                   |    8 ++--
>   drivers/dsp/bridge/rmgr/drv.c                   |   14 +++---
>   drivers/dsp/bridge/rmgr/node.c                  |   10 ++--
>   drivers/dsp/bridge/rmgr/proc.c                  |    2 +-
>   drivers/dsp/bridge/rmgr/rmm.c                   |   16 ++++----
>   drivers/dsp/bridge/services/cfg.c               |    2 +-
>   drivers/dsp/bridge/services/mem.c               |   26 ++++++------
>   drivers/dsp/bridge/services/ntfy.c              |   12 +++---
>   drivers/dsp/bridge/wmd/_msg_sm.h                |    4 +-
>   drivers/dsp/bridge/wmd/chnl_sm.c                |   10 ++--
>   drivers/dsp/bridge/wmd/io_sm.c                  |   10 ++--
>   drivers/dsp/bridge/wmd/msg_sm.c                 |   20 ++++----
>   15 files changed, 93 insertions(+), 95 deletions(-)
>

Pushed to dspbridge.

- omar


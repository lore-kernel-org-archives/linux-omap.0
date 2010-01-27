From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 3/4] dspbridge: Don't use LST_Create() and LST_Delete()
Date: Tue, 26 Jan 2010 19:29:21 -0600
Message-ID: <4B5F96F1.2030605@ti.com>
References: <1264216995-7863-1-git-send-email-omar.ramirez@ti.com> <1264216995-7863-2-git-send-email-omar.ramirez@ti.com> <1264216995-7863-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47136 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524Ab0A0B30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 20:29:26 -0500
In-Reply-To: <1264216995-7863-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On 1/22/2010 9:23 PM, Ramirez Luna, Omar wrote:
> From: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
>
> Change LST_Create() to the MEM_Calloc() and INIT_LIST_HEAD() pair in optimal way.
>
> Use MEM_Free() instead of LST_Delete(). We can use it without checking because
> MEM_Free() validates input parameter.
>
> Signed-off-by: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>

> ---
>   arch/arm/plat-omap/include/dspbridge/list.h |   63 ---------------------------
>   drivers/dsp/bridge/pmgr/cmm.c               |   27 +++++++----
>   drivers/dsp/bridge/pmgr/dev.c               |    9 +++-
>   drivers/dsp/bridge/rmgr/drv.c               |   18 +++++---
>   drivers/dsp/bridge/rmgr/node.c              |    6 ++-
>   drivers/dsp/bridge/rmgr/rmm.c               |    7 ++-
>   drivers/dsp/bridge/services/ntfy.c          |    6 ++-
>   drivers/dsp/bridge/wmd/chnl_sm.c            |    5 +-
>   drivers/dsp/bridge/wmd/msg_sm.c             |   29 ++++++++----
>   9 files changed, 71 insertions(+), 99 deletions(-)
>

Pushed to dspbridge.

- omar

From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/4] DSPBRIDGE: Get rid of services/list.c
Date: Tue, 26 Jan 2010 19:29:15 -0600
Message-ID: <4B5F96EB.5050202@ti.com>
References: <1264216995-7863-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33895 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892Ab0A0B3W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 20:29:22 -0500
In-Reply-To: <1264216995-7863-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On 1/22/2010 9:23 PM, Ramirez Luna, Omar wrote:
> From: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
>
> * Remove LST_Init() and LST_Exit() calls because they are doing nothing except
>    tracing, Thus, remove tracing as well.
>
> * Remove DBC_* calls. It's internal kernel business whether to have those
>    assertions.
>
> * Move methods from list.c as inline functions to the list.h.
>
> * Switch to list_head structure instead of LST_ELEM:
>    - define LST_ELEM as list_head via macro
>    - substitute LST_ELEM by list_head
>    - remove redudant code that uses head->self pointer
>
> * Remove extra local variables.
>
> * Use native list methods where it's possible inside the list.h.
>
> Signed-off-by: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>

> ---
>   arch/arm/plat-omap/include/dspbridge/list.h |  128 ++++++++------
>   drivers/dsp/bridge/Makefile                 |    2 +-
>   drivers/dsp/bridge/services/list.c          |  246 ---------------------------
>   drivers/dsp/bridge/services/mem.c           |    2 -
>   drivers/dsp/bridge/services/services.c      |    9 +-
>   5 files changed, 78 insertions(+), 309 deletions(-)
>   delete mode 100644 drivers/dsp/bridge/services/list.c
>

Pushed to dspbridge.

- omar


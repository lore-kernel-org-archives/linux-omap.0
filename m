From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 4/4] DSPBRIDGE: OSAL: Remove extra include directive
Date: Tue, 26 Jan 2010 19:29:26 -0600
Message-ID: <4B5F96F6.7050501@ti.com>
References: <1264216995-7863-1-git-send-email-omar.ramirez@ti.com> <1264216995-7863-2-git-send-email-omar.ramirez@ti.com> <1264216995-7863-3-git-send-email-omar.ramirez@ti.com> <1264216995-7863-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50325 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752593Ab0A0B3b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 20:29:31 -0500
In-Reply-To: <1264216995-7863-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On 1/22/2010 9:23 PM, Ramirez Luna, Omar wrote:
> From: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>
>
> Including the list.h in some files looks redundant. So, remove those lines.
>
> Signed-off-by: Andy Shevchenko<ext-andriy.shevchenko@nokia.com>

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>

> ---
>   drivers/dsp/bridge/pmgr/chnl.c         |    1 -
>   drivers/dsp/bridge/pmgr/dmm.c          |    1 -
>   drivers/dsp/bridge/pmgr/msg.c          |    1 -
>   drivers/dsp/bridge/services/cfg.c      |    1 -
>   drivers/dsp/bridge/services/services.c |    1 -
>   5 files changed, 0 insertions(+), 5 deletions(-)
>

Pushed to dspbridge.

- omar

From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 2/2] DSPBRIDGE: Remove DRV_ProcUpdatestate function
Date: Tue, 2 Feb 2010 14:19:37 -0600
Message-ID: <4B6888D9.9050409@ti.com>
References: <1265139116-5923-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52778 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588Ab0BBUTm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 15:19:42 -0500
In-Reply-To: <1265139116-5923-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>

On 2/2/2010 1:31 PM, Omar Ramirez Luna wrote:
> From: Gomez Castellanos, Ivan<ivan.gomez@ti.com>
>
> The DRV_ProcUpdatestate function was only used in two places and
> it only assigned a value.
>
> Signed-off-by: Ivan Gomez<ivan.gomez@ti.com>
> Acked-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   .../plat-omap/include/dspbridge/resourcecleanup.h  |    3 ---
>   drivers/dsp/bridge/rmgr/drv.c                      |    9 ---------
>   drivers/dsp/bridge/rmgr/drv_interface.c            |    4 ++--
>   3 files changed, 2 insertions(+), 14 deletions(-)
>

Pushed to dspbridge.

- omar

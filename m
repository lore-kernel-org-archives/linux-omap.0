From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 4/4] DSPBRIDGE: Improved mapped memory cleanup
Date: Tue, 23 Feb 2010 10:23:56 -0600
Message-ID: <4B84011C.9090603@ti.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>  <d4615a96b803472a13d249bcf7faf3ce5d315346.1266503387.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47243 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753346Ab0BWQX7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 11:23:59 -0500
In-Reply-To: <d4615a96b803472a13d249bcf7faf3ce5d315346.1266503387.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On 2/18/2010 8:40 AM, Ameya Palande wrote:
> This patch improves current mapped memory cleanup mechanism by using linux
> native list implementation. As a side effect we also get following benefits:
>
> 1. Unnecessary data members in DMM_MAP_OBJECT are removed which results in
>     memory saving.
>
> 2. Following functions are removed as they are not needed anymore:
>     DRV_ProcFreeDMMRes()
>     DRV_UpdateDMMResElement()
>     DRV_InsertDMMResElement()
>     DRV_GetDMMResElement()
>     DRV_RemoveDMMResElement()
>
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/drv.h         |   30 +---
>   .../plat-omap/include/dspbridge/resourcecleanup.h  |   11 --
>   drivers/dsp/bridge/rmgr/drv.c                      |  161 ++------------------
>   drivers/dsp/bridge/rmgr/drv_interface.c            |    3 +-
>   drivers/dsp/bridge/rmgr/proc.c                     |   43 ++++--
>   5 files changed, 54 insertions(+), 194 deletions(-)
>

Pushed to dspbridge

- omar


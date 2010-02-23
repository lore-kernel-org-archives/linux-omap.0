From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/4] DSPBRIDGE: Rename DMM_RES_OBJECT to DMM_MAP_OBJECT
Date: Tue, 23 Feb 2010 10:23:47 -0600
Message-ID: <4B840113.6050806@ti.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>  <a04c367d97579eefc30bc1d2c4dd98a53bc468ac.1266503387.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57631 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752707Ab0BWQXv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 11:23:51 -0500
In-Reply-To: <a04c367d97579eefc30bc1d2c4dd98a53bc468ac.1266503387.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On 2/18/2010 8:40 AM, Ameya Palande wrote:
> In its current state DMM_RES_OBJECT is not correctly tracking reserve and
> unreserve but only map and unmap. So lets rename it to DMM_MAP_OBJECT to
> clarify what it is really doing!
>
> In addition to this, this patch also does some trivial code cleanup.
>
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> Reviewed-by: Felipe Contreras<felipe.contreras@nokia.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/drv.h |   14 +++---
>   drivers/dsp/bridge/rmgr/drv.c              |   69 ++++++++++++++--------------
>   drivers/dsp/bridge/rmgr/drv_interface.c    |    2 +-
>   3 files changed, 43 insertions(+), 42 deletions(-)
>

Pushed to dspbridge

- omar

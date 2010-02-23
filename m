From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/4] DSPBRIDGE: New reserved memory accounting framework
Date: Tue, 23 Feb 2010 10:23:51 -0600
Message-ID: <4B840117.5060902@ti.com>
References: <cover.1266503387.git.ameya.palande@nokia.com>  <0fd274366a6ad4fda3d20103f52a314bb6ebef57.1266503387.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56060 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297Ab0BWQXz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Feb 2010 11:23:55 -0500
In-Reply-To: <0fd274366a6ad4fda3d20103f52a314bb6ebef57.1266503387.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

On 2/18/2010 8:40 AM, Ameya Palande wrote:
> DSP_RSV_OBJECT is introduced to track reserved memory accounting information.
> This will allow us to do proper cleanup for memory reserved using
> PROC_ReserveMemory().
>
> Signed-off-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   arch/arm/plat-omap/include/dspbridge/drv.h  |   10 ++++
>   arch/arm/plat-omap/include/dspbridge/proc.h |    4 +-
>   drivers/dsp/bridge/pmgr/wcd.c               |    7 ++-
>   drivers/dsp/bridge/rmgr/drv.c               |   18 +++++---
>   drivers/dsp/bridge/rmgr/drv_interface.c     |    2 +
>   drivers/dsp/bridge/rmgr/node.c              |    5 +-
>   drivers/dsp/bridge/rmgr/proc.c              |   62 ++++++++++++++++++++++-----
>   7 files changed, 83 insertions(+), 25 deletions(-)
>

Pushed to dspbridge

- omar


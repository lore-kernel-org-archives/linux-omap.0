From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: Fix header locations mach to plat
Date: Tue, 23 Mar 2010 12:28:50 -0500
Message-ID: <4BA8FA52.8060903@ti.com>
References: <1268949429-30368-1-git-send-email-omar.ramirez@ti.com> <1268949429-30368-2-git-send-email-omar.ramirez@ti.com> <1268949429-30368-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42704 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438Ab0CWR2z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Mar 2010 13:28:55 -0400
In-Reply-To: <1268949429-30368-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On 3/18/2010 4:57 PM, Ramirez Luna, Omar wrote:
> Fix header locations, replaced mach to plat
>
> Signed-off-by: Omar Ramirez Luna<omar.ramirez@ti.com>
> Acked-by: Ameya Palande<ameya.palande@nokia.com>
> ---
>   arch/arm/mach-omap2/dspbridge.c                |    2 +-
>   arch/arm/plat-omap/include/dspbridge/host_os.h |    2 +-
>   drivers/dsp/bridge/wmd/tiomap3430.c            |    2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>

Pushed to dspbridge.

- omar

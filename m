From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: Re: [PATCH 3/3] DSPBRIDGE: auto select mailbox when compiling bridge
Date: Wed, 24 Mar 2010 14:12:44 -0500
Message-ID: <4BAA642C.8070500@ti.com>
References: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com> <1269384510-1526-2-git-send-email-omar.ramirez@ti.com> <1269384510-1526-3-git-send-email-omar.ramirez@ti.com> <1269384510-1526-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46457 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932788Ab0CXTMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 15:12:48 -0400
In-Reply-To: <1269384510-1526-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

Omar Ramirez Luna wrote:
> Auto select mailbox when compiling bridgedriver.
>
> If selected as module, first install:
> arch/arm/plat-omap/mailbox.ko
> arch/arm/mach-omap2/mailbox_mach.ko
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com
> ---
>  drivers/dsp/bridge/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
> index c721f40..a3251c3 100644
> --- a/drivers/dsp/bridge/Kconfig
> +++ b/drivers/dsp/bridge/Kconfig
> @@ -5,6 +5,7 @@
>  menuconfig MPU_BRIDGE
>  	tristate "DSP Bridge driver"
>  	default n
> +	select OMAP_MBOX_FWK
>  	help
>  	  DSP/BIOS Bridge is designed for platforms that contain a GPP and
>  	  one or more attached DSPs.  The GPP is considered the master or
>   
Acked-by: Deepak Chitriki <deepak.chitriki@ti.com>

Deepak

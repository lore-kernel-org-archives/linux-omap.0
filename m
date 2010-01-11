From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] DSPBRIDGE: driver version 0.1
Date: Mon, 11 Jan 2010 12:30:45 -0600
Message-ID: <4B4B6E55.9000406@ti.com>
References: <1263232222-30599-1-git-send-email-omar.ramirez@ti.com> <1263232222-30599-2-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49764 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab0AKSay (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jan 2010 13:30:54 -0500
In-Reply-To: <1263232222-30599-2-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>

Ramirez Luna, Omar had written, on 01/11/2010 11:50 AM, the following:
> This is the official 0.1 dspbridge version.
> 
> CC: Felipe Contreras <felipe.contreras@nokia.com>
> CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
> CC: Ameya Palande <ameya.palande@nokia.com>
> CC: Nishant Menon <nm@ti.com>
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index c853854..efce35d 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -101,6 +101,7 @@
>  #define BRIDGE_NAME "C6410"
>  /*  ----------------------------------- Globals */
>  #define DRIVER_NAME  "DspBridge"
> +#define DSPBRIDGE_VERSION	"0.1"
>  s32 dsp_debug;
>  
>  struct platform_device *omap_dspbridge_dev;
> @@ -177,6 +178,7 @@ MODULE_PARM_DESC(tc_wordswapon, "TC Word Swap Option. default = 0");
>  
>  MODULE_AUTHOR("Texas Instruments");
>  MODULE_LICENSE("GPL");
> +MODULE_VERSION(DSPBRIDGE_VERSION);
>  
>  static char *driver_name = DRIVER_NAME;
>  
is the IOCTL patch before or after the 0.1?

-- 
Regards,
Nishanth Menon

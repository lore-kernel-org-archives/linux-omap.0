From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH] OMAP 2/3 V4L2 display driver on video planes
Date: Wed, 17 Sep 2008 18:30:05 +0300
Message-ID: <48D1227D.5070207@nokia.com>
References: <hardik.shah@ti.com> <1221663942-7160-1-git-send-email-hardik.shah@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27179 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYIQPax (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 11:30:53 -0400
In-Reply-To: <1221663942-7160-1-git-send-email-hardik.shah@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hardik Shah <hardik.shah@ti.com>
Cc: linux-omap@vger.kernel.org, video4linux-list@redhat.com, linux-fbdev-devel@lists.sourceforge.net

Hi, Hardik!

ext Hardik Shah wrote:
> diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
> index 2703c66..e899dd2 100644
> --- a/drivers/media/video/Kconfig
> +++ b/drivers/media/video/Kconfig
> @@ -762,8 +762,6 @@ source "drivers/media/video/au0828/Kconfig"
> 
>  source "drivers/media/video/ivtv/Kconfig"
> 
> -source drivers/media/video/omap/Kconfig
> -
>  source "drivers/media/video/cx18/Kconfig"
> 
>  config VIDEO_M32R_AR
> @@ -802,6 +800,14 @@ config VIDEO_OMAP2
>  	---help---
>  	  Driver for an OMAP 2 camera controller.
> 
> +config VIDEO_OMAP3

This is the same configuration option as we are using for the OMAP 3 
camera driver at the moment.

Could you, for example, call this VIDEO_OMAP3_VIDEOOUT?

CONFIG_VIDEO_OMAP2 enables the OMAP 2 camera driver.

> diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
> index 3e580e8..10f879c 100644
> --- a/drivers/media/video/Makefile
> +++ b/drivers/media/video/Makefile
> @@ -107,6 +107,8 @@ obj-$(CONFIG_VIDEO_CAFE_CCIC) += cafe_ccic.o
>  obj-$(CONFIG_VIDEO_OV7670) 	+= ov7670.o
> 
>  obj-$(CONFIG_VIDEO_OMAP2) += omap24xxcam.o omap24xxcam-dma.o
> +obj-$(CONFIG_VIDEO_OMAP3) += omap/

It's just two C source code files --- how about putting them into the 
parent directory? The omap directory has just one driver in it, the OMAP 
1 camera driver. I think at some point it was intended to be moved to 
the parent directory although this hasn't happened.

Best regards,

-- 
Sakari Ailus
sakari.ailus@nokia.com

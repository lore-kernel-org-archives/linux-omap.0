From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH 4/15] OMAP3 camera driver: V4L2: Add VIDIOC_G_PRIV_MEM
Date: Mon, 01 Sep 2008 10:28:25 +0300
Message-ID: <48BB9999.4090504@nokia.com>
References: <A24693684029E5489D1D202277BE89441191E325@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:47523 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYIAH2j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Sep 2008 03:28:39 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89441191E325@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Aguirre Rodriguez, Sergio Alberto wrote:
> From: Sakari Ailus <sakari.ailus@nokia.com>
> Subject: [PATCH] V4L: Add VIDIOC_G_PRIV_MEM
> 
> Some devices, for example image sensors, contain settings in their
> EEPROM memory that are useful to userspace programs. VIDIOC_G_PRIV_MEM
> can be used to read those settings.
> 
> This patch adds also the corresponding v4l2_int_device command.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>

...

> @@ -1423,8 +1430,9 @@
>  #define	VIDIOC_DBG_G_REGISTER 	_IOWR('V', 80, struct v4l2_register)
>  
>  #define VIDIOC_G_CHIP_IDENT     _IOWR('V', 81, struct v4l2_chip_ident)
> +#define VIDIOC_G_PRIV_MEM       _IOWR('V', 82, struct v4l2_priv_mem)
>  #endif
> -#define VIDIOC_S_HW_FREQ_SEEK	 _IOW('V', 82, struct v4l2_hw_freq_seek)
> +#define VIDIOC_S_HW_FREQ_SEEK	 _IOW('V', 83, struct v4l2_hw_freq_seek)

Ouch. You can't do that! :)

(I don't think this was part of my original patch.)

-- 
Sakari Ailus
sakari.ailus@nokia.com

From: Zou Tao <zoutao51@gmail.com>
Subject: Re: [PATCH 1/15] OMAP3 camera driver: V4L2: Adding IOCTL command
 to get slave private data.
Date: Tue, 02 Sep 2008 22:55:37 +0800
Message-ID: <48BD53E9.6060307@gmail.com>
References: <A24693684029E5489D1D202277BE89441191E320@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:11273 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbYIBOzl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 10:55:41 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1841754fkq.5
        for <linux-omap@vger.kernel.org>; Tue, 02 Sep 2008 07:55:38 -0700 (PDT)
In-Reply-To: <A24693684029E5489D1D202277BE89441191E320@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi:
I'm using omap zoom ldp board, and i enable omap34xx cam option in kernel.
My kernel version is v2.6.26-ti-07252008, which including most of the 15 
patches, just having minor different.
During boot, it reported"Clock cam_mclk didn't enable in 100000 tries", 
but init has been finished successfully.
After booting up , I tried to access /dev/video/0, but kernel reported 
no such device.
Adding debug info, I found that video_device[0] is NULL.
and in
omap34xxcam_probe() -> 
v4l2_int_device_register()->v4l2_int_device_try_attach_all()->m->u.master->attach(s)
but omap34xxcam_device_register() never been called. so cam failed to 
register it.

Could you give me some advices? Does it work on your board?


Aguirre Rodriguez, Sergio Alberto wrote:
> >From 0be1009427e55115058bfe72521a2a2811a976e8 Mon Sep 17 00:00:00 2001
> From: Sakari Ailus <sakari.ailus@nokia.com>
> Date: Tue, 15 Apr 2008 10:35:15 +0300
> Subject: [PATCH] Adding IOCTL command to get slave private data.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  include/media/v4l2-int-device.h |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
> index c8b80e0..d9a0053 100644
> --- a/include/media/v4l2-int-device.h
> +++ b/include/media/v4l2-int-device.h
> @@ -184,6 +184,11 @@ enum v4l2_int_ioctl_num {
>  	vidioc_int_dev_exit_num,
>  	/* Set device power state: 0 is off, non-zero is on. */
>  	vidioc_int_s_power_num,
> +	/*
> +	* Get slave private data, e.g. platform-specific slave
> +	* configuration used by the master.
> +	*/
> +	vidioc_int_g_priv_num,
>  	/* Get slave interface parameters. */
>  	vidioc_int_g_ifparm_num,
>  	/* Does the slave need to be reset after VIDIOC_DQBUF? */
> @@ -267,6 +272,7 @@ V4L2_INT_WRAPPER_1(s_parm, struct v4l2_streamparm, *);
>  V4L2_INT_WRAPPER_0(dev_init);
>  V4L2_INT_WRAPPER_0(dev_exit);
>  V4L2_INT_WRAPPER_1(s_power, int, );
> +V4L2_INT_WRAPPER_1(g_priv, void, *);
>  V4L2_INT_WRAPPER_1(g_ifparm, struct v4l2_ifparm, *);
>  V4L2_INT_WRAPPER_1(g_needs_reset, void, *);
>  
>   


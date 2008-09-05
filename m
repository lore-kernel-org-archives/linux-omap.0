From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 1/15] OMAP3 camera driver: V4L2: Adding IOCTL command to
 get slave private data.
Date: Fri, 5 Sep 2008 09:44:49 -0500
Message-ID: <A24693684029E5489D1D202277BE894411B18CD4@dlee02.ent.ti.com>
References: <48C135E5.1030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60152 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbYIEOo4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 10:44:56 -0400
In-Reply-To: <48C135E5.1030506@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Zou Tao <zoutao51@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tao,

This patch is my first priority now, so I'm planning to send it to this list very soon. I need to do more testing before having it ready for review.

I have an OMAP3430 SDP ES3 as my primary platform for testing, in which I have both MT9p012 and OV3640 (which is the same in LDP) in the camkit.

I'm expecting to test it aswell on Zoom (LDP) after that.

Thanks for your interest and time.

Regards,
Sergio
-----Original Message-----
From: Zou Tao [mailto:zoutao51@gmail.com] 
Sent: Friday, September 05, 2008 8:37 AM
To: Aguirre Rodriguez, Sergio Alberto
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/15] OMAP3 camera driver: V4L2: Adding IOCTL command to get slave private data.

Hi, Sergio:
Thanks. And do you have any schedule when the patch will be released? If 
you have , please let me know.
B.R
Tao
Aguirre Rodriguez, Sergio Alberto wrote:
> Hi Zou,
>
> These set of patches are meant to work on OMAP3430 SDP with camkit v3, which contains MT9p012 sensor and DW9710 lens driver.
>
> We currently have omap zoom ldp board implementation as W.I.P., so it's expected that you don't have your camera sensor detected yet. We'll be posting the patches in this list as soon as we have them ready.
>
> This error you're getting for cam_mclk is something which we are working out with the power management team, but it shouldn't be a problem for getting that clock to work.
>
> Regards,
> Sergio
>
> -----Original Message-----
> From: Zou Tao [mailto:zoutao51@gmail.com] 
> Sent: Tuesday, September 02, 2008 9:56 AM
> To: Aguirre Rodriguez, Sergio Alberto
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/15] OMAP3 camera driver: V4L2: Adding IOCTL command to get slave private data.
>
> Hi:
> I'm using omap zoom ldp board, and i enable omap34xx cam option in kernel.
> My kernel version is v2.6.26-ti-07252008, which including most of the 15 
> patches, just having minor different.
> During boot, it reported"Clock cam_mclk didn't enable in 100000 tries", 
> but init has been finished successfully.
> After booting up , I tried to access /dev/video/0, but kernel reported 
> no such device.
> Adding debug info, I found that video_device[0] is NULL.
> and in
> omap34xxcam_probe() -> 
> v4l2_int_device_register()->v4l2_int_device_try_attach_all()->m->u.master->attach(s)
> but omap34xxcam_device_register() never been called. so cam failed to 
> register it.
>
> Could you give me some advices? Does it work on your board?
>
>
> Aguirre Rodriguez, Sergio Alberto wrote:
>   
>> >From 0be1009427e55115058bfe72521a2a2811a976e8 Mon Sep 17 00:00:00 2001
>> From: Sakari Ailus <sakari.ailus@nokia.com>
>> Date: Tue, 15 Apr 2008 10:35:15 +0300
>> Subject: [PATCH] Adding IOCTL command to get slave private data.
>>
>> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
>> ---
>>  include/media/v4l2-int-device.h |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/media/v4l2-int-device.h b/include/media/v4l2-int-device.h
>> index c8b80e0..d9a0053 100644
>> --- a/include/media/v4l2-int-device.h
>> +++ b/include/media/v4l2-int-device.h
>> @@ -184,6 +184,11 @@ enum v4l2_int_ioctl_num {
>>  	vidioc_int_dev_exit_num,
>>  	/* Set device power state: 0 is off, non-zero is on. */
>>  	vidioc_int_s_power_num,
>> +	/*
>> +	* Get slave private data, e.g. platform-specific slave
>> +	* configuration used by the master.
>> +	*/
>> +	vidioc_int_g_priv_num,
>>  	/* Get slave interface parameters. */
>>  	vidioc_int_g_ifparm_num,
>>  	/* Does the slave need to be reset after VIDIOC_DQBUF? */
>> @@ -267,6 +272,7 @@ V4L2_INT_WRAPPER_1(s_parm, struct v4l2_streamparm, *);
>>  V4L2_INT_WRAPPER_0(dev_init);
>>  V4L2_INT_WRAPPER_0(dev_exit);
>>  V4L2_INT_WRAPPER_1(s_power, int, );
>> +V4L2_INT_WRAPPER_1(g_priv, void, *);
>>  V4L2_INT_WRAPPER_1(g_ifparm, struct v4l2_ifparm, *);
>>  V4L2_INT_WRAPPER_1(g_needs_reset, void, *);
>>  
>>   
>>     
>
>
>
>   



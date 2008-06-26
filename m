From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: V4L on OMAP3
Date: Thu, 26 Jun 2008 19:41:12 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940324A61638@dbde02.ent.ti.com>
References: <486354DA.9010506@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085AbYFZOLb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 10:11:31 -0400
In-Reply-To: <486354DA.9010506@iis.fraunhofer.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajit Motra <motraat@iis.fraunhofer.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Could you please tell me what exactly you are trying to do?

I am able to open the device /dev/video0 here at my end. Please verify your configuration file for all the required options. Here are my /dev/video nodes on my system -

[root@OMAP3EVM /]# ls -l /dev/video*
crw-rw----    1 root     root      81,   0 Jan  1 00:00 /dev/video0
crw-rw----    1 root     root      81,   1 Jan  1 00:00 /dev/video1
crw-rw----    1 root     root      81,   2 Jan  1 00:00 /dev/video2

Thanks,
Vaibhav Hiremath
Senior Software Engg.
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927
TI IP Ph: 509-9927
http://dbdwss01.india.ti.com/pspproducts/

-----Original Message-----
From: Ajit Motra [mailto:motraat@iis.fraunhofer.de]
Sent: Thursday, June 26, 2008 2:06 PM
To: Hiremath, Vaibhav
Subject: Re: V4L on OMAP3

Hi,

  I am not able to open device node, fd_v4l = open(v4l_device, O_RDWR)
returns -1. I read documents and suspected that its read only. I tried
with that also it still does not work. (crwxrwxrwx    1 504
504       81,   0 Mar 12  2004 /dev/video0) is available in /dev. I have
less experience with Linux but I have used color conversions using v4l
in past. I was successful with framebuffer part. /dev/fb0 opens just ok
and all ioctls are working fine for framebuffer on the same board.

Regards
Ajit Motra
Hiremath, Vaibhav wrote:

>Can you pleas tell me what kind of error message you are getting? And probably I may want to see your .config file.
>
>Thanks,
>Vaibhav Hiremath
>Senior Software Engg.
>Platform Support Products
>Texas Instruments Inc
>Ph: +91-80-25099927
>TI IP Ph: 509-9927
>http://dbdwss01.india.ti.com/pspproducts/
>
>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ajit Motra
>Sent: Thursday, June 26, 2008 1:39 PM
>To: linux-omap@vger.kernel.org
>Subject: V4L on OMAP3
>
>Hello,
>
> We received OMAP3 board from TI. This has linux from mistral on this. There is a node /dev/video0 on this but when I try to open this using O_RDONLY or O_RDWR option, this does not open device. Is V4L functionality missing in this case?
>We are using Linux version 2.6.22.1. We have registered our EVB on TI website but there are no new updates for OMAP3503.
>
>Thanks
>Motra
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>


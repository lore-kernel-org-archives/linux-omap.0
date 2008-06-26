From: Ajit Motra <motraat@iis.fraunhofer.de>
Subject: Re: V4L on OMAP3
Date: Thu, 26 Jun 2008 11:07:28 +0200
Message-ID: <48635C50.5040607@iis.fraunhofer.de>
References: <19F8576C6E063C45BE387C64729E73940324A614BD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay01-haj2.antispameurope.de ([83.246.65.51]:43872 "EHLO
	relay01-haj2.antispameurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751586AbYFZJHe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jun 2008 05:07:34 -0400
Received: from iis.fhg.de (iis.iis.fhg.de [153.96.172.2])
	by relay01-haj2.antispameurope.de (Postfix) with SMTP id 4A0C1940C3
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 11:07:28 +0200 (CEST)
Received: from sunserv02.iis.fhg.de ([153.96.171.22])
	by iis.fhg.de (8.8.5/) with ESMTP id LAA29706
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 11:07:28 +0200 (MET DST)
Received: from [10.54.95.40] (mp834.iis.fhg.de [10.54.95.40])
	by sunserv02.iis.fhg.de (8.12.10+Sun/8.12.10) with ESMTP id m5Q97SM0011698
	for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2008 11:07:28 +0200 (CEST)
In-Reply-To: <19F8576C6E063C45BE387C64729E73940324A614BD@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I am not able to open device node, fd_v4l = open(v4l_device, O_RDWR) 
returns -1. I read documents and suspected that its read only. I tried 
with that also it still does not work. (crwxrwxrwx    1 504      
504       81,   0 Mar 12  2004 /dev/video0) is available in /dev. I have 
less experience with Linux but I have used color conversions using v4l 
in past. I was successful with framebuffer part. /dev/fb0 opens just ok 
and all ioctls are working fine for framebuffer on the same board.

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


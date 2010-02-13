From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: omap3 camera interface driver
Date: Sat, 13 Feb 2010 16:10:38 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044A96DC30@dbde02.ent.ti.com>
References: <1265917278-22011-1-git-send-email-swirl@gmx.li>
 <19F8576C6E063C45BE387C64729E7394044A96DB56@dbde02.ent.ti.com>
 <54B31811B83D744D90BF0289EB447D4609AE4C6F2F@MAIL-MB1.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36610 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab0BMKkq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Feb 2010 05:40:46 -0500
In-Reply-To: <54B31811B83D744D90BF0289EB447D4609AE4C6F2F@MAIL-MB1.oerlikon.ca>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Weng, Wending" <WWeng@rheinmetall.ca>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Weng, Wending [mailto:WWeng@rheinmetall.ca]
> Sent: Friday, February 12, 2010 9:51 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: omap3 camera interface driver
> 
> Hi Hiremath,
> 
>             I used to work with BSP from TI, there is driver for
> camera interface. Now I switched to 2.6.33.rc3, don't see any omap3
> camera interface driver, could you tell me the status of this
> driver? Thanks.
> 
[Hiremath, Vaibhav] Yes that's right, we do not have OMAP3 Camera support available in main-line kernel yet. 

The Camera support currently available is based on V4L2-Int framework which has become legacy framework. We have to migrate to sub-device framework to get it merged in Main-line, which will eventually happen over period of time. At this point of time I do not have any time lines for this activity, but yes I have this activity listed in my todo.

I believe when you are saying you were working on TI BSP, you are referring to 2.6.22 based kernel releases. 

As of now I can point you to the V4L2-Int based Camera driver support which I am maintaining (forward ported) for our releases

http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=summary


Thanks,
Vaibhav

> Software Engineer
> Wending

From: <shivananda.hebbarp@wipro.com>
Subject: RE: Questions on Android
Date: Mon, 5 May 2008 18:08:07 +0530
Message-ID: <70E3BF80B2DA6E469688AD5C3BBCC6C4036B0817@BLR-EC-MBX02.wipro.com>
References: <20080429101351.GA25657@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wipro-blr-out01.wipro.com ([203.91.198.74]:36124 "EHLO
	wipro-blr-out01.wipro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbYEEMi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 May 2008 08:38:27 -0400
Received: from blr-ec-bh01.wipro.com (unknown [10.201.50.91])
	by wipro-blr-out01.wipro.com (Symantec Mail Security) with ESMTP id 0BB874E4003
	for <linux-omap@vger.kernel.org>; Mon,  5 May 2008 18:08:25 +0530 (IST)
Content-class: urn:content-classes:message
In-Reply-To: <20080429101351.GA25657@bulgaria.corp.google.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: anils@mistralsolutions.com
Cc: dirk.behme@googlemail.com, linux-omap@vger.kernel.org, colorant@163.com, swetland@google.com

 
>[Anil S <anils@mistralsolutions.com>]
> Hello Brian,
> 
> 	It would be really great if you could share thoughts on the
questions 
> given here on Android:
> 
> I was able to add support for the keypad, touch and network in 
> Android, however the interfaces like GPS, Accelerometer, vibrator, 
> hardware 3D acceleration, battery etc. are not integrated with Android

> right now. I would appreciate if you could throw some light on these 
> open issues. How exactly can these interfaces be integrated with
Android?

Hi Anil,

I had reported some Power management behavior after bringing up android
on 2430. Here is the thread .
http://marc.info/?l=linux-omap&m=120948254632401&w=2

Basically the Android GUI comes up and transitions from Active to Sleep
mode happens properly for the first 2 times.(by pressing the up and down
keys).
But the third time ,it never comes from the deep sleep mode. 

Do you any idea about this ?Any inputs on this is highly appreciated.

Regards,
Shivananda

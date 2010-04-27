From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: OMAP3: Linux Without a Boot Loader?
Date: Tue, 27 Apr 2010 05:31:10 -0500
Message-ID: <4BD6BCEE.5040503@gmail.com>
References: <4BD61F7D.3060208@ti.com> <4BD65FC5.7060205@snapgear.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.211.194]:39874 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab0D0KbO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 06:31:14 -0400
Received: by ywh32 with SMTP id 32so7742802ywh.33
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 03:31:13 -0700 (PDT)
In-Reply-To: <4BD65FC5.7060205@snapgear.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Ungerer <gerg@snapgear.com>
Cc: Nishanth Menon <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 04/26/2010 10:53 PM, Greg Ungerer wrote:
[..]
>>
>> Image creation steps:
>> make bzImage, copy the arch/arm/boot/zImage to required location,
>> ./tagger -c configs/sample-3630.cfg -f zImage
>> ./gpsign -c configs/sample-3630.cfg -f zImage.tag
>>
>> I need to probably add some decent documentation around it, but please
>> feel free to poke around - it is pretty simple code..
>
> Nicely done :-)
>
> Have you put up the "Sty" code anywhere for us to look at?
>

Yep, here it is..(all utils and code is in the same github repo)
http://github.com/nmenon/omap-u-boot-utils/tree/wip-taggersty/src/asm/
[..]
Regards,
Nishanth Menon


From: Chris Hudson <chudson@kionix.com>
Subject: Re: [RFC PATCH v3 1/3] input:misc:driver support for Kionix kxte9
 accelerometer
Date: Thu, 12 Nov 2009 09:33:06 -0500
Message-ID: <4AFC1CA2.7070206@kionix.com>
References: <1257971179-28225-1-git-send-email-chudson@kionix.com> <FCCFB4CDC6E5564B9182F639FC35608702FA5CBB36@dbde02.ent.ti.com> <4AFB21D2.2000007@kionix.com> <FCCFB4CDC6E5564B9182F639FC35608702FA5CBB4E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:38483 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752729AbZKLOdH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 09:33:07 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA5CBB4E@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Pandita, Vikram wrote:
>> -----Original Message-----
>> From: Chris Hudson [mailto:chudson@kionix.com]
>>
>> Pandita, Vikram wrote:
>>     
>>> Chris
>>>       
> <snip>
>   
>>> Any way to test these features of accelerometer with your set of 3 patches applied?
>>>
>>> Say with a busybox filesystem or poky?
>>>
>>>       
>> Sure, I've been using busybox with the ZoomII and testing the hardware
>> throughout the development process.  You'll need to attach a KXTE9 to
>>     
>
> I thought the accelerometer was a built-in feature of zoom2?
> Can you give reference of details of KXTE9 module? Is it to be plugged in to come connector on zoom2?
>   
There are two accelerometers built into the OMAP ZoomII: a MEMSIC and a 
Bosch.(1)  From what I've seen, they don't seem to be initialized in any 
stardard kernel configuration for this platform.

To work with the KXTE9, I used a 200-pin connecter(2) mounted to the J43 
expansion header, which is under the camera cover on the ZoomII. 

The KXTE9 product specification is available here: 
http://www.kionix.com/accelerometers/accelerometer-KXTE9.html

(1)https://gforge.ti.com/gf/project/omapzoom/wiki/?pagename=WhatIsZoom2
(2)http://search.digikey.com/scripts/DkSearch/dksus.dll?lang=en&site=US&WT.z_homepage_link=hp_go_button&KeyWords=sam8019-nd&x=0&y=0

>   
>> the i2c-2 bus, vdd, iovdd, ground, and gpio156 on the J43 header if
>> using a ZoomII.  I can give you the exact pins I'm using if you would like.
>> Thank you,
>> Chris
>>     
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   

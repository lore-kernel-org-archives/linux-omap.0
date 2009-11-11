From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [RFC PATCH v3 1/3] input:misc:driver support for Kionix kxte9
 accelerometer
Date: Thu, 12 Nov 2009 04:14:09 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA5CBB4E@dbde02.ent.ti.com>
References: <1257971179-28225-1-git-send-email-chudson@kionix.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA5CBB36@dbde02.ent.ti.com>
 <4AFB21D2.2000007@kionix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56941 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759311AbZKKWoN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 17:44:13 -0500
In-Reply-To: <4AFB21D2.2000007@kionix.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chris Hudson <chudson@kionix.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>


>-----Original Message-----
>From: Chris Hudson [mailto:chudson@kionix.com]
>
>Pandita, Vikram wrote:
>> Chris
<snip>
>>
>> Any way to test these features of accelerometer with your set of 3 patches applied?
>>
>> Say with a busybox filesystem or poky?
>>
>Sure, I've been using busybox with the ZoomII and testing the hardware
>throughout the development process.  You'll need to attach a KXTE9 to

I thought the accelerometer was a built-in feature of zoom2?
Can you give reference of details of KXTE9 module? Is it to be plugged in to come connector on zoom2?

>the i2c-2 bus, vdd, iovdd, ground, and gpio156 on the J43 header if
>using a ZoomII.  I can give you the exact pins I'm using if you would like.
>Thank you,
>Chris

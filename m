From: Chris Hudson <chudson@kionix.com>
Subject: Re: [RFC PATCH v3 1/3] input:misc:driver support for Kionix kxte9
 accelerometer
Date: Wed, 11 Nov 2009 15:42:58 -0500
Message-ID: <4AFB21D2.2000007@kionix.com>
References: <1257971179-28225-1-git-send-email-chudson@kionix.com> <FCCFB4CDC6E5564B9182F639FC35608702FA5CBB36@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA5CBB36@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

Pandita, Vikram wrote:
> Chris
>
>   
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> chudson@kionix.com
>> Sent: Wednesday, November 11, 2009 2:26 PM
>> To: linux-omap@vger.kernel.org
>> Cc: linux-input@vger.kernel.org; dmitry.torokhov@gmail.com; Chris Hudson
>> Subject: [RFC PATCH v3 1/3] input:misc:driver support for Kionix kxte9 accelerometer
>>
>> From: Chris Hudson <chudson@kionix.com>
>>
>> This is a request for comments regarding adding driver support for the Kionix
>> KXTE9 digital tri-axis accelerometer.  This part features built-in tilt
>> position (orientation), wake-up and back-to-sleep algorithms, which can trigger
>> a user-configurable physical interrupt.  The driver uses i2c for device
>> communication, a misc node for IOCTLs, and input nodes for reporting
>> acceleration data and interrupt status information.  Moved to
>> drivers/input/misc after discussion on linux-omap mailing list.
>>     
>
> Any way to test these features of accelerometer with your set of 3 patches applied?
>
> Say with a busybox filesystem or poky?
>   
Sure, I've been using busybox with the ZoomII and testing the hardware 
throughout the development process.  You'll need to attach a KXTE9 to 
the i2c-2 bus, vdd, iovdd, ground, and gpio156 on the J43 header if 
using a ZoomII.  I can give you the exact pins I'm using if you would like.
Thank you,
Chris
>   
>> Changes in this version:
>>     
> <snip>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>   

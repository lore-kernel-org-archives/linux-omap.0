From: Chris Hudson <chudson@kionix.com>
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
 kxte9 accelerometer
Date: Tue, 10 Nov 2009 15:32:50 -0500
Message-ID: <4AF9CDF2.2070003@kionix.com>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>	<20091110193539.7e1392f3@hyperion.delvare> <4AF9B5E3.1060902@kionix.com> <4AF9B847.3070008@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:34008 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758080AbZKJUcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 15:32:50 -0500
In-Reply-To: <4AF9B847.3070008@cam.ac.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org



Jonathan Cameron wrote:
> Chris Hudson wrote:
>   
>> Jean Delvare wrote:
>>     
>>> On Tue, 10 Nov 2009 13:28:47 -0500, chudson@kionix.com wrote:
>>>  
>>>       
>>>> From: Chris Hudson <chudson@kionix.com>
>>>>
>>>> This is a request for comments for adding driver support for the
>>>> Kionix KXTE9 digital tri-axis accelerometer.  This part features
>>>> built-in tilt position (orientation), wake-up and back-to-sleep
>>>> algorithms, which can trigger a user-configurable physical
>>>> interrupt.  The driver uses i2c for device communication, a misc node
>>>> for IOCTLs, and input nodes for reporting acceleration data and
>>>> interrupt status information.
>>>>
>>>> Signed-off-by: Chris Hudson <chudson@kionix.com>
>>>>     
>>>>         
>>> Nack. We want less accelerometer drivers polluting drivers/hwmon, not
>>> more.
>>>
>>>   
>>>       
>> Thank you Jean for your quick reply.  I have seen some accelerometer
>> drivers in drivers/staging/iio/accel; is this where they are all being
>> moved to?
>>
>>     
> Sorry Chris, meant to send my reply to the list as this question keeps
> coming up.
>
> That somewhat depends on the intended application.  The purpose of IIO
> is to provide a more general sensors framework, handling reasonably high
> capture speeds and things like triggering and ring buffers.  As things
> currently stand it isn't the place for devices that are principally being
> used for input or as wake up triggers. I'd be perfectly happy if there
> was a driver in IIO for this chip, (we already have a basic kxsd9 driver)
> but the support for much of what you describe in your summary would be
> pretty much unconnected to that subsystem. Not necessarily a problem
> though handling exactly what was getting the data at a given moment
> might get fiddly.
>  
> Jonathan
> --
>
>   
Thank you for your insight Jonathan.  The driver was originally written 
for the 2.6.29 omap-android kernel to facilitate integration of the 
kxte9 into customer projects.  Unfortunately, it seems that things in 
the kernel have changed since then, but I'm not sure how much we can 
change without sacrificing compatibility with the Android sensor API.  
Is there a different place where this driver could go without requiring 
significant redesign?

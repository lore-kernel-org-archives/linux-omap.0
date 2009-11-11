From: Chris Hudson <chudson@kionix.com>
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
  kxte9 accelerometer
Date: Wed, 11 Nov 2009 09:21:19 -0500
Message-ID: <4AFAC85F.9010406@kionix.com>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>	<20091110193539.7e1392f3@hyperion.delvare>	<4AF9B5E3.1060902@kionix.com>	<4AF9B847.3070008@cam.ac.uk>	<4AF9CDF2.2070003@kionix.com> <20091110223907.1f47b07f@hyperion.delvare> <4AF9E115.9090603@kionix.com> <4AFAC6C2.8010708@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:35608 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753188AbZKKOVW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 09:21:22 -0500
In-Reply-To: <4AFAC6C2.8010708@cam.ac.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Jean Delvare <khali@linux-fr.org>, linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org



Jonathan Cameron wrote:
> Chris Hudson wrote:
>   
>> Jean Delvare wrote:
>>     
>>> On Tue, 10 Nov 2009 15:32:50 -0500, Chris Hudson wrote:
>>>  
>>>       
>>>> Thank you for your insight Jonathan.  The driver was originally
>>>> written for the 2.6.29 omap-android kernel to facilitate integration
>>>> of the kxte9 into customer projects.  Unfortunately, it seems that
>>>> things in the kernel have changed since then, but I'm not sure how
>>>> much we can change without sacrificing compatibility with the Android
>>>> sensor API.  Is there a different place where this driver could go
>>>> without requiring significant redesign?
>>>>     
>>>>         
>>> I don't think a move implies a redesign. You could put exactly the same
>>> driver under drivers/misc, drivers/accel, drivers/input or what do I
>>> know. I don't want it in drivers/hwmon, but I don't care about anything
>>> else.
>>>
>>>   
>>>       
>> Thank you Jean; I will resubmit the driver for drivers/input/misc if
>> that sounds appropriate.  On another note, I accidentally left some
>> debug code in place that I will be removing (unless it seems appropriate
>> to leave that in for intermediate testing).  Any thoughts on this?
>>     
> I'd run the code (or a description) quickly past the input maintainer 
> Dmitry Torokhov <dmitry.torokhov@gmail.com> before putting any effort into
> this.  You certainly don't want to being playing pingpong around the kernel
> like one or two other drivers have!
>
> Personally I'd drop debugging unless you have a reason you think there may be
> problems.   I'm guessing no one who will do review has one anyway so testing
> will be over to you in the short term anyway!  If it's not useful to you anymore
> drop it.
>
> Jonathan
> --
>
>   
Thanks for the advice Jonathan.  I sent the code to Dmitry last night 
and already have some good feedback, so I think that's where it will end up.
-Chris

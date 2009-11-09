From: Chris Hudson <chudson@kionix.com>
Subject: Re: Driver Merge Questions
Date: Mon, 09 Nov 2009 09:54:31 -0500
Message-ID: <4AF82D27.2010705@kionix.com>
References: <4AF040D1.7020109@kionix.com> <20091103165821.GG8981@atomide.com> <20091109092621.GY1773@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:58097 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754249AbZKIOyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 09:54:35 -0500
In-Reply-To: <20091109092621.GY1773@smtp.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Chris Hudson <chudson@kionix.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, amit.kucheria@verdurent.com

Hello Amit,

Thank you for the information.

The driver is just about finished actually; I was going to do some final 
testing and pull and submit the patches today.  I read the lkml.org 
source and it definitely seems like things are in a state of limbo at 
the moment (well, as of a few months ago) with regard to sensor 
drivers.  So, should I submit the code as-is and work on changing it as 
necessary with the help of the community, or do I step back and modify 
for the iio subsystem before submission?  Alternatively, since the code 
was originally written for the 2.6.29 Android kernel, should I submit 
the current version of the driver to that branch first?  Please let me know.

Thank you,
Chris

Amit Kucheria wrote:
> On 09 Nov 03, Tony Lindgren wrote:
>   
>> * Chris Hudson <chudson@kionix.com> [091103 06:48]:
>>     
>>> Hello all,
>>>
>>> I've never submitted any software to Linux before, but I've been
>>> working on some new accelerometer drivers that should be ready for
>>> review soon (pending company approval).  I've read lots of
>>> documentation on patch and driver submissions, but I still have some
>>> questions that I was hoping someone could help me find the answers
>>> to.
>>>
>>> 1- My drivers use i2c for hardware communications, miscdevice for
>>> IOCTLs, and input_dev for data and interrupt status outputs.  Most
>>> of the other accelerometer drivers that I've looked at use similar
>>> designs and are located in drivers/hwmon, but I just wanted to
>>> confirm that this is the correct location currently.
>>>       
>> Sounds correct.
>>     
>
> Unfortunately it will probably get rejected in drivers/hwmon. The maintainer,
> Jean Delavare wants them out of hwmon[1]. It seems that everyone (for the
> moment) is leaning towards a new subsystem called industrial IO
> (drivers/staging/iio) for such drivers.
>
> Please ask Jean before you do the work to make your driver behave like a hwmon
> driver.
>
> Regards,
> Amit
>
>
> [1] http://lkml.org/lkml/2009/7/2/153
>   

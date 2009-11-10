From: Chris Hudson <chudson@kionix.com>
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
 kxte9  accelerometer
Date: Tue, 10 Nov 2009 13:50:11 -0500
Message-ID: <4AF9B5E3.1060902@kionix.com>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com> <20091110193539.7e1392f3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:33753 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757589AbZKJSuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 13:50:16 -0500
In-Reply-To: <20091110193539.7e1392f3@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org



Jean Delvare wrote:
> On Tue, 10 Nov 2009 13:28:47 -0500, chudson@kionix.com wrote:
>   
>> From: Chris Hudson <chudson@kionix.com>
>>
>> This is a request for comments for adding driver support for the Kionix KXTE9 
>> digital tri-axis accelerometer.  This part features built-in tilt position 
>> (orientation), wake-up and back-to-sleep algorithms, which can trigger a 
>> user-configurable physical interrupt.  The driver uses i2c for device 
>> communication, a misc node for IOCTLs, and input nodes for reporting 
>> acceleration data and interrupt status information.
>>
>> Signed-off-by: Chris Hudson <chudson@kionix.com>
>>     
>
> Nack. We want less accelerometer drivers polluting drivers/hwmon, not
> more.
>
>   
Thank you Jean for your quick reply.  I have seen some accelerometer 
drivers in drivers/staging/iio/accel; is this where they are all being 
moved to?

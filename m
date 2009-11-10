From: Chris Hudson <chudson@kionix.com>
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon:driver support for Kionix
  kxte9 accelerometer
Date: Tue, 10 Nov 2009 16:54:29 -0500
Message-ID: <4AF9E115.9090603@kionix.com>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>	<20091110193539.7e1392f3@hyperion.delvare>	<4AF9B5E3.1060902@kionix.com>	<4AF9B847.3070008@cam.ac.uk>	<4AF9CDF2.2070003@kionix.com> <20091110223907.1f47b07f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:34186 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754443AbZKJVy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 16:54:28 -0500
In-Reply-To: <20091110223907.1f47b07f@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> On Tue, 10 Nov 2009 15:32:50 -0500, Chris Hudson wrote:
>   
>> Thank you for your insight Jonathan.  The driver was originally written 
>> for the 2.6.29 omap-android kernel to facilitate integration of the 
>> kxte9 into customer projects.  Unfortunately, it seems that things in 
>> the kernel have changed since then, but I'm not sure how much we can 
>> change without sacrificing compatibility with the Android sensor API.  
>> Is there a different place where this driver could go without requiring 
>> significant redesign?
>>     
>
> I don't think a move implies a redesign. You could put exactly the same
> driver under drivers/misc, drivers/accel, drivers/input or what do I
> know. I don't want it in drivers/hwmon, but I don't care about anything
> else.
>
>   
Thank you Jean; I will resubmit the driver for drivers/input/misc if 
that sounds appropriate.  On another note, I accidentally left some 
debug code in place that I will be removing (unless it seems appropriate 
to leave that in for intermediate testing).  Any thoughts on this?

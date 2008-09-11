From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: Bug in twl4030backupbatt_voltage()
Date: Thu, 11 Sep 2008 09:02:24 +0530
Message-ID: <003e01c913bf$03754c70$LocalHost@wipultra1303>
References: <48BEA8DC.3030905@nokia.com> <20080909174214.GP29054@atomide.com> <48C7771E.6080307@nokia.com> <022001c91346$d09d54a0$LocalHost@wipultra1303> <20080910153946.GA29054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40049 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752743AbYIKDcU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 23:32:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <ext-adrian.hunter@nokia.com>, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Cc: "Adrian Hunter" <ext-adrian.hunter@nokia.com>; <linux-omap@vger.kernel.org>
Sent: Wednesday, September 10, 2008 9:09 PM
Subject: Re: Bug in twl4030backupbatt_voltage()


>* Madhusudhan Chikkature <madhu.cr@ti.com> [080910 06:12]:
>> 
>> ----- Original Message ----- 
>> From: "Adrian Hunter" <ext-adrian.hunter@nokia.com>
>> To: "Tony Lindgren" <tony@atomide.com>
>> Cc: <linux-omap@vger.kernel.org>; <madhu.cr@ti.com>
>> Sent: Wednesday, September 10, 2008 12:58 PM
>> Subject: Re: Bug in twl4030backupbatt_voltage()
>> 
>> 
>> > Tony Lindgren wrote:
>> >> * Adrian Hunter <ext-adrian.hunter@nokia.com> [080903 08:08]:
>> >>> In the omap tree, commit f91fd98be045bec9c18e13110f22dafd44cb84b5
>> >>> fixed a bug with the use of function twl4030_madc_conversion()
>> >>> relating to the local variable 'struct twl4030_madc_request req'
>> >>> not being fully initialised.
>> >>>
>> >>> The same problem appears to be in the function
>> >>> twl4030backupbatt_voltage() which is in drivers/power/twl4030_bci_battery.c
>> >> 
>> >> Thanks, I'll initialize it to NULL. Wouldn't it have been easier just
>> >> to write a patch instead of the description above? :)
>> > 
>> > Apparently.
>> > 
>> > There is also req.do_avg which should be zero, if you assume the programmer's
>> > intent was to have uninitialised members set to zero.
>> I guess, I did not look at all the other members of the "twl4030_madc_request" structure. I might have missed it.
>> The do_avg and func_cb fields can both be set to NULL.
> 
> Can you please check the code and send a patch?
Yes. I will do that.

Regards,
Madhu
> 
> Thanks,
> 
> Tony
> 
>

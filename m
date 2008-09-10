From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: Re: Bug in twl4030backupbatt_voltage()
Date: Wed, 10 Sep 2008 10:28:30 +0300
Message-ID: <48C7771E.6080307@nokia.com>
References: <48BEA8DC.3030905@nokia.com> <20080909174214.GP29054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:56334 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbYIJHZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 03:25:19 -0400
In-Reply-To: <20080909174214.GP29054@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, madhu.cr@ti.com

Tony Lindgren wrote:
> * Adrian Hunter <ext-adrian.hunter@nokia.com> [080903 08:08]:
>> In the omap tree, commit f91fd98be045bec9c18e13110f22dafd44cb84b5
>> fixed a bug with the use of function twl4030_madc_conversion()
>> relating to the local variable 'struct twl4030_madc_request req'
>> not being fully initialised.
>>
>> The same problem appears to be in the function
>> twl4030backupbatt_voltage() which is in drivers/power/twl4030_bci_battery.c
> 
> Thanks, I'll initialize it to NULL. Wouldn't it have been easier just
> to write a patch instead of the description above? :)

Apparently.

There is also req.do_avg which should be zero, if you assume the programmer's
intent was to have uninitialised members set to zero.

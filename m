From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Thu, 04 Feb 2010 09:46:40 -0800
Message-ID: <87iqac51xb.fsf@deeprootsystems.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
	<20100128032242.GA9070@lixom.net>
	<50326.192.168.10.89.1265296150.squirrel@dbdmail.itg.ti.com>
	<20100204152847.GA711@lixom.net>
	<40204.192.168.10.88.1265298323.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:3713 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab0BDRqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 12:46:50 -0500
Received: by qw-out-2122.google.com with SMTP id 9so292281qwb.37
        for <linux-omap@vger.kernel.org>; Thu, 04 Feb 2010 09:46:48 -0800 (PST)
In-Reply-To: <40204.192.168.10.88.1265298323.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Thu\, 4 Feb 2010 21\:15\:23 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

[...]

>>> >> + * @baud: baudrate for which divisor needs to be calculated.
>>> >> + *
>>> >> + * We have written our own function to get the divisor so as to support
>>> >> + * 13x mode.
>>> >> + */
>>> >
>>> > Again, the why, not the how. Why do you need the 13x divisor? What's
>>> > magic about 3Mbaud?
>>> >
>>>
>>> Refering to TRM UART chapter 17:
>>>
>>> Table 17-1. UART Mode Baud Rates, Divisor Values, and Error Rates
>>>
>>> referring to oversampling - divisor value
>>>
>>> baudrate 460,800 to 3,686,400 all have divisor 13
>>>
>>> except 3,000,000 which has divisor value 16
>>>
>>> thus we are checking if baud != 3000000
>>
>> Ok. It's always useful to have just a bit of information in the driver
>> so you don't have to search around the manual when trying to figure out
>> why something was done.
>>
>> Maybe something simple: "3Mbaud is unique in that it requires a divisor
>> of 13. See the TRM for full details".
>
> ok. will add that comments.

Referncing TRM Chapter and Section names (and/or numbers) is very
helpful too.  Usually section names are more helpful since numbers
change w/TRM versions.

Kevin

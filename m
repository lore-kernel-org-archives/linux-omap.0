From: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Subject: Re: [PATCH 2/5] I2C: TWL4030: Kconfig and Makefile changes
Date: Fri, 04 Apr 2008 13:54:54 +0300
Message-ID: <47F608FE.1040209@nokia.com>
References: <1207224865-21527-1-git-send-email-felipe.balbi@nokia.com> <1207224865-21527-2-git-send-email-felipe.balbi@nokia.com> <200804031113.11115.david-b@pacbell.net> <3B6D69C3A9EBCA4BA5DA60D91302742903F1415B@dlee13.ent.ti.com> <20080403202006.C174F35F704@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:36991 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755042AbYDDKzm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 06:55:42 -0400
In-Reply-To: <20080403202006.C174F35F704@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: r-woodruff2@ti.com, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

Hi,

David Brownell wrote:

>> Really:
>>
>> It's a 10-bit analog-to-digital converter combined with a 16-input
>> analog multiplexer.  Multiplexed-ADC I suppose.  It is used by
>> processor groups, battery charger and USB sub-chip.
>>
>> 8 of the 16 inputs are externally useable and the other 8 are used
>> by battery, speaker, usb.
> 
> In short, a fairly typical 10-bit/16-channel ADC, with some channels
> serving dedicated functions.  Thanks.  That should be in the driver,
> and in the Kconfig helptext.

The letter 'M' here stands for Monitoring. However, it's still fairly 
typical ADC (as it was already pointed out).

I'll clarify this in the driver and Kconfig and submit a new patch.

-- 
Regards, Mikko Ylinen

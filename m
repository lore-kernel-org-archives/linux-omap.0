From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/5] I2C: TWL4030: Kconfig and Makefile changes
Date: Fri, 4 Apr 2008 05:59:26 -0500
Message-ID: <17b16bdfc7296ee38ce68c6c03ef0262@felipebalbi.com>
References: <47F608FE.1040209@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34412 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbYDDK7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Apr 2008 06:59:34 -0400
In-Reply-To: <47F608FE.1040209@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Cc: ext David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com, felipe.balbi@nokia.com, linux-omap@vger.kernel.org



On Fri, 04 Apr 2008 13:54:54 +0300, Mikko Ylinen <mikko.k.ylinen@nokia.com>
wrote:
> Hi,
> 
> David Brownell wrote:
> 
>>> Really:
>>>
>>> It's a 10-bit analog-to-digital converter combined with a 16-input
>>> analog multiplexer.  Multiplexed-ADC I suppose.  It is used by
>>> processor groups, battery charger and USB sub-chip.
>>>
>>> 8 of the 16 inputs are externally useable and the other 8 are used
>>> by battery, speaker, usb.
>>
>> In short, a fairly typical 10-bit/16-channel ADC, with some channels
>> serving dedicated functions.  Thanks.  That should be in the driver,
>> and in the Kconfig helptext.
> 
> The letter 'M' here stands for Monitoring. However, it's still fairly
> typical ADC (as it was already pointed out).
> 
> I'll clarify this in the driver and Kconfig and submit a new patch.

Maybe a help entry in the Kconfig will be enough?
I like the small TWL4030_MADC string :-p

> 
> --
> Regards, Mikko Ylinen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com


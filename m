From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 2/2 v2] hwmon: twl4030: Hwmon Driver for TWL4030 MADC
Date: Mon, 28 Feb 2011 09:19:34 +0530
Message-ID: <AANLkTinUbBsRhWnVHMA_1BKq3StH+xrTOEnXHCwkKMPL@mail.gmail.com>
References: <1298560730-18826-1-git-send-email-j-keerthy@ti.com>
	<20110228010306.GE2749@sortiz-mobl>
	<20110228034108.GA2584@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48932 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752378Ab1B1Dtg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Feb 2011 22:49:36 -0500
Received: by mail-ew0-f41.google.com with SMTP id 10so1231063ewy.28
        for <linux-omap@vger.kernel.org>; Sun, 27 Feb 2011 19:49:35 -0800 (PST)
In-Reply-To: <20110228034108.GA2584@ericsson.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 28, 2011 at 9:11 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Sun, Feb 27, 2011 at 08:03:07PM -0500, Samuel Ortiz wrote:
>> Hi Keerthy,
>>
>> On Thu, Feb 24, 2011 at 08:48:50PM +0530, Keerthy wrote:
>> > This driver exposes the sysfs nodes of the TWL4030 MADC module.
>> > All the voltage channel values are expressed in terms of mV. Channel 13
>> > and channel 14 are reserved. There are channels which represent
>> > temperature and current the output is represented by celcius
>> > and mA respectively.
>> It would make sense for me to carry both patches through the MFD tree, but
>> I'd like to get Guenter's ACK before pushing it upstream.
>>
> Main problem I have with the hwmon part is the sensor index value
> and how it maps to adc channels. Specifically, channels 13 and 14 are
> listed as reserved, yet index value 13 is used without further explanation
> as bit map value passed on to twl4030_madc_conversion() to obtain the value
> for channel 15. Either this is wrong, or it asks for a detailed explanation.
> I didn't have time to track down which one it is. And even if it isn't wrong,
> it doesn't seem to be the right thing to do since it adds a lot of confusion.
>
> Guenter
>

Guenter,

It should be 15. I will repost with the changed value.
Sorry for the confusion.

Regards,
Keerthy



-- 
Regards and Thanks,
Keerthy

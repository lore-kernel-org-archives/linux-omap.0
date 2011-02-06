From: Grant Erickson <marathon96@gmail.com>
Subject: Re: How to completely switch off LCD backlight
Date: Sun, 06 Feb 2011 10:58:09 -0800
Message-ID: <C9742F41.23E44%marathon96@gmail.com>
References: <4732E696-B597-4BCE-A0E9-E60E30A7F94D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:40820 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1BFS6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Feb 2011 13:58:25 -0500
Received: by pxi15 with SMTP id 15so758637pxi.19
        for <linux-omap@vger.kernel.org>; Sun, 06 Feb 2011 10:58:25 -0800 (PST)
In-Reply-To: <4732E696-B597-4BCE-A0E9-E60E30A7F94D@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

On 2/6/11 9:53 AM, Elvis Dowson wrote:
> On Feb 6, 2011, at 9:30 PM, Grant Erickson wrote:
>> The following script should be instructive:
>> 
>>    device="/sys/devices/platform/pwm-backlight.0/backlight/pwm-backlight.0"
> 
> For me, this is located in /sys/class/backlight/beagleboard
> 
> and bl_power is located in /sys/class/backlight/beagleboard
> 
>>    power="${device}/bl_power"
>>    brightness="${device}/brightness"
>>    max="${device}/max_brightness"
>> 
>> 
>>    disable_backlight () {
>>        echo 1 > ${power}
>>    }
>> 
>>    enable_backlight () {
>>        echo 0 > ${power}
>>    }
> 
> I did try
> 
> echo 1 > bl_power
> 
> but there was no effect. GPIO 96 from the OMAP3503 is physically connected to
> LCD LED backlight enable, which I think is what would be used to turn the
> backlight on/off.
> 
> Where can I specify the mapping of GPIO 96 to the bl_power file, so that the
> LCD backlight can be switched off?

Elvis:

If you are using the generic pwm-bl.c driver and you are using something
akin to:

    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38559.html

handle the PWM, then you likely need to perform gpio_set_value in your
platform-specific notify callback.

When using the pwm-bl.c driver (or likely any other than uses the generic
backlight class), bl_power toggles the on/off state of the backlight YET
preserves the current brightness level of the backlight.

So, if your backlight is on at 50% and you turn it off with bl_power, when
you turn it back on again with bl_power, it'll return to 50%.

In the pwm-bl.c driver, this all happens with pwm-config(). So, in your
notify callback, when you get a brightness value of zero, you'll call
gpio_set_value(96, 0)--assuming your enable signal is active high. Likewise,
when you get a brightness value of non-zero, you'll call gpio_set_value(96,
1)--again, assuming your enable signal is active high.

The generic PWM device is then handling the level then the enable GPIO is
asserted (which, again, you are controlling in your notify callback).

Best,

Grant

> 
> Elvis
> 
> 
> 



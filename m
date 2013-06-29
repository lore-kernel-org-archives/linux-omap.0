From: Marc Murphy <marcmltd@marcm.co.uk>
Subject: RE: AM35xx i2c3 issues
Date: Sat, 29 Jun 2013 20:23:41 +0000
Message-ID: <F690310232FDDF4AB457E8B3EF90DDE08D2EA18E@MARCM-SBS2011.marcmltd.local>
References: <F690310232FDDF4AB457E8B3EF90DDE08D2E797B@MARCM-SBS2011.marcmltd.local>
 <F690310232FDDF4AB457E8B3EF90DDE08D2E7A08@MARCM-SBS2011.marcmltd.local>,<20130627084643.GA12956@panicking>
 <F690310232FDDF4AB457E8B3EF90DDE08D2E7AD5@MARCM-SBS2011.marcmltd.local>
 <51CC1E4F.8000007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm1-vm6.bt.bullet.mail.ir2.yahoo.com ([212.82.99.216]:37943
	"EHLO nm1-vm6.bt.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752795Ab3F2UXq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Jun 2013 16:23:46 -0400
In-Reply-To: <51CC1E4F.8000007@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Grygorii Strashko' <grygorii.strashko@ti.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Grygorii
I tried the three patches but they didn't seem to make a difference. So I put the JTAG on and had a look at all the register settings for i2c2 and i2c3 and they are all fine.

I thought to switch from the new platform I am bringing up back to the dev platform (Technexion twister AM3517) and try and replicate the same connections that I have on the target platform and i2c3 is coming up, I can talk to the rtc chip.

I think I will need to get the board back to the hardware guys to get them to check the bus for shorts or at least, what I think is the mpu6050 has been fitted incorrectly so it's taking the bus down.

Sorry to have raised the non i2c3 channel as an issue, it looks like it's all working fine.

Kind Regards
Marc

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Grygorii Strashko
Sent: 27 June 2013 12:13
To: Marc Murphy
Cc: Michael Trimarchi; linux-omap@vger.kernel.org
Subject: Re: AM35xx i2c3 issues

Hi Marc,

Could you try these patches first:
https://patchwork.kernel.org/patch/2685541/
http://patchwork.ozlabs.org/patch/252639/

Then try this patch alone:
https://patchwork.kernel.org/patch/2689171/

Also could you provide your .config?  Do you have lm75 (or any other hwmon devices) enabled?

-grygorii

On 06/27/2013 12:15 PM, Marc Murphy wrote:
> Hi Michael,
> The bus is correctly terminated with 2.2k pullups on SCL and SDA lines.
>
> Kind Regards
> Marc
>
> ________________________________________
> From: Michael Trimarchi [michael@amarulasolutions.com]
> Sent: 27 June 2013 09:46
> To: Marc Murphy
> Cc: linux-omap@vger.kernel.org
> Subject: Re: AM35xx i2c3 issues
>
> Hi
>
> On Thu, Jun 27, 2013 at 08:29:05AM +0000, Marc Murphy wrote:
>> Hello Grygorii/All,
>>
>> I have been trying to address an issue I am having with 3.6rc6 kernel and even with the latest 3.9 and trying to use i2c3 channel on an AM3517.
>>
>> I see that there has been some work done on the OMAP4 and issues with i2c which looks like the controller being suspended during boot.
>>
>> I would like to know how I can enable the debug so I can see the messages for warning and debug and whether anyone has tested i2c3 channel on an AM3517 ?
>>
>> I find the problem a little confusing as the system initializes the 
>> interfaces 1-3
>>
>> [    0.168182] omap_i2c omap_i2c.1: bus 1 rev1.3.12 at 400 kHz
>> [    0.169830] VDCDC1: 1200 <--> 1600 mV at 1200 mV normal
>> [    0.169830] VDCDC1: Voltage range but no REGULATOR_CHANGE_VOLTAGE
>> [    0.170684] VDCDC2: 3300 mV normal
>> [    0.171264] VDCDC3: 1800 mV normal
>> [    0.171905] LDO1: 1800 mV normal
>> [    0.172729] LDO2: 3300 mV normal
>> [    0.174102] omap_i2c omap_i2c.2: bus 2 rev1.3.12 at 400 kHz
>> [    0.187530] omap_i2c omap_i2c.3: bus 3 rev1.3.12 at 400 kHz
>>
>> But when it comes to probe the i2c3 interface for the mpu6050 that is 
>> connected it fails
>>
>> [    3.896606] omap_i2c omap_i2c.3: timeout waiting for bus ready
>> [    3.902832] inv-mpu6050: probe of 3-0068 failed with error -110
>>
>
> Can you check if your bus is correctly pull up on the line?
>
> Michael
>
>> If I move the mpu6050 onto the i2c2 channel it's OK so its not an issue with the core omap_i2c.
>>
>> I also have a scope connected to the scl line and see no activity.  I have proved to myself that the pin is connected and working by configuring as a GPIO output and toggling 0/1/0 and I can see the output changing on the scope.
>>
>> The mux is configured correctly from what I can see using debugfs #  
>> cat /sys/kernel/debug/omap_mux/i2c3_scl
>> name: i2c3_scl.i2c3_scl (0x480021c2/0x192 = 0x0100), b af14, t NA
>> mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
>> signals: i2c3_scl | NA | NA | NA | gpio_184 | NA | NA | safe_mode
>>
>> #  cat /sys/kernel/debug/omap_mux/i2c3_sda
>> name: i2c3_sda.i2c3_sda (0x480021c4/0x194 = 0x0100), b ag14, t NA
>> mode: OMAP_PIN_INPUT | OMAP_MUX_MODE0
>> signals: i2c3_sda | NA | NA | NA | gpio_185 | NA | NA | safe_mode
>>
>>
>> If I probe with i2cdetect for all 3 buses there is only an issue with 
>> i2c3 # i2cdetect -r 1 WARNING! This program can confuse your I2C bus, 
>> cause data loss and worse!
>> I will probe file /dev/i2c-1 using read byte commands.
>> I will probe address range 0x03-0x77.
>> Continue? [Y/n]
>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- UU -- -- -- -- -- -- --
>> 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>> # i2cdetect -r 2
>> WARNING! This program can confuse your I2C bus, cause data loss and worse!
>> I will probe file /dev/i2c-2 using read byte commands.
>> I will probe address range 0x03-0x77.
>> Continue? [Y/n]
>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
>> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
>> 70: -- -- -- -- -- -- -- --
>>
>> # i2cdetect -r 3
>> WARNING! This program can confuse your I2C bus, cause data loss and worse!
>> I will probe file /dev/i2c-3 using read byte commands.
>> I will probe address range 0x03-0x77.
>> Continue? [Y/n]
>>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00:          [  837.943481] omap_i2c omap_i2c.3: timeout waiting for bus ready
>> -- [  838.958984] omap_i2c omap_i2c.3: timeout waiting for bus ready
>> -- [  839.974731] omap_i2c omap_i2c.3: timeout waiting for bus ready
>>
>>
>> Any pointers/help appreciated as I have the accelerometer and RTC chip connected on i2c3 but cannot get anything working.
>>
>> Kind Regards
>>
>> Marc
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

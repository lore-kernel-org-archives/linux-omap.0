From: Bernhard Walle <bernhard@bwalle.de>
Subject: Re: [PATCH] mfd: Add TWL4030 PWM driver
Date: Wed, 21 Mar 2012 07:15:29 +0100
Message-ID: <4F697201.1090206@bwalle.de>
References: <1332262083-9375-1-git-send-email-walle@corscience.de> <201203202202.12060.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201203202202.12060.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Am 20.03.12 23:02, schrieb Arnd Bergmann:
> On Tuesday 20 March 2012, Bernhard Walle wrote:
>>
>> This PWM driver uses the PWM of the TWL4030. The driver for the TWL6030
>> PWM has been used as mode, but the PWM registers are different.
>>
>> The driver can be used and has been tested in conjunction with
>> pwm-backlight to control a backlight LED of a LCD touch screen.
>>
>> Signed-off-by: Bernhard Walle <walle@corscience.de>
> 
> Since it's too late for v3.4 now and we will get a new pwm
> subsystem in v3.5, I suggest you change the driver to work
> register with that subsystem instead of just using the old
> header file. Note that drivers/mfd is not really the right
> place anyway, because this is not a multifunction driver but
> just one device driver that happens to be a slave of an mfd.

Does that new subsystem already exist in some tree?

Regards,
Bernhard

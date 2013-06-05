From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] i2c: Let users disable "Probe an I2C bus for certain
 devices"
Date: Wed, 5 Jun 2013 19:13:59 +0300
Message-ID: <51AF63C7.9070007@ti.com>
References: <1370367222-19353-1-git-send-email-grygorii.strashko@ti.com> <20130604174900.GA2992@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130604174900.GA2992@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi
On 06/04/2013 08:49 PM, Wolfram Sang wrote:
> On Tue, Jun 04, 2013 at 08:33:42PM +0300, Grygorii Strashko wrote:
>
>> Currently the I2C devices instantiation Method 3 "Probe an I2C bus for
>> certain devices" (see Documentation/i2c/instantiating-devices) is always
>> enabled for all platforms (boards) and can't be disabled.
> Not true. Set .class = 0 for your adapter. I always ask authors of new
> drivers if they really need to set .class to something.
>
Agree, sorry, my statement is wrong. it would be right to say
"..can't be disabled without kernel code modification".

Few notes here:
1) boot delay issue isn't related to new drivers. There are
hwmon/lm75.c, i2c/busses/i2c-gpio.c and i2c/busses/i2c-omap.c

2) Initially, I've fighted with it on TI K3.4 product kernel where
DT isn't supported yet. And first thing, which I've tried to do is to 
correct
.class parameter for adapter, but with assumption:
"Default behavior shouldn't be changed as I2C detection might be used by 
some
of OMAP boards".

I've started from i2c-omap.c and OMAP4/5 (my target). As result, I was 
need to make
changes in *7* files to set and pass platform parameter to i2c-omap.c 
driver which
will allow to change .class to 0 on demand.

At this point, I've realized that i still need to deal with i2c-gpio.c - 
which
is generic driver.

3) Thinking about Mainline: To reach the same target - no I2C detection 
- and taking
into account above assumption "No changes in default behavior"
the following will need to be done:
- change i2c-omap/i2c-gpio DT bindings and add parameter which will 
allow to change
   .class value for adapter. Not sure, it's possible because this parameter
   will be Linux and not HW specific (smth. like "i2c_disable_detection")
- update drivers i2c-omap/i2c-gpio to use "i2c_disable_detection"
- update OMAP4/5 DTS files

So, It seemed a good solution for me to add 6 lines of code in i2c-core.c
instead of doing all that stuff.

Thanks/sorry for your time.

- grygorii

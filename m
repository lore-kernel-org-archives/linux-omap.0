From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 6/6] tty: serial: Add 8250-core based omap driver
Date: Wed, 16 Jul 2014 14:11:57 +0200
Message-ID: <53C66C0D.5060501@linutronix.de>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de> <1404928177-26554-7-git-send-email-bigeasy@linutronix.de> <20140710070948.GH28884@atomide.com> <53BEB5AF.7010604@linutronix.de> <20140711064151.GJ28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140711064151.GJ28884@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/11/2014 08:41 AM, Tony Lindgren wrote:
>> I tried this with am335x-evm, dra7-evm and beaglebone (omap5-uevm and
>> am335x-evmsk didn't want to boot a kernel and omap4-blaze didn't even
>> want to show MLO/U-boot) with the same result.
> 
> None of these SoCs support off-idle with mainline kernel so testing
> with those is not enough :) Best to use some omap3 based device for
> testing this.
> 
> So far I have verified that beagleboard xm, n900, and omap3730-evm
> all hit off-idle with v3.16-rc4.

Unfortunately I don't have access to any of those devices.

>> I had network up and configured. Was that okay? I also tried
>> "ifconfig eth0 down; sleep 10; ifconfig eth0 up" to see if it works.
> 
> That's fine for GPMC connected devices, devices with Ethernet on
> EHCI won't idle properly AFAIK.

am33xx has proper ethernet (cpsw IP core on SoC and not something
behind USB).

>> That core_pwrdm shows only up on dra7. However with both drivers (mine
>> and the current omap serial) the UART went down after three secs (as
>> expected) and didn't accept any characters while writing on the
>> console. If I wrote something on it via network (like echo a >
>> /dev/ttyO0) it came back and was working as long as I kept it busy. The
>> thing is that RX does not wake it up. Any idea?
> 
> If the RX pin does not wake it up, you need to configure the
> pinctrl-single entry for it, and configure that pin as a wake-up
> interrupt. See the interrupts-extended entry in omap3-beagle-xm.dts.

This does not help. Checking the manual, there is not something like
PIN_OFF_WAKEUPENABLE for am33xx. There is just INPUT/OUTPUT, pull
up/down + enabled/disabled and the mux_mode. For the interrupt, the HW
referenced as omap3_pmx_core touches some bits in the pinmux register
which do not exists on am33xx.

So I have nothing on HW around that could test wakeup scenario.

>> Also, while it was I checked the core_pwrdm and I had ON:1 and OFF:0.
>> So something is not right.
>> Since Dra7 has some things missing I tried it on am335x with the same
>> behavior. Should it work here?
> 
> Yes only omap3 currently has the pieces needed for off-idle in the
> mainline kernel.
>  

Good to know.

>> puh. So after staring a while at your backtrace I realized that
>> shutdown & startup callbacks are not overwritten properly. Well, thanks
>> for that. Anyway, even serial8250_do_startup() has
>> pm_runtime_get_sync() before first register access so I have no idea
>> where this is coming from.
> 
> Maybe because the console is enabled for that port?

Maybe. But I would expect to explode around the console code. Anyway I
fixed it up and prepare next batch.

> 
> Regards,
> 
> Tony


Sebastian

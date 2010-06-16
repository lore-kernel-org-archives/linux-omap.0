From: Michael Trimarchi <michael@panicking.kicks-ass.org>
Subject: Re: Serial console not working after waking up from sleep
Date: Wed, 16 Jun 2010 16:47:20 +0200
Message-ID: <4C18E3F8.1060605@panicking.kicks-ass.org>
References: <AANLkTind1hzgSWIfzNBxjCXPpdPhMYgUkSqYA0WjjYjR@mail.gmail.com>	<4C186A97.5040208@panicking.kicks-ass.org> <AANLkTikISCuLKjHTzn6FfiqMRlIKf7tY5RZlYXU40U1W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from panicking.kicks-ass.org ([95.141.32.57]:44166 "EHLO
	panicking.kicks-ass.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758799Ab0FPOr3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 10:47:29 -0400
In-Reply-To: <AANLkTikISCuLKjHTzn6FfiqMRlIKf7tY5RZlYXU40U1W@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Han Wang <hw342@cornell.edu>
Cc: linux-omap@vger.kernel.org

Hi

Han Wang wrote:
> Hi, michael,
>=20
>    I have the no_console_suspend option in my boot command line, I am
> not sure if that is the option you were trying to point me to in the
> last email?

I have said that i have no problem when I remove that option.
Can you try to echo 0 to timeout of the serial device?

Michael

>=20
>    anyway, I added no_debug_console into my boot command arg, but tha=
t
> doesn't seem to help with my problem.
>=20
>    any ideas?
>=20
> Thanks,
> Han
> On Wed, Jun 16, 2010 at 2:09 AM, Michael Trimarchi
> <michael@panicking.kicks-ass.org> wrote:
>> Han Wang wrote:
>>> Hi,
>>>
>>>  I am testing the 2.6.35-rc1 pm branch code on Overo. The system
>>> boots ok. (I can provide booting log if that is necessary) However,
>>> when I use "echo mem > /sys/power/state" to send overo to sleep and
>>> wake it up by enter a key into serial console. I got garbage
>>> characters in the serial console, and I can not enter anything into
>>> the console anymore. I wonder if anyone has encountered a similar
>>> problem, and please give me some suggestion.
>>>
>>> I have appended command log below.
>>>
>>> root@overo:~# echo mem > /sys/power/state
>>> PM: Syncing filesystems ... done.
>>> PM: Preparing system for mem sleep
>>> PM: Adding info for No Bus:vcs63
>>> PM: Adding info for No Bus:vcsa63
>>> Freezing user space processes ... (elapsed 0.02 seconds) done.
>>> Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
>>> PM: Entering mem sleep
>>> i2c_omap i2c_omap.1: preparing suspend
>>> i2c_omap i2c_omap.3: preparing suspend
>>> platform overo_lcd: preparing suspend
>>> serial8250 serial8250.0: preparing suspend, may wakeup
>>> serial8250 serial8250.1: preparing suspend, may wakeup
>>> serial8250 serial8250.2: preparing suspend, may wakeup
>>> platform omap2-nand: preparing suspend
>>> platform musb_hdrc: preparing suspend
>>> platform smsc911x.0: preparing suspend
>>> platform smsc911x.1: preparing suspend
>>> platform omap2_mcspi.1: preparing suspend
>>> platform omap2_mcspi.2: preparing suspend
>>> platform omap2_mcspi.3: preparing suspend
>>> platform omap2_mcspi.4: preparing suspend
>>> arm-pmu arm-pmu.0: preparing suspend
>>> platform omap_rng: preparing suspend
>>> platform omapfb: preparing suspend
>>> twl4030_gpio twl4030_gpio: preparing suspend
>>> mmci-omap-hs mmci-omap-hs.0: preparing suspend
>>> mmci-omap-hs mmci-omap-hs.1: preparing suspend
>>> twl_reg twl_reg.17: preparing suspend
>>> twl_reg twl_reg.18: preparing suspend
>>> twl_reg twl_reg.19: preparing suspend
>>> twl4030_usb twl4030_usb: preparing suspend, may wakeup
>>> twl_reg twl_reg.6: preparing suspend
>>> serial8250 serial8250: preparing suspend
>>> mmcblk mmc0:fb2a: legacy suspend
>>> serial8250 serial8250: suspend
>>> i2c i2c-3: suspend
>>> twl_reg twl_reg.6: suspend
>>> twl4030_usb twl4030_usb: suspend, may wakeup
>>> twl_reg twl_reg.19: suspend
>>> twl_reg twl_reg.18: suspend
>>> twl_reg twl_reg.17: suspend
>>> mmci-omap-hs mmci-omap-hs.1: suspend
>>> mmci-omap-hs mmci-omap-hs.0: suspend
>>> twl4030_gpio twl4030_gpio: suspend
>>> dummy 1-004b: suspend
>>> dummy 1-004a: suspend
>>> dummy 1-0049: suspend
>>> twl 1-0048: suspend, may wakeup
>>> i2c i2c-1: suspend
>>> platform omapfb: suspend
>>> platform omap_rng: suspend
>>> arm-pmu arm-pmu.0: suspend
>>> platform omap2_mcspi.4: suspend
>>> platform omap2_mcspi.3: suspend
>>> platform omap2_mcspi.2: suspend
>>> platform omap2_mcspi.1: suspend
>>> platform smsc911x.1: suspend
>>> platform smsc911x.0: suspend
>>> platform musb_hdrc: suspend
>>> platform omap2-nand: suspend
>>> serial8250 serial8250.2: suspend, may wakeup
>>> serial8250 serial8250.1: suspend, may wakeup
>>> serial8250 serial8250.0: suspend, may wakeup
>>> platform overo_lcd: suspend
>>> i2c_omap i2c_omap.3: suspend
>>> i2c_omap i2c_omap.1: suspend
>>> PM: suspend of devices complete after 201.965 msecs
>>> serial8250 serial8250: LATE suspend
>>> i2c i2c-3: LATE suspend
>>> twl_reg twl_reg.6: LATE suspend
>>> twl4030_usb twl4030_usb: LATE suspend, may wakeup
>>> twl_reg twl_reg.19: LATE suspend
>>> twl_reg twl_reg.18: LATE suspend
>>> twl_reg twl_reg.17: LATE suspend
>>> mmci-omap-hs mmci-omap-hs.1: LATE suspend
>>> mmci-omap-hs mmci-omap-hs.0: LATE suspend
>>> twl4030_gpio twl4030_gpio: LATE suspend
>>> dummy 1-004b: LATE suspend
>>> dummy 1-004a: LATE suspend
>>> dummy 1-0049: LATE suspend
>>> twl 1-0048: LATE suspend, may wakeup
>>> i2c i2c-1: LATE suspend
>>> platform omapfb: LATE suspend
>>> platform omap_rng: LATE suspend
>>> arm-pmu arm-pmu.0: LATE suspend
>>> platform omap2_mcspi.4: LATE suspend
>>> platform omap2_mcspi.3: LATE suspend
>>> platform omap2_mcspi.2: LATE suspend
>>> platform omap2_mcspi.1: LATE suspend
>>> platform smsc911x.1: LATE suspend
>>> platform smsc911x.0: LATE suspend
>>> platform musb_hdrc: LATE suspend
>>> platform omap2-nand: LATE suspend
>>> serial8250 serial8250.2: LATE suspend, may wakeup
>>> serial8250 serial8250.1: LATE suspend, may wakeup
>>> serial8250 serial8250.0: LATE suspend, may wakeup
>>> platform overo_lcd: LATE suspend
>>> i2c_omap i2c_omap.3: LATE suspend
>>> i2c_omap i2c_omap.1: LATE suspend
>>> PM: late suspend of devices complete after 103.088 msecs
>>> Successfully put all powerdomains to target state
>>> i2c_omap i2c_omap.1: EARLY resume
>>> i2c_omap i2c_omap.3: EARLY resume
>>> platform overo_lcd: EARLY resume
>>> serial8250 serial8250.0: EARLY resume
>>> serial8250 serial8250.1: EARLY resume
>>> serial8250 serial8250.2: EARLY resume
>>> platform omap2-nand: EARLY resume
>>> platform musb_hdrc: EARLY resume
>>> platform smsc911x.0: EARLY resume
>>> platform smsc911x.1: EARLY resume
>>> platform omap2_mcspi.1: EARLY resume
>>> platform omap2_mcspi.2: EARLY resume
>>> platform omap2_mcspi.3: EARLY resume
>>> platform omap2_mcspi.4: EARLY resume
>>> arm-pmu arm-pmu.0: EARLY resume
>>> platform omap_rng: EARLY resume
>>> platform omapfb: EARLY resume
>>> i2c i2c-1: EARLY resume
>>> twl 1-0048: EARLY resume
>>> dummy 1-0049: EARLY resume
>>> dummy 1-004a: EARLY resume
>>> dummy 1-004b: EARLY resume
>>> twl4030_gpio twl4030_gpio: EARLY resume
>>> mmci-omap-hs mmci-omap-hs.0: EARLY resume
>>> mmci-omap-hs mmci-omap-hs.1: EARLY resume
>>> twl_reg twl_reg.17: EARLY resume
>>> twl_reg twl_reg.18: EARLY resume
>>> twl_reg twl_reg.19: EARLY resume
>>> twl4030_usb twl4030_usb: EARLY resume
>>> twl_reg twl_reg.6: EARLY resume
>>> i2c i2c-3: EARLY resume
>>> serial8250 serial8250: EARLY resume
>>> PM: early resume of devices complete after 97.625 msecs
>>> i2c_omap i2c_omap.1: resume
>>> i2c_omap i2c_omap.3: resume
>>> platform overo_lcd: resume
>>> serial8250 serial8250.0: resume
>>> serial8250 serial8250.1: resume
>>> serial8250 serial8250.2: resume
>>>
>>> =C5=A8uV=3DV=3D=C3=BD_=E2=80=95h=C3=BE=C5=BE=C3=BE=C5=BE.?=C3=BDR=C5=
=AAHl=C5=8C=C5=8C=C5=AB=C5=A7=C5=AA=3D=C5=AB=3D=E2=80=95=C4=AB=C5=AA=C5=
=8BQ*^=C5=BE=C3=BEQ=C5=AB99:=C5=AB=C5=8C=C5=8C=C3=BDRN=C5=A9=C3=B5t=C5=AA=
=C4=BB=C4=BB:;;T=C5=A7?=C3=89QQ=C2=B7=C4=AB=C3=96=C4=AB=C3=8B\=C5=8Bv=C3=
=A9=C3=9D=C4=B8
>>> (garbage string...)
>> The problem is releated to no_debug_console option.
>>
>> Michael Trimarchi
>>
>>> Thanks,
>>
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

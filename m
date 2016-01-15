From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Fri, 15 Jan 2016 19:11:47 +0100
Message-ID: <E4B697CC-5C53-41A5-BD44-9AD3C9835774@goldelico.com>
References: <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com> <56969800.5010206@ti.com> <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com> <5696A002.6050402@ti.com> <20160113194032.GL12777@atomide.com> <5696D097.3040208@gmail.com> <56977211.8070206@ti.com> <5697DD4C.8010701@ti.com> <20160114183510.GP12777@atomide.com> <D8D33064-B36E-41C9-AA08-353FF8A64367@goldelico.com> <20160115154645.GA3904@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160115154645.GA3904@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Keerthy <a0393675@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Am 15.01.2016 um 16:47 schrieb Tony Lindgren <tony@atomide.com>:

> * H. Nikolaus Schaller <hns@goldelico.com> [160115 06:34]:
>> Am 14.01.2016 um 19:35 schrieb Tony Lindgren <tony@atomide.com>:
>>> updated patch, please retest that hwclock -w works properly with
>>> the RTC patch in this thread.
>> 
>> I tried and it works.
>> 
>> But then I found that you did set MUX_MODE7. Which is safe-mode.
> 
> Oops, that's a typo, sorry!
> 
>> And in safe-mode the gpio8_234/msecure ball should be "L".
>> 
>> Then I experimented a little and it appears that you can remove
>> the gpio-hog entry:
>> 
>> root@letux:~# devmem2 0x4A002980
>> /dev/mem opened.
>> Memory mapped at address 0xb6f48000.
>> Value at address 0x4A002980 (0xb6f48980): 0x1080006
>> root@letux:~# hwclock
>> Fri Jan 15 13:32:52 2016  -0.726651 seconds
>> root@letux:~# 
>> 
>> Or even mux the gpio to PIN_INPUT_PULLDOWN | MUX_MODE6:
> 
> Hmm interesting. Have to test here too. FYI, it might be also worth
> draining the back-up battery with a small resistor while testing
> to make sure there's no initial state in the PMIC.
> 
>> root@letux:~# devmem2 0x4A002980
>> /dev/mem opened.
>> Memory mapped at address 0xb6f35000.
>> Value at address 0x4A002980 (0xb6f35980): 0x108010E
>> root@letux:~# hwclock
>> Fri Jan 15 14:30:05 2016  -1.155714 seconds
>> root@letux:~# 
>> 
>> So I now wonder if the twl6037 variant on the OMAP5432EVM really has
>> the gpio7 enabled as msecure input (there is some mention of OTP variants
>> in the Palmas docs I have, but I don't have the one of the exact chip variant used
>> on the EVM).
>> 
>> If it were disabled by OTP (and then I assume it is automatically write-unprotected),
>> then we would simply have a useless connection from gpio8_234 to Palmas...
>> 
>> So the outcome might depend on the Palmas chip version that is used on any
>> board that includes the omap5-board-common.dtsi.
> 
> Could be different version yeah.
> 
>> And the main difference between hwclock not-working and working on the omap5evm
>> should be the nirq1 part of your patch!
> 
> OK so best to go back to square one with the testing with just the nirq1
> change.
> 
>> Please can someone else confirm that hwclock works without any init for
>> the msecure line and that I did not have a false positive by some other reason?
> 
> Just to be sure.. Have you tested with hwclock -w and made sure it
> changes the time? Otherwise you may have started the RTC with some
> earlier kernel and it still keeps on ticking so the read test is
> not enough.

You were right (and I as well to doubt my first results). And I also didn't
take ntpd in account.

Now:

root@letux:~# hwclock
Fri Jan 15 16:53:19 2016  -0.699173 seconds
root@letux:~# hwclock --set --date="2011-08-14 16:45:05"
root@letux:~# hwclock
Fri Jan 15 16:54:08 2016  -0.451544 seconds
root@letux:~# devmem2 0x4A002980 w 0x108010E
/dev/mem opened.
Memory mapped at address 0xb6f58000.
Value at address 0x4A002980 (0xb6f58980): 0x108010E
Written 0x108010E; readback 0x108010E
root@letux:~# hwclock --set --date="2011-08-14 16:45:05"
root@letux:~# hwclock
Fri Jan 15 16:55:18 2016  -0.555951 seconds
root@letux:~# devmem2 0x4A002980 w 0x108011E
/dev/mem opened.
Memory mapped at address 0xb6f7e000.
Value at address 0x4A002980 (0xb6f7e980): 0x108010E
Written 0x108011E; readback 0x108011E
root@letux:~# hwclock --set --date="2011-08-14 16:45:05"
root@letux:~# hwclock
Sun Aug 14 16:45:10 2011  -0.813317 seconds
root@letux:~# ^C
root@letux:~# 

So the pull-up in gpin-mode6 must be enable to *write* the RTC, i.e.
the msecure pin must indeed be pulled up (or hogged to "1").

It also works with gpio-hog + PIN_OUTPUT | MUX_MODE6.

This means:
* nirq1 is needed so that we don't have the timeout (on read/write)
* gpio-hog is needed on MODE6 or MODE0 to be able to really write (and not be silently ignored)

Thanks and BR,
Nikolaus

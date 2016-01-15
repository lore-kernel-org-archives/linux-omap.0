From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and
 charging of backup battery
Date: Fri, 15 Jan 2016 07:47:14 -0800
Message-ID: <20160115154645.GA3904@atomide.com>
References: <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com>
 <56969800.5010206@ti.com>
 <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com>
 <5696A002.6050402@ti.com>
 <20160113194032.GL12777@atomide.com>
 <5696D097.3040208@gmail.com>
 <56977211.8070206@ti.com>
 <5697DD4C.8010701@ti.com>
 <20160114183510.GP12777@atomide.com>
 <D8D33064-B36E-41C9-AA08-353FF8A64367@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <D8D33064-B36E-41C9-AA08-353FF8A64367@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Nishanth Menon <nm@ti.com>, Keerthy <a0393675@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [160115 06:34]:
> Am 14.01.2016 um 19:35 schrieb Tony Lindgren <tony@atomide.com>:
> > updated patch, please retest that hwclock -w works properly with
> > the RTC patch in this thread.
> 
> I tried and it works.
> 
> But then I found that you did set MUX_MODE7. Which is safe-mode.

Oops, that's a typo, sorry!

> And in safe-mode the gpio8_234/msecure ball should be "L".
> 
> Then I experimented a little and it appears that you can remove
> the gpio-hog entry:
> 
> root@letux:~# devmem2 0x4A002980
> /dev/mem opened.
> Memory mapped at address 0xb6f48000.
> Value at address 0x4A002980 (0xb6f48980): 0x1080006
> root@letux:~# hwclock
> Fri Jan 15 13:32:52 2016  -0.726651 seconds
> root@letux:~# 
> 
> Or even mux the gpio to PIN_INPUT_PULLDOWN | MUX_MODE6:

Hmm interesting. Have to test here too. FYI, it might be also worth
draining the back-up battery with a small resistor while testing
to make sure there's no initial state in the PMIC.

> root@letux:~# devmem2 0x4A002980
> /dev/mem opened.
> Memory mapped at address 0xb6f35000.
> Value at address 0x4A002980 (0xb6f35980): 0x108010E
> root@letux:~# hwclock
> Fri Jan 15 14:30:05 2016  -1.155714 seconds
> root@letux:~# 
> 
> So I now wonder if the twl6037 variant on the OMAP5432EVM really has
> the gpio7 enabled as msecure input (there is some mention of OTP variants
> in the Palmas docs I have, but I don't have the one of the exact chip variant used
> on the EVM).
>
> If it were disabled by OTP (and then I assume it is automatically write-unprotected),
> then we would simply have a useless connection from gpio8_234 to Palmas...
> 
> So the outcome might depend on the Palmas chip version that is used on any
> board that includes the omap5-board-common.dtsi.

Could be different version yeah.

> And the main difference between hwclock not-working and working on the omap5evm
> should be the nirq1 part of your patch!

OK so best to go back to square one with the testing with just the nirq1
change.

> Please can someone else confirm that hwclock works without any init for
> the msecure line and that I did not have a false positive by some other reason?

Just to be sure.. Have you tested with hwclock -w and made sure it
changes the time? Otherwise you may have started the RTC with some
earlier kernel and it still keeps on ticking so the read test is
not enough.

Regards,

Tony

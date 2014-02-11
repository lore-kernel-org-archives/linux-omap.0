From: Kevin Hilman <khilman@linaro.org>
Subject: Re: regression(ti platforms): next-20140210 (ehci?)
Date: Mon, 10 Feb 2014 17:07:02 -0800
Message-ID: <7h38jq8nk9.fsf@paris.lan>
References: <52F8F77B.70605@ti.com> <52F9117C.8000405@ti.com>
	<7h61omakk9.fsf@paris.lan> <52F9297A.1080206@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <52F9297A.1080206@ti.com> (Nishanth Menon's message of "Mon, 10
	Feb 2014 13:33:14 -0600")
Sender: linux-next-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-usb@vger.kernel.org, "Balbi, Felipe" <balbi@ti.com>, linux-next@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> On 02/10/2014 12:28 PM, Kevin Hilman wrote:
>> Roger Quadros <rogerq@ti.com> writes:
>> 
>>> +devicetree
>>>
>>> On 02/10/2014 05:59 PM, Nishanth Menon wrote:
>>>> Hi,
>>>>
>>>> A quick note to report that I saw regression in today's next tag (logs
>>>> indicate around EHCI) boot on various TI platforms:
>>>>
>>>> Note: crane and sdp2430 are not expected to pass with
>>>> multi_v7_defconfig (note: omap2plus_defconfig boot seems to be sane
>>>> but USB is disabled there)
>>>>
>>>> next-20140210-multi_v7_defconfig
>>>>  1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2zYHdPb94
>>>>  2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s2UChLyzSE
>>>>  3: am3517-evm:  Boot FAIL: http://slexy.org/raw/s20Br9XLO1
>>>> around ehci
>>>>
>>>>  4:  am37x-evm:  Boot FAIL: http://slexy.org/raw/s20mVz9Wc7
>>>> around ehci
>>>>
>>>>  5: am43xx-epos:  Boot PASS: http://slexy.org/raw/s2byveBYtT
>>>>  6: BeagleBoard-XM:  Boot FAIL: http://slexy.org/raw/s21sOgJNwK
>>>> around ehci
>>>>
>>>>  7: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2ovVNAmO7
>>>>  8:      crane: No Image built - Missing platform support?:
>>>>  9:       dra7:  Boot PASS: http://slexy.org/raw/s217qwaXsM
>>>> 10:        ldp:  Boot FAIL: http://slexy.org/raw/s203IvjE23
>>>> around ehci
>>>>
>>>> 11: PandaBoard-ES:  Boot FAIL: http://slexy.org/raw/s2NvkRx2YJ
>>>> around ehci
>>>
>>> I think the problem is that ehci-platform driver gets loaded instead of ehci-omap.
>>>
>>> In the DT node we have compatible ids for both. e.g. for omap4.dtsi
>>>
>>>                         usbhsehci: ehci@4a064c00 {
>>>                                 compatible = "ti,ehci-omap", "usb-ehci";
>>>                                 reg = <0x4a064c00 0x400>;
>>>                                 interrupt-parent = <&gic>;
>>>                                 interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>>>                         };
>>>
>>> Shouldn't ehci-omap driver be getting a higher priority than usb-ehci?
>>>
>>> A quick fix would be to eliminate "usb-ehci" from the DT node of all failing platforms.
>> 
>> I can confirm that simply remvoing usb-ehci from omap[34].dtsi nodes
>> fixed the problem for me on 3530/overo, 3730/beagle-xM and
>> 4460/panda-es.  But I don't think that's the right fix.  First we have
>> to figure out why ehci-omap stopped getting loaded first.
>
> Wont that depend on driver probe order? of_match_device is fairly
> simple compatible walk through without looking at other drivers which
> might also be compatible, but not yet probed?
>
> The issue started I think with the following patch getting merged:
> ehci-platform: Add support for clks and phy passed through devicetree
> some version of http://www.spinics.net/lists/linux-usb/msg101061.html
> introduced { .compatible = "usb-ehci", },

This is what I was getting at: an understanding of what caused the
failue in the first place.

> Now, in the build we have two drivers which dts claims compatibility
> with, but only 1 driver actually works (drivers/usb/host/ehci-omap.c)
> for the platform. Thinking that way, in fact, the current
> compatibility even matches drivers/usb/host/ehci-ppc-of.c which
> obviously wont work either.

Right, so I agree that it makes sense to remove a compatible string
where there is no compatability, but a couple other things should happen
here.

1) changelog should describe why this compatible string is in the omap
dtsi files in first place.

2) investigation into the patch that introduced this change to double
check it's not introducing other breakage as well.

Kevin

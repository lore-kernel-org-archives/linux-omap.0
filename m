From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Mon, 1 Dec 2014 08:57:14 +0100
Message-ID: <CAGm1_ku4UYL0DX9DuSJWn9-QKhcq+mUKyVTA433F6XbRe2FnHg@mail.gmail.com>
References: <CAFqH_53hyYO9DHfhzDhYkTnimKR0FOQuUw4OGCM4myKoOJSQRA@mail.gmail.com>
 <20141117180413.GF7046@atomide.com> <CAFqH_52LV8k6OyH04dUmhzZChnHrtJR23qu1ewhU49iOVT1Mwg@mail.gmail.com>
 <20141118154204.GI7046@atomide.com> <CAFqH_508pYkDXO8BCR=cFGFY_CgfkhqvseUy=Z--fJMOQCo6Tg@mail.gmail.com>
 <20141119175348.GK7046@atomide.com> <CAGm1_kvZnkB4MWPv3ExCqibb0Rq4xXfkPHHpfDb9HOTFNf7BiA@mail.gmail.com>
 <20141129153521.GB14924@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57674 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbaLAH5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2014 02:57:36 -0500
In-Reply-To: <20141129153521.GB14924@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Nov 29, 2014 at 4:35 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Fri, Nov 28, 2014 at 11:35:53AM +0100, Yegor Yefremov wrote:
>> On Wed, Nov 19, 2014 at 6:53 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Enric Balletbo Serra <eballetbo@gmail.com> [141119 03:14]:
>> >> 2014-11-18 16:42 GMT+01:00 Tony Lindgren <tony@atomide.com>:
>> >>
>> >> Checked again, and no luck. It's very weird because from the OTG point
>> >> of view, OTG is exactly the same between Beagleboard-XM and IGEPv2.
>> >>
>> >> Can you confirm that you're using kernel 3.18-rc5 without other
>> >> patches applied ? At this moment, I don't have a Beagleboard-XM to
>> >> test, I'll try to get one because at this moment I'm a bit stuck with
>> >> this problem.
>> >
>> > Yes it was with v3.18-rc5 and the defconfig patch I posted except
>> > I had to disable all the other MUSB platforms. Also tested it with
>> > built in modules.
>> >
>> > Maybe you need to check the .dts pinctrl entries for hsusb0_* lines?
>>
>> Just my 2 cents, My am335x based board shows similar symptoms
>> (CONFIG_USB_MUSB_DUAL_ROLE enabled). Only if I specify  dr_mode =
>> "host"; in my DTS I get device enumerated. 3.15, that I had before
>> made no problems as OTG.
>
> Are you sure your ID pin is properly routed ? If you set dr_mode to otg,
> then you *must* have a properly routed ID pin and use a proper
> micro-/mini-ab receptacle. That's not true for e.g. beagle bone black.
>
> One USB port is using a Standard-A while the other uses mini-B. You
> can't do any role swapping with those.

Yes, I'm sure, that ID pin is routed properly. It is also not BBB, but
real device Baltos iR 5221
(http://visionsystems.de/produkte/baltos-ir-5221.html). With 3.15 I'm
able to use OTG port both as device and host. I boot the device,
insert FTDI based hardware into OTG port and my ttyUSBx devices, then
disconnect and connect to PC and I get usb0 network interface and can
communicate with PC.

Yegor

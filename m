From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 4/9] ARM: dts: OMAP3: Add support for OMAP3430 SDP board
Date: Tue, 12 Mar 2013 09:50:48 +0100
Message-ID: <CABxcv=npsMrbVqJ0G_Lr3qDVKZ=N5Micd4rmadJP_Egi3hKwiA@mail.gmail.com>
References: <1362763654-9660-1-git-send-email-jon-hunter@ti.com>
	<1362763654-9660-5-git-send-email-jon-hunter@ti.com>
	<CABYxbz7Bg3Uf2wkhH=4d6nEPUjyHF8BiixN6rGCOgEVG_us8Jw@mail.gmail.com>
	<513E1A1C.8070206@ti.com>
	<F3DBB1B3EF102E4994C89758CFCA32412CE371@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43987 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608Ab3CLIuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 04:50:50 -0400
Received: by mail-wi0-f172.google.com with SMTP id ez12so1600480wid.17
        for <linux-omap@vger.kernel.org>; Tue, 12 Mar 2013 01:50:49 -0700 (PDT)
In-Reply-To: <F3DBB1B3EF102E4994C89758CFCA32412CE371@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kumar, Anil" <anilkumar.v@ti.com>
Cc: "Hunter, Jon" <jon-hunter@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Anil Kumar <anilk4.v@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Mar 12, 2013 at 3:42 AM, Kumar, Anil <anilkumar.v@ti.com> wrote:
>
> On Mon, Mar 11, 2013 at 23:23:32, Hunter, Jon wrote:
>>
>> On 03/08/2013 08:25 PM, Anil Kumar wrote:
>> > Hi Jon,
>> >
>> > On Fri, Mar 8, 2013 at 10:57 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>> >> Adds basic device-tree support for OMAP3430 SDP board which has 256MB
>> >> of RAM and uses the TWL4030 power management IC.
>> >
>> > I think this board support should be in separate patch series with
>> > related patches.
>>
>> Well I wanted to keep them altogether so that I can send a pull request
>> to Benoit and Tony.
>
> Sorry, but can you please tell what makes you to think that you
> can send pull request only when they are altogether ?
>
> Is there any logical dependency with other patches except
> "[PATCH 6/9] ARM: dts: Add OMAP3430 SDP flash memory bindings" is on
> top of this patch ?
>
>>
>> >>
>> >> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> >> ---
>> >>  arch/arm/boot/dts/Makefile         |    1 +
>> >>  arch/arm/boot/dts/omap3430-sdp.dts |   46 ++++++++++++++++++++++++++++++++++++
>> >>  2 files changed, 47 insertions(+)
>> >>  create mode 100644 arch/arm/boot/dts/omap3430-sdp.dts
>> >>
>> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> >> index 9c62558..89013ed 100644
>> >> --- a/arch/arm/boot/dts/Makefile
>> >> +++ b/arch/arm/boot/dts/Makefile
>> >> @@ -119,6 +119,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>> >>         omap3-beagle-xm.dtb \
>> >>         omap3-evm.dtb \
>> >>         omap3-tobi.dtb \
>> >> +       omap3430-sdp.dtb \
>> >>         omap4-panda.dtb \
>> >>         omap4-panda-a4.dtb \
>> >>         omap4-panda-es.dtb \
>> >> diff --git a/arch/arm/boot/dts/omap3430-sdp.dts b/arch/arm/boot/dts/omap3430-sdp.dts
>> >> new file mode 100644
>> >> index 0000000..be0650d
>> >> --- /dev/null
>> >> +++ b/arch/arm/boot/dts/omap3430-sdp.dts
>> >> @@ -0,0 +1,46 @@
>> >> +/*
>> >> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
>> >> + *
>> >> + * This program is free software; you can redistribute it and/or modify
>> >> + * it under the terms of the GNU General Public License version 2 as
>> >> + * published by the Free Software Foundation.
>> >> + */
>> >> +/dts-v1/;
>> >> +
>> >> +/include/ "omap3.dtsi"
>> >> +
>> >> +/ {
>> >> +       model = "TI OMAP3430 SDP";
>> >> +       compatible = "ti,omap3430-sdp", "ti,omap3";
>> >
>> > I have not seen any related changes in "board-generic.c" for your board.
>> > So just wanted know, how this board is booting ?
>>
>> If you look at board-generic.c you will see that "ti,omap3" will match
>> the OMAP3 generic machine. So you don't need to modify the board-generic.c.
>
> According to this omap3-beagle.dts and omap3-beagle-xm.dts are also
> booting in some way. So it is not clear to me, why there two
> "DT_MACHINE_START" for omap3. I have seen there is only one
> different in "init_time" for the same.
>

Hi Anil,

You may take a look to commit:

7dd9d50 ARM: OMAP3: Add generic machine descriptor for boards with
OMAP3 GP device

So, the second DT_MACHINE_START is meant to be used by OMAP3 boards
which use GP devices and this is not the case for "ti,omap3430-sdp"
afaiu.

I wonder if instead of adding each OMAP3 board with GP devices such as
"ti,omap3-beagle", is not better to have a "ti,omap3-gp" compatible
property.

The whole point of DT is to decouple the hardware description from the
kernel code so in general we should use the more generic compatible
string ("ti,omap3") unless the hardware has some specifics that have
to be addressed, such as these boards that use GP devices.

>>
>> >> +
>> >> +       memory {
>> >> +               device_type = "memory";
>> >> +               reg = <0x80000000 0x10000000>; /* 256 MB */
>> >> +       };
>> >> +};
>> >> +
>> >> +&i2c1 {
>> >> +       clock-frequency = <2600000>;
>> >> +
>> >> +       twl: twl@48 {
>> >> +               reg = <0x48>;
>> >> +               interrupts = <7>; /* SYS_NIRQ cascaded to intc */
>> >> +               interrupt-parent = <&intc>;
>> >> +       };
>> >> +};
>> >> +
>> >> +/include/ "twl4030.dtsi"
>> >> +
>> >> +&mmc1 {
>> >> +       vmmc-supply = <&vmmc1>;
>> >> +       vmmc_aux-supply = <&vsim>;
>> >> +       bus-width = <8>;
>> >> +};
>> >> +
>> >> +&mmc2 {
>> >> +       status = "disabled";
>> >> +};
>> >> +
>> >> +&mmc3 {
>> >> +       status = "disabled";
>> >> +};
>> >
>> > I think you should disable modules those are not currently used
>> > as they are enabled by default in omap3.dtsi.
>> >
>> > exp:-
>> >
>> > &mcbsp2 {
>> >         status = "disabled";
>> > };
>>
>> Well may be we could do that in a follow-up patch. If you look at other
>> omap3 boards we have not gone through and disabled all unused modules
>> either. So although I agree, right now I just want to get minimal
>> support added.
>>
>
> Hmm... But it makes the kernel to call unused driver probe and get failed
> those required some platform date from DT? you can see the kernel boot logs.
>
> Thanks,
> Anil
>
>

Best regards,
Javier

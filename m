From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 19 May 2014 13:39:44 -0500
Message-ID: <CAOCHtYjAJB3xSYrq3P+R2qyLHEbMQ5LMpu=hs4rwjXSqXb-kKw@mail.gmail.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
	<1400490948-11571-2-git-send-email-pekon@ti.com>
	<20140519162532.GF4849@atomide.com>
	<20980858CB6D3A4BAE95CA194937D5E73EACE21E@DBDE04.ent.ti.com>
	<20140519181640.GA6957@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:64442 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaESSjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 14:39:45 -0400
Received: by mail-yh0-f47.google.com with SMTP id z6so7131682yhz.20
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2014 11:39:44 -0700 (PDT)
In-Reply-To: <20140519181640.GA6957@arch.cereza>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>, Jason Kridner <jdk@ti.com>

On Mon, May 19, 2014 at 1:16 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> On 19 May 05:52 PM, Gupta, Pekon wrote:
>> Hi Tony,
>>
>> >From: Tony Lindgren [mailto:tony@atomide.com]
>> >
>> >* Pekon Gupta <pekon@ti.com> [140519 02:16]:
>> >> --- a/arch/arm/boot/dts/am335x-bone.dts
>> >> +++ b/arch/arm/boot/dts/am335x-bone.dts
>> >> @@ -9,6 +9,7 @@
>> >>
>> >>  #include "am33xx.dtsi"
>> >>  #include "am335x-bone-common.dtsi"
>> >> +#include "am335x-bone-memory-cape.dts"
>> >>
>> >>  &ldo3_reg {
>> >>    regulator-min-microvolt = <1800000>;
>> >> --- a/arch/arm/boot/dts/am335x-boneblack.dts
>> >> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
>> >> @@ -9,6 +9,7 @@
>> >>
>> >>  #include "am33xx.dtsi"
>> >>  #include "am335x-bone-common.dtsi"
>> >> +#include "am335x-bone-memory-cape.dts"
>> >>
>> >>  &ldo3_reg {
>> >>    regulator-min-microvolt = <1800000>;
>> >
>> >Based on the recent discussions on the capes, it seems that nobody
>> >wants to implement toggling of the capes in u-boot. And as there
>> >can be other capes using GPMC bus, we can't merge this. And because
>> >the capes are stackable, we can't really have .dts files for all
>> >the combinations. And no, we're not merging any unconnected .dts
>> >files either, sorry.
>> >
>> Yes, I fully understand. This is like death for most of the capes from point
>> of view of mainline support. But I have submitted this patch just for sake
>> of completion. And to provide reference if someone wants to locally work
>> on beaglebone NAND cape.
>
> While I fully agree with Tony on this, I think the reference is much
> appreciated. Do you think you can push the NAND cape DT example somewhere?
>
> Maybe some TI wiki page?

(resent in text mode for linux-omap list archive)

Since the capes are always some way tied with bb.org hardware, why
don't we put them up on https://github.com/beagleboard/ ?

am335x-capes.git ?

I envision, we should just mirror the base ./arch/arm/boot/dts/
directory (as someday the dts will be external anyways). In that repo,
we will keep these synced with mainline

am335x-bone-common.dtsi
am335x-bone.dts
am335x-boneblack.dts

and add the capes as:

<baseboard>-<cape>.dts

as a staging ground till a mainline overlay/etc system appears?

Thoughs?

-- 
Robert Nelson
http://www.rcn-ee.com/

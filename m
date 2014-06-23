From: Jason Kridner <jkridner@gmail.com>
Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 23 Jun 2014 02:13:15 -0400
Message-ID: <CA+T6QPnfzPJXs4NftLoVZBHXXvUO=-_XMvTazxj+8HF41_UJ+g@mail.gmail.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
	<1400490948-11571-2-git-send-email-pekon@ti.com>
	<20140519162532.GF4849@atomide.com>
	<20980858CB6D3A4BAE95CA194937D5E73EAF6A7C@DBDE04.ent.ti.com>
	<20140623054838.GB28884@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:41054 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbaFWGNQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2014 02:13:16 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so9640702oag.35
        for <linux-omap@vger.kernel.org>; Sun, 22 Jun 2014 23:13:15 -0700 (PDT)
In-Reply-To: <20140623054838.GB28884@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>, "Robert Nelson (robertcnelson@gmail.com)" <robertcnelson@gmail.com>

On Mon, Jun 23, 2014 at 1:48 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Gupta, Pekon <pekon@ti.com> [140622 22:42]:
>> Hi Tony,
>>
>> Just reviving this thread for some information..
>>
>> >From: Tony Lindgren [mailto:tony@atomide.com]
>> >Sent: Monday, May 19, 2014 9:56 PM
>> >To: Gupta, Pekon
>> >Cc: linux-omap; Ezequiel Garcia; Stefan Roese; Javier Martinez Canillas; Quadros, Roger
>> >Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone NAND cape
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
>> >can be other capes using GPMC bus, we can't merge this.
>>
>> I have been able to get toggling of capes (enabling and disabling of DT nodes)
>> in u-boot. It was already there in u-boot mainline [1], may be no-body tried it.
>>
>> Example: Below sequence works for NAND cape patch mentioned in this thread.
>> ---------------
>> /* load DTB */
>> u-boot> tftp 0x81000000 am335x-boneblack.dtb
>> u-boot> fdt addr 0x81000000
>> /* disable MMC2 node */
>> u-boot> fdt list /ocp/mmc@481d8000
>> u-boot> fdt set  /ocp/mmc@481d8000 status \d\i\s\a\b\l\e\d
>> u-boot> fdt list /ocp/mmc@481d8000 status
>> /* enable GPMC node */
>> u-boot> fdt list /ocp/gpmc
>> u-boot> fdt set  /ocp/gpmc status \o\k\a\y
>> u-boot> fdt list /ocp/gpmc status
>> /* enable ELM node */
>> u-boot> fdt list /ocp/elm
>> u-boot> fdt set  /ocp/elm status \o\k\a\y
>> u-boot> fdt list /ocp/elm status
>> /* boot uImage */
>> tftp 0x82000000 uImage
>> bootm 0x82000000 - 0x81000000
>>
>> Note: "fdt set" command does not accept string literals
>> as binding values, it internally converts them to string, so
>> escape sequenced characters were used here..
>> "okay" == \o\k\a\y
>> "disabled" == \d\i\s\a\b\l\e\d"
>
> Cool. Now all we need is a few helper functions in u-boot
> so it can be done a bit easier :)
>

The association of devicetree overlay files in /lib/firmware to cape
IDs made it where the kernel-based cape overlay manager could modify
the devicetree as needed without putting extensive cape-specific logic
in the kernel or bootloader. Throwing a bunch of capes into a single
class of capes won't save any work there. If we can get the bootloader
to support the .dtbo files, then we can continue to use the ID in the
cape to provide all the DT modifications we need. If we need to do
scripts for the modifications, we'd still need to associate the cape
ID to that script.

This still doesn't cover the need for run-time devicetree
modification, but I'll leave that for the other on-going thread.

I do agree with the idea of moving more of the potential sources of
conflict that can be resolved out of the overlays and into the main
devicetree, leaving the overlays or scripts simply to deal with the
conflicts that cannot be resolved at run-time given the current
infrastructure. I just think they should go into .dtsi (include) files
for the main .dts/.dtb files for the boards, rather than additional
overlays or alternative .dts files.

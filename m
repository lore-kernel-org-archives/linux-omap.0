From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Mon, 23 Jun 2014 05:40:34 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAF6A7C@DBDE04.ent.ti.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-2-git-send-email-pekon@ti.com>
 <20140519162532.GF4849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38539 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbaFWFks convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jun 2014 01:40:48 -0400
In-Reply-To: <20140519162532.GF4849@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>, "Jason Kridner (jkridner@gmail.com)" <jkridner@gmail.com>, "Robert Nelson (robertcnelson@gmail.com)" <robertcnelson@gmail.com>

Hi Tony,

Just reviving this thread for some information..

>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Monday, May 19, 2014 9:56 PM
>To: Gupta, Pekon
>Cc: linux-omap; Ezequiel Garcia; Stefan Roese; Javier Martinez Canillas; Quadros, Roger
>Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone NAND cape
>
>* Pekon Gupta <pekon@ti.com> [140519 02:16]:
>> --- a/arch/arm/boot/dts/am335x-bone.dts
>> +++ b/arch/arm/boot/dts/am335x-bone.dts
>> @@ -9,6 +9,7 @@
>>
>>  #include "am33xx.dtsi"
>>  #include "am335x-bone-common.dtsi"
>> +#include "am335x-bone-memory-cape.dts"
>>
>>  &ldo3_reg {
>>  	regulator-min-microvolt = <1800000>;
>> --- a/arch/arm/boot/dts/am335x-boneblack.dts
>> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
>> @@ -9,6 +9,7 @@
>>
>>  #include "am33xx.dtsi"
>>  #include "am335x-bone-common.dtsi"
>> +#include "am335x-bone-memory-cape.dts"
>>
>>  &ldo3_reg {
>>  	regulator-min-microvolt = <1800000>;
>
>Based on the recent discussions on the capes, it seems that nobody
>wants to implement toggling of the capes in u-boot. And as there
>can be other capes using GPMC bus, we can't merge this.

I have been able to get toggling of capes (enabling and disabling of DT nodes)
in u-boot. It was already there in u-boot mainline [1], may be no-body tried it.

Example: Below sequence works for NAND cape patch mentioned in this thread.
---------------
/* load DTB */
u-boot> tftp 0x81000000 am335x-boneblack.dtb
u-boot> fdt addr 0x81000000
/* disable MMC2 node */
u-boot> fdt list /ocp/mmc@481d8000
u-boot> fdt set  /ocp/mmc@481d8000 status \d\i\s\a\b\l\e\d
u-boot> fdt list /ocp/mmc@481d8000 status
/* enable GPMC node */
u-boot> fdt list /ocp/gpmc
u-boot> fdt set  /ocp/gpmc status \o\k\a\y
u-boot> fdt list /ocp/gpmc status
/* enable ELM node */
u-boot> fdt list /ocp/elm
u-boot> fdt set  /ocp/elm status \o\k\a\y
u-boot> fdt list /ocp/elm status
/* boot uImage */
tftp 0x82000000 uImage
bootm 0x82000000 - 0x81000000

Note: "fdt set" command does not accept string literals
as binding values, it internally converts them to string, so
escape sequenced characters were used here..
"okay" == \o\k\a\y
"disabled" == \d\i\s\a\b\l\e\d"
---------------


> And because
>the capes are stackable, we can't really have .dts files for all
>the combinations. And no, we're not merging any unconnected .dts
>files either, sorry.
>
As per earlier proposal, we can have single DT files for similar
functionality capes like;
- am335x-bone-memory-cape.dts: for all Flash/Memory related capes like NAND, NOR, eMMC, etc.
- am335x-bone-display-cape.dts: for all display related capes like LCD4, LCD7..
This way you will have countable number of DTS files to maintain
And any conflict if ever in between capes can be contained within these files.

Does this suffice the requirement to accept cape DTS in mainline 
(with default state as disabled) ?

I'm re-invoking this thread because there are quite a number of
hobbyist and developers stuck without proper DT support of these
capes, so having them in mainline is better than providing a internal
or separately maintained tree.

>Regards,
>
>Tony

with regards, pekon

[1] http://www.denx.de/wiki/view/DULG/UBootCmdFDT

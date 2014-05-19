From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Mon, 19 May 2014 17:52:56 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EACE21E@DBDE04.ent.ti.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-2-git-send-email-pekon@ti.com>
 <20140519162532.GF4849@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52541 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbaESRxL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 13:53:11 -0400
In-Reply-To: <20140519162532.GF4849@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, "Quadros, Roger" <rogerq@ti.com>

Hi Tony,

>From: Tony Lindgren [mailto:tony@atomide.com]
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
>can be other capes using GPMC bus, we can't merge this. And because
>the capes are stackable, we can't really have .dts files for all
>the combinations. And no, we're not merging any unconnected .dts
>files either, sorry.
>
Yes, I fully understand. This is like death for most of the capes from point
of view of mainline support. But I have submitted this patch just for sake
of completion. And to provide reference if someone wants to locally work
on beaglebone NAND cape.
You may ignore this patch, and take the remaining ones if they are suitable.

with regards, pekon

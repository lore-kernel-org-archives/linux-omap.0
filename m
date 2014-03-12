From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Wed, 12 Mar 2014 18:26:57 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAB2CF1@DBDE04.ent.ti.com>
References: <1394621360-2457-1-git-send-email-pekon@ti.com>
 <1394621360-2457-2-git-send-email-pekon@ti.com> <532070C8.1030903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47621 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755143AbaCLS12 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 14:27:28 -0400
In-Reply-To: <532070C8.1030903@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>

Hi,

>From: Menon, Nishanth
>>On 03/12/2014 05:49 AM, Pekon Gupta wrote:
>> Beaglebone Board can be connected to expansion boards to add devices to them.
>> These expansion boards are called 'capes'. This patch adds support for
>> following versions of Beaglebone(AM335x) NAND capes
>> (a) NAND Device with bus-width=16, block-size=128k, page-size=2k, oob-size=64
>> (b) NAND Device with bus-width=16, block-size=256k, page-size=4k, oob-size=224
>> Further information and datasheets can be found at [1] and [2]
[...]
>> [1] http://beagleboardtoys.info/index.php?title=BeagleBone_Memory_Expansion
>> [2] http://beagleboardtoys.info/index.php?title=BeagleBone_4Gb_16-Bit_NAND_Module
>>
>> Signed-off-by: Pekon Gupta <pekon@ti.com>
>> ---
>>  arch/arm/boot/dts/am335x-bone.dts | 123 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 123 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
>> index 94ee427..be2c572 100644
>> --- a/arch/arm/boot/dts/am335x-bone.dts
>> +++ b/arch/arm/boot/dts/am335x-bone.dts
>
>better to make a nand_cape dts which includes the am335x-bone.dts?
>
Actually, I'm not in favor of having too many "xx_board_common.dts" files,
because it un-necessarily complexes things.

We already have "arch/arm/boot/dts/am335x-bone-common.dtsi" which just saves
some lines common to DTS of both Beaglebone-LT(white) and Beaglebone-Black.
And, there is no guarantee that Beaglebone-LT(white) will remain compatible to
Beaglebone-black in future. 
Example: some capes are not compatible to beaglebone-black [1], [2].

So, I prefer to keep separate GPMC NAND nodes separately in both DTS,
unless there is a strong convincing reason otherwise.


[1] http://elinux.org/CircuitCo:BeagleBoardToys
[2] http://elinux.org/BeagleBone_Black_Capes

with regards, pekon

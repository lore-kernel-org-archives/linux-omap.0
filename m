From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for
 beaglebone NAND cape
Date: Wed, 12 Mar 2014 21:13:40 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAB2E95@DBDE04.ent.ti.com>
References: <1394621360-2457-1-git-send-email-pekon@ti.com>
 <1394621360-2457-2-git-send-email-pekon@ti.com> <532070C8.1030903@ti.com>
 <20980858CB6D3A4BAE95CA194937D5E73EAB2CF1@DBDE04.ent.ti.com>
 <CAGo_u6rvUqa-7afTFzBahDJuyVkXAj5J2LL8tQRjZuf8_xWXWA@mail.gmail.com>
 <CAOCHtYhqZoCF13e1YjBiWPufDEmVotL3chO9ZUtivWbVTWVfiQ@mail.gmail.com>
 <20140312192850.GF1996@atomide.com> <5320C8B5.601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56104 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbaCLVOi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 17:14:38 -0400
In-Reply-To: <5320C8B5.601@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>



>-----Original Message-----
>From: Menon, Nishanth
>Sent: Thursday, March 13, 2014 2:21 AM
>To: Tony Lindgren; Robert Nelson
>Cc: Gupta, Pekon; bcousson@baylibre.com; linux-omap; linux-mtd
>Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone NAND cape
>
>On 03/12/2014 02:28 PM, Tony Lindgren wrote:
>> * Robert Nelson <robertcnelson@gmail.com> [140312 12:11]:
>>> On Wed, Mar 12, 2014 at 1:57 PM, Nishanth Menon <nm@ti.com> wrote:
>>>> On Wed, Mar 12, 2014 at 1:26 PM, Gupta, Pekon <pekon@ti.com> wrote:
>>>>> Hi,
>>>>>
>>>>>> From: Menon, Nishanth
>>>>>>> On 03/12/2014 05:49 AM, Pekon Gupta wrote:
>>>>>>> Beaglebone Board can be connected to expansion boards to add devices to them.
>>>>>>> These expansion boards are called 'capes'. This patch adds support for
>>>>>>> following versions of Beaglebone(AM335x) NAND capes
>>>>>>> (a) NAND Device with bus-width=16, block-size=128k, page-size=2k, oob-size=64
>>>>>>> (b) NAND Device with bus-width=16, block-size=256k, page-size=4k, oob-size=224
>>>>>>> Further information and datasheets can be found at [1] and [2]
>>>>> [...]
>>>>>>> [1] http://beagleboardtoys.info/index.php?title=BeagleBone_Memory_Expansion
>>>>>>> [2] http://beagleboardtoys.info/index.php?title=BeagleBone_4Gb_16-Bit_NAND_Module
>>>>>>>
>>>>>>> Signed-off-by: Pekon Gupta <pekon@ti.com>
>>>>>>> ---
>>>>>>>  arch/arm/boot/dts/am335x-bone.dts | 123 ++++++++++++++++++++++++++++++++++++++
>>>>>>>  1 file changed, 123 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
>>>>>>> index 94ee427..be2c572 100644
>>>>>>> --- a/arch/arm/boot/dts/am335x-bone.dts
>>>>>>> +++ b/arch/arm/boot/dts/am335x-bone.dts
>>>>>>
>>>>>> better to make a nand_cape dts which includes the am335x-bone.dts?
>>>>>>
>>>>> Actually, I'm not in favor of having too many "xx_board_common.dts" files,
>>>>> because it un-necessarily complexes things.
>>>>>
>>>>> We already have "arch/arm/boot/dts/am335x-bone-common.dtsi" which just saves
>>>>> some lines common to DTS of both Beaglebone-LT(white) and Beaglebone-Black.
>>>>> And, there is no guarantee that Beaglebone-LT(white) will remain compatible to
>>>>> Beaglebone-black in future.
>>>>> Example: some capes are not compatible to beaglebone-black [1], [2].
>>>>>
>>>>> So, I prefer to keep separate GPMC NAND nodes separately in both DTS,
>>>>> unless there is a strong convincing reason otherwise.
>>>>>
>>>>>
>>>>> [1] http://elinux.org/CircuitCo:BeagleBoardToys
>>>>> [2] http://elinux.org/BeagleBone_Black_Capes
>>>>
>>>>
>>>>
>>>> Right, and adding NAND, GPMC nodes and asking folks to uncomment
>>>> sections into a generic board file (which by default has none) makes
>>>> more sense? I dont use NAND capes or might create my own cape. overo
>>>> has the same challenges as bone family has.I dont see asking folks to
>>>> uncomment entries to use the cape is a nicer alternative to having
>>>> more dts entries.

I think this is different discussion from previous one ..
"common DTS file" v/s "replicated DTS entries in individual board files"
because 'uncomment' issue will remain in both scenarios. (please read below)


>>>
>>> This is just going to get more messy with every cape addition. Should
>>> we maybe just leave a basic BeagleBone & BeagleBone Black dts file in
>>> mainline kernel.org.
>>>
>>> Then create a repo on github.com/beagleboard/ with every
>>> <bone/black>-<first level cape>.dts option?
>>
>> Or just include all devices on the most common capes but have their
>> status as disabled by default.
>>
>> For the pinctrl, we need to make sure the pins for a device are not
>> muxed if it's set to disabled state.

Yes, this is exactly what I intended. Therefore if you revisit the
"uncomment" section, then you would find that there is mmc2=disabled
because on beaglebone-black eMMC (MMC2) pinctrl conflicts with
NAND pin-ctrl.
------------------------
> +/*
> + * uncomment following to enable NAND cape support
> + * &mmc2 {
> + *      status = "disabled";
> + * };
> + * &elm {
> + *	status = "okay";
> + * };
> + * &gpmc {
> + *	status = "okay";
> + * };
------------------------
And I agree 'uncommenting' is not cleaner approach here, so if everyone
agrees, I can remove the above comment and just keep NAND DT node
"disabled" by default.


>
>You do have a bunch of "if you want nand, disable mmc2" configuration
>in the usage of cape configurations such as this patch, or in the case
>of [1] (audio cape), different regulator usage etc. Maintaining out of
>tree cape dts might be an option, but that is prone to maintenance
>burden as device tree conversion goes on (yeah, all the dt as ABI
>stuff aside).
>
>Keeping aside the subjective nature of what entitles a cape being a
>"common cape",even introducing nodes that belong to three or four
>different first level capes will definitely have it's own sets of
>problems.
>
>The ideal solution would be some folks pitching in on what Matt
>pointed in [2] - basically "upstream a resource manager on
>top of the basic overlay support that's in progress" and introduce
>capes as part of that overlay support once it is upstream.
>
I'm not sure how much "capemgr" or "DT overlay" is useful to larger
audience ? 

(1) *Usually* actual custom board going to production will have
all devices populated on the board. fixed. It's very rare that an end-user
may buy an extension board (like capes) and add to finished good.
Thus, 'DT overlay' and 'capemgr' are good for development platforms
where you give a generic basic board for people to play (at low cost)
And then give accessory boards (like capes) on top to choose and build
a conceptual solution.

(2) Also, 'capemgr' should be able to detect and identify all the capes
uniquely, and in correct sequence. For which you need some kind
of identification mechanism like EEPROM on each cape connected
to I2C. And I doubt all beaglebone capes have that as-of-today.
(also that makes cape slightly expensive).

So, I'll still prefer Tony's suggestion that,
add support for all Capes in DT, but keep the conflicting ones
"disabled" by default. And let the user choose which ones to enable.
This is simple and keeps maintenance overhead also low.


>Failing which, keeping the base bone dts to basic stuff that bare
>board supports and having per "first level cape" dts which includes
>relevant dts sounds to me the only rationale and easily usable (as in:
>without much device tree knowledge) - again, I admit "easily" is
>subjective here.
>
>
>[1] https://lkml.org/lkml/2014/2/5/183
>[2] https://lkml.org/lkml/2014/2/5/247
>
>--
>Regards,
>Nishanth Menon

with regards, pekon

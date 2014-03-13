From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v1 1/3] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Thu, 13 Mar 2014 08:30:19 -0500
Message-ID: <CAOCHtYhcJZ711XaJhBAPNSoHH-dK_tH8ZgB-AHZ86POXas1OfQ@mail.gmail.com>
References: <1394621360-2457-1-git-send-email-pekon@ti.com>
	<1394621360-2457-2-git-send-email-pekon@ti.com>
	<532070C8.1030903@ti.com>
	<20980858CB6D3A4BAE95CA194937D5E73EAB2CF1@DBDE04.ent.ti.com>
	<CAGo_u6rvUqa-7afTFzBahDJuyVkXAj5J2LL8tQRjZuf8_xWXWA@mail.gmail.com>
	<CAOCHtYhqZoCF13e1YjBiWPufDEmVotL3chO9ZUtivWbVTWVfiQ@mail.gmail.com>
	<20140312192850.GF1996@atomide.com>
	<5320C8B5.601@ti.com>
	<20980858CB6D3A4BAE95CA194937D5E73EAB2E95@DBDE04.ent.ti.com>
	<20140312215337.GA5735@kahuna>
	<20980858CB6D3A4BAE95CA194937D5E73EAB2F96@DBDE04.ent.ti.com>
	<5321AC92.2090307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:35396 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaCMNaU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 09:30:20 -0400
Received: by mail-yh0-f54.google.com with SMTP id f73so972922yha.13
        for <linux-omap@vger.kernel.org>; Thu, 13 Mar 2014 06:30:20 -0700 (PDT)
In-Reply-To: <5321AC92.2090307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Tony Lindgren <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>

On Thu, Mar 13, 2014 at 8:03 AM, Nishanth Menon <nm@ti.com> wrote:
> On 03/13/2014 01:19 AM, Gupta, Pekon wrote:
> [..]
>>> diff --git a/arch/arm/boot/dts/am335x-bone-memory-cape.dts b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
>>> new file mode 100644
>>> index 0000000..7ab088d
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/am335x-bone-memory-cape.dts
>>>
>> From discussions, option I could think are..
>>
>> (a) NAND cape node added in both 'am335x-bone.dts' and
>>    'am335x-boneblack.dts' but "disabled" by default.
>>
>> (b) NAND cape node in new '.dts' file (as mentioned above), and generate
>>    a separate blob individual for cape.
>>
>> (c) NAND cape node in existing 'am335x-bone-common.dtsi', "disabled"
>>    by default. But there is no guarantee that future boards remain
>>    compatible and same 'common_xx.dtsi' can be reused later.
>>
>> I'll wait for Tony/Benoit-C. to decide on what suits them, as they are the
>> ones who have to maintain all these. Tony ?
>>
>
> Key for us is that we'd have to live with what ever we introduce in
> the interest of backward dtb compatibility. both (a) and (c) requires
> hand modification by user of nand cape - considering this might be the
> strategy for "most common capes", we might end up with confusing
> entries that in many cases will require additional documentation
> example: option a, c: consider both audio cape (which needs hdmi
> disabled) and nand cape (which needs mmc2 disabled) - how'd the user
> know which entries to enable/disable for the user of the cape -
> documentation needed and potentially user error prone implementation
> as well.
>
> There is as well a option (d) where we wait for FDT overlay to mature,
> write up a resource manager and support all level capes.

(b) is the direction i'm currently trying to transition the
beagleboard.org community till (d) actually shows any life/hope again.

example:
https://github.com/RobertCNelson/linux-dev/tree/am33x-v3.13/patches/static-capes

I really like Nishanth's simpler version he posted, so I'll be
converting mine to that style later today.

Also with u-boot v2014.04-rcX we now have "test -e" (exist support) so
we can actively check for the presence of <board>-<cape>.dtb and
safely fall back to <board>.dtb if it didn't actually exist.  The only
requirement is the end user specify the <cape> as a variable in
uEnv.txt

https://github.com/RobertCNelson/Bootloader-Builder/blob/master/patches/v2014.04-rc2/0001-am335x_evm-uEnv.txt-bootz-n-fixes.patch#L76

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/

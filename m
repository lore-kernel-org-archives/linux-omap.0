From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Mon, 10 Nov 2014 00:59:17 +0530
Message-ID: <545FC08D.8000008@pek-sem.com>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com> <20141106180333.GZ31454@atomide.com> <545C9267.7060301@ti.com> <545C97AB.4040402@ti.com> <20141107224832.GG31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([162.210.70.59]:43519 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095AbaKIT3f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Nov 2014 14:29:35 -0500
In-Reply-To: <20141107224832.GG31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>
Cc: computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, stable@vger.kernel.org

On Saturday 08 November 2014 04:18 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [141107 01:59]:
>> On 11/07/2014 11:35 AM, Roger Quadros wrote:
>>> On 11/06/2014 08:03 PM, Tony Lindgren wrote:
>>>> * Roger Quadros <rogerq@ti.com> [141105 03:02]:
>>>>> In commit 7d5929c1f343 ("mtd: nand: omap: Revert to using software ECC by default"),
>>>>> we switched back to using 1-bit SW ECC scheme by default. However
>>>>> commit b491da7233d5 ("mtd: nand: omap: clean-up ecc layout for BCH ecc schemes")
>>>>> didn't take into account the 1-bit SW scheme (i.e. OMAP_ECC_HAM1_CODE_SW)
>>>>> when checking for small page devices because it was already got rid of
>>>>> one commit earlier. Consider OMAP_ECC_HAM1_CODE_SW while deciding
>>>>> if we can proceed with small page devices or not.
>>>>>
>>>>> Fixes: 7d5929c1f34 ("mtd: nand: omap: Revert to using software ECC by default")
>>>>>
>>>>> Cc: <stable@vger.kernel.org>        [3.17+]
>>>>> Reported-by: Tony Lindgren <tony@atomide.com>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>> ---
[...]
>>
>> Well I'm wrong about the OMAP3 information. OMAP3 does support BCH4 and BCH8 as well.
>>
>> I'm don't thinkg small page check is right. For BCH8 we need 13 bytes per 512 bytes.
>> In the LDP case we have page size:1024 and OOB size: 32.
>> Thus for BCH8 we need 26 bytes per page. which should fit in 32 bytes OOB.
>> So this check is bogus in that case.
>>
>> Pekon,
>>
>> can you please explain why you check for 64 bytes OOB size for all ECC schemes?
>>
Accept this is a bug.
As I re-review now, small-page check is applicable only for BCH ECC 
schemes, and not for HAM1.

>> Tony,
>>
>> The question for backward compatibility still remains. Even if OMAP3 supports bch8
>> do we stick to the scheme that was used in legacy boot or do we switch?
>
> Well for the boards that had a standard file system, we should support
> that. But at least for the LDP, there was only the "bootable microSD card"
> AFAIK:
>
> http://support.logicpd.com/ProductDownloads/LegacyProducts/ZoomOMAP34xMDK.aspx
>
OMAP3 supports BCH ECC scheme.
Document: http://www.ti.com/lit/pdf/spruf98
(1) GPMC in OMAP3 supports BCH8
	Section: 11.1.5.14.3.2 BCH Code
(2) ROM code in GPMC supports BCH (but its not clear whether its BCH4 or 
BCH8)
	Section: 25.4.7.4.3 MLC NAND Read Sector Procedure

But I agree that now it doesn't make sense to put effort on OMAP3 for 
upgrading default ECC schemes. If user has to migrate then there are 
other easy ways of doing so.



>> Then there is the question of boot rom compatibility. OMAP3 bootloaders use HAM1 scheme.
>> So if you want to be able to flash bootloader from the kernel we have to stick with HAM1.
>>
>> changing the ECC scheme would mean that NAND filesystems created earlier won't work
>> and will have to be erased and recreated.
>
> Right. I doubt anybody has bch8 rootfs on LDP.. And considering u-boot
> must be ham1 to boot at all, that's what we should change for the
> devices that do not have not standardized on bch8.
>
My view on this is slightly different:
- Lately, everyone seems to have migrated to BCH8.

- Also HAM1 does not have strength to fix bitflips in aging NAND. So if 
someone already has OMAP3-LDP deployed on field then its NAND would have 
already aged to such an extend that HAM1 may not be sufficient.

My question is..
Moving back to HAM1 should be decided based on statistics rather than 
rule of breaking backward compatibility. So please review:
(1) How many user of OMAP3-Zoom or other old boards complaining about 
using BCH8 in mainline kernel? OR
(2) How many users of OMAP3 legacy boards are migrating to newer kernel?

At-least I have not, rather most of the OMAP3 users I interacted via 
TI's E2E forum wanted to migrate to BCH8 or even BCH16, as HAM1 was not 
sufficient for their usage.

So whatever you decide on this topic, please be cautious that you don't 
re-invent work for yourself, as I did. It took me lot of time and 
testing effort on multiple boards to migrate HAM1 to BCH8, And add BCH16 
for newer devices.

Also, now I realize u-boot (boot-loaders) are better place for all this 
migration.


> Regards,
>
> Tony
>

with regards, pekon

------------------------
Powered by BigRock.com


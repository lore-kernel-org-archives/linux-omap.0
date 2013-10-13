From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v8 0/6] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Sat, 12 Oct 2013 18:40:45 -0700
Message-ID: <5259FA1D.2090801@gmail.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com> <20131011210924.GO23337@ld-irv-0074.broadcom.com> <20980858CB6D3A4BAE95CA194937D5E73EA2188A@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:53964 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab3JMBkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Oct 2013 21:40:49 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA2188A@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Pekon,

On 10/12/2013 03:26 PM, Gupta, Pekon wrote:

>> I will try to summarize the standing of your patch series.
>>
>> Patches 1 and 2 look good and have addressed all of the DT maintainers'
>> comments, AFAICT. They are ready to go in, except that the following
>> patches are not ready; they should probably go in together.
>>
>> You ignored most of my comments to patch 3, and it is insufficiently
>> documented. Please take a look at my comments, both here (in v8) and in
>> v6. It still should be split into more patches.
>>
> I tried splitting the earlier [PATCH 3/6], therefore a new patch for merging
> various Hamming ECC schemes was spawned. But, I could not clean more
> because I would have broken the NAND functionality in between the
> patches.

 From what I understand, your comment "cleans redundant code" in patch 3 
is entirely its own logical change; you're replacing the SW ECC in 
omap2.c with the library wrapper in lib/bch.c, right? So this should be 
described as such (as "replacing XXX with YYY") and can easily be its 
own patch?

Also, you add an 'mtd' and a 'nand_chip' (can you just call this 'chip' 
or maybe 'nand', like in other drivers?) variable to the probe function, 
and then partially convert the function over to inconsistently using mtd 
vs. info->mtd and nand_chip vs. info->nand. If you want to add these 
variables, just make it a separate patch.

I also mentioned your changes to the buswidth code, which seem to have 
snuck in again. This should be a separate patch.

> My apologies, I missed some of you other comments, so I'm preparing
> next version by splitting [PATCH 3/6] into more sub-patches for ease of
> review.

Great, thanks.

> Most #ifdef were put to suppress warning of un-used functions during
> compile time. So those cannot be removed, otherwise this patch would
> give compile warnings under randconfig.

Could be marked __maybe_unused instead? #ifdef's are also OK, if 
necessary. There were just a few places I pointed out that they was 
certainly not needed.

>> Patch 4 does too much without describing it. Why are you dropping the
>> old omap3_correct_data_bch() code? Is this just refactoring? If so, you
>> should say so. And this also suggests that you have two logical changes
>> going on that should be separated into different patches; one to
>> refactor the open-coded NAND/BCH library to replace it with the
>> nand_bch.{c,h} support library and one for the new ECC modes.
>>
> Agreed, I update commit log to be more explicit that here nand_bch.c
> actually encapsulates lib/bch.c.
> Here also I cannot remove #ifdef across nand_bch_free() because
> it frees some bch control data, which would not be defined for all
> ecc-schemes (it is specific to xx_SW  ecc schemes). Hence removing
> #ifdef here would give null-pointer exception.

Note that nand_bch_free() (and many others in nand_bch.h) are given 
empty inline implementation for CONFIG_MTD_NAND_ECC_BCH=n. But if you 
are unsure, then you can leave the #ifdef's to be conservative.

>> Patch 5 is good but should wait until the other DT parts are acceptable
>> and merged into MTD.
>>
>> Patch 6 needs rewriting to use devm_* functions properly, but it was
>> never integral to this patch series. You can improve it and resend with
>> this series or just send it separately afterward.
>>
> Yes I understood this, but I think it would be still good to explicitly
> free the resources in case of "module_remove()", because that would
> free all resources instantaneously without waiting for devm_ to
> iterate thru the list when it wakes-up (I guess).

devm_* is part of the driver core, so it does the cleanup immediately on 
a non-zero return from the probe() callback, or after exit from the 
remove() callback. It does not have to "wake up". Its only overhead is 
the small amount of memory used for the linked-list management.

Again, this is an optional piece of work, so don't worry about it too 
much. But you get 0 benefit (just a slight increase in memory usage) if 
you just convert all the kfree() calls to devm_kfree().

> I'm not knowledgeable of exact implementation of devm_ and how
> often does it iterates the list and frees the resources for corresponding
> un-registered devices. So trusting you I'll include your feedbacks here.

I haven't closely reviewed 100% of its implementation, but it is fairly 
straightforward and commonly used in many drivers. You should be fine 
using it as documented and recommended by me.

Thanks,
Brian

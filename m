From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v8 3/6] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC
 configurations in device_probe
Date: Sat, 12 Oct 2013 18:40:54 -0700
Message-ID: <5259FA26.8090805@gmail.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com> <1381498603-15715-4-git-send-email-pekon@ti.com> <20131011192833.GL23337@ld-irv-0074.broadcom.com> <20980858CB6D3A4BAE95CA194937D5E73EA218B5@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:44587 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab3JMBk5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Oct 2013 21:40:57 -0400
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA218B5@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Pekon,

On 10/12/2013 04:58 PM, Gupta, Pekon wrote:
>> From: Brian Norris [mailto:computersforpeace@gmail.com]
>>> On Fri, Oct 11, 2013 at 07:06:40PM +0530, Pekon Gupta wrote:
> [...]
>> Why do you even need the #ifdef's for the #include's? It is not harmful
>> to include headers for stuff that is only conditionally used. In fact,
>> this creates a problem later when you try to use nand_bch_free(), and
>> you have to surround it with extra #ifdef's.
>>
>> In short: these #ifdef's just breed more #ifdef's and cause the code to
>> become harder to read and less maintainable.

First off, I should clarify this: the above comment was speaking *only* 
about surrounding the #include's with #ifdef's. Such #ifdef's only make 
everything else harder.

Now, I recognize that there are still many cases where you may need 
#ifdef's in the body of the code. I was only trying to hit the easiest ones.

> There are 2 problems here:
> (1)
> I have removed #ifdef across headers in next version. But I cannot remove
> #ifdef across some callbacks for  cc.hwctl(), ecc.calculate(), ecc.correct(),
> because then compilation would throw warnings for un-used functions.

The __maybe_unused attribute can be given to functions that will compile 
but are unused, and the compiler will just remove unused ones from the 
binary without warning. That is probably (weakly) preferable to 
#ifdef's, if you can manage it. But I understand some #ifdef's are 
necessary.

> (2)
> OMAP driver uses generic lib/bch.c which is compiled only when
> CONFIG_MTD_NAND_ECC_BCH is enabled. So to avoid compilation
> issues, I had to put #ifdefs on all wrapper functions which use lib/bch.c
> or nand_bch.c

nand_bch.c (and its corresponding nand_bch.h) has stub implementations 
so that extra #ifdef's often aren't needed. But include/linux/bch.h does 
not, so you are correct.

> I myself have tried in previous versions to avoid #ifdefs, but I ended
> up in one or the other problem like (1) |  (2) above.
> And this is where randconfig test failed earlier when Arnd Bergmann
> commented, so some #ifdef would hv to be carried till be deprecate
> some legacy ecc-schemes.
> However, with patch split many redundant #ifdefs are now removed.

Great, thanks for the effort.

Regards,
Brian

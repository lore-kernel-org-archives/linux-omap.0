From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] mtd: nand: omap: Fix NAND enumeration on 3430 LDP
Date: Thu, 13 Nov 2014 13:29:22 +0200
Message-ID: <54649612.8090402@ti.com>
References: <1415185258-11747-1-git-send-email-rogerq@ti.com> <20141106180333.GZ31454@atomide.com> <545C9267.7060301@ti.com> <545C97AB.4040402@ti.com> <20141107224832.GG31454@atomide.com> <545FC08D.8000008@pek-sem.com> <20141112180253.GJ26481@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20141112180253.GJ26481@atomide.com>
Sender: stable-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, pekon <pekon@pek-sem.com>, "Rini, Tom" <trini@ti.com>
Cc: computersforpeace@gmail.com, dwmw2@infradead.org, ezequiel@vanguardiasur.com.ar, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/12/2014 08:02 PM, Tony Lindgren wrote:
> * pekon <pekon@pek-sem.com> [141109 11:31]:
>> On Saturday 08 November 2014 04:18 AM, Tony Lindgren wrote:
>>>
>>> Right. I doubt anybody has bch8 rootfs on LDP.. And considering u-boot
>>> must be ham1 to boot at all, that's what we should change for the
>>> devices that do not have not standardized on bch8.
>>>
>> My view on this is slightly different:
>> - Lately, everyone seems to have migrated to BCH8.
>>
>> - Also HAM1 does not have strength to fix bitflips in aging NAND. So if
>> someone already has OMAP3-LDP deployed on field then its NAND would have
>> already aged to such an extend that HAM1 may not be sufficient.
> 
> OK so it makes sense to keep it as BCH8 then. Would be nice to get
> the writing u-boot from kernel issue fixed somehow though as people
> are hitting that for sure.

What about performance impact? OMAP3 doesn't have ELM module. So error location
for BCH8 has to be done in software.

>  
>> My question is..
>> Moving back to HAM1 should be decided based on statistics rather than rule
>> of breaking backward compatibility. So please review:
>> (1) How many user of OMAP3-Zoom or other old boards complaining about using
>> BCH8 in mainline kernel? OR
> 
> 0
> 
>> (2) How many users of OMAP3 legacy boards are migrating to newer kernel?
> 
> Quite a few for sure, but are probably also using rootfs on MMC instead.
>  
>> At-least I have not, rather most of the OMAP3 users I interacted via TI's
>> E2E forum wanted to migrate to BCH8 or even BCH16, as HAM1 was not
>> sufficient for their usage.
>>
>> So whatever you decide on this topic, please be cautious that you don't
>> re-invent work for yourself, as I did. It took me lot of time and testing
>> effort on multiple boards to migrate HAM1 to BCH8, And add BCH16 for newer
>> devices.
> 
> Right no objections to using BCH8 for rootfs, except it stopped working
> over past year or so.

This would be BCH8-sw on OMAP3 right? AM3xx uses BCH8-hw and that seems to work fine.
So it seems nobody has used/tested BCH8-sw.

> 
> And it seems the settings should be partition specific because of u-boot
> requiring HAM1.
> 
I don't think we have partition specific ECC scheme support in u-boot or kernel,
so it will become messy to manage.
That means we either stick with HAM1 for all partitions or don't support NAND boot
at all and go with any other ECC scheme for OMAP3.

cheers,
-roger

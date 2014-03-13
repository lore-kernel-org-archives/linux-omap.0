From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: correct the idlemodes for spinlock
Date: Thu, 13 Mar 2014 22:07:56 +0100
Message-ID: <53221E2C.9040109@baylibre.com>
References: <1387838928-57745-1-git-send-email-s-anna@ti.com> <alpine.DEB.2.02.1312260447320.15949@utopia.booyaka.com> <20140313202547.GD5981@atomide.com> <alpine.DEB.2.02.1403132101490.25824@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:48724 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaCMVIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 17:08:01 -0400
Received: by mail-we0-f173.google.com with SMTP id w61so1360936wes.18
        for <linux-omap@vger.kernel.org>; Thu, 13 Mar 2014 14:07:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1403132101490.25824@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org

Hi Paul,

On 13/03/2014 22:02, Paul Walmsley wrote:
> On Thu, 13 Mar 2014, Tony Lindgren wrote:
>
>> * Paul Walmsley <paul@pwsan.com> [131225 20:51]:
>>> (cc Beno=C3=AEt)
>>>
>>> On Mon, 23 Dec 2013, Suman Anna wrote:
>>>
>>>> The spinlock module's SYSCONFIG register does not support
>>>> smart wakeup, so remove this flag from the idle modes in
>>>> the spinlock hwmod definition.
>>>>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>
>>> Beno=C3=AEt Cousson is the primary maintainer of this file that you=
're
>>> changing:
>>>
>>> $ scripts/get_maintainer.pl -f arch/arm/mach-omap2/omap_hwmod_44xx_=
data.c
>>> "Beno=C3=AEt Cousson" <bcousson@baylibre.com> (maintainer:OMAP HWMO=
D DATA F...)
>>> Tony Lindgren <tony@atomide.com> (maintainer:OMAP SUPPORT)
>>> Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)
>>> linux-omap@vger.kernel.org (open list:OMAP HWMOD DATA F...)
>>> linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHIT=
ECT...)
>>> linux-kernel@vger.kernel.org (open list)
>>> $
>>>
>>> Please make sure that he's part of the address list when patches ar=
e sent
>>> that apply against this file.
>>
>> FYI untagging this in my inbox assuming it's being resent or queued =
by Paul.
>
> Hmm, seems like it's either you or Beno=C3=AEt who is on the hook for=
 this one.
>
> Beno=C3=AEt?
>
> Am happy to queue it if either of you want.

=46eel free to queue it, I don't have anything else pending so far, so =
I=20
was not planning to do a pull request.

Acked-by: Benoit Cousson <bcousson@baylibre.com>

Thanks,
Benoit

--=20
Beno=C3=AEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

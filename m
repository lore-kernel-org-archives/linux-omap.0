From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
Date: Mon, 29 Jul 2013 17:18:11 +0200
Message-ID: <51F687B3.7030902@ahsoftware.de>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com> <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com> <51F633AE.8090308@collabora.co.uk> <51F63864.9000601@collabora.co.uk> <51F666B7.7020209@ti.com> <51F681C4.3000400@ahsoftware.de> <51F684F2.5050308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:60721 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757245Ab3G2PS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 11:18:57 -0400
Received: from eiche.ahsoftware (p57B216E0.dip0.t-ipconnect.de [87.178.22.224])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 259BE423C270
	for <linux-omap@vger.kernel.org>; Mon, 29 Jul 2013 17:18:54 +0200 (CEST)
In-Reply-To: <51F684F2.5050308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Linus Walleij <linus.walleij@linaro.org>, Paul Walmsley <paul@pwsan.com>, Linux-OMAP <linux-omap@vger.kernel.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Kevin Hilman <khilman@linaro.org>

Am 29.07.2013 17:06, schrieb Santosh Shilimkar:
> On Monday 29 July 2013 10:52 AM, Alexander Holler wrote:
>> Am 29.07.2013 14:57, schrieb Santosh Shilimkar:
>>
>>> With some helps from MMC and other guys, we validated the Linus's tip which includes
>>> your patches. It actually doesn't break anything and as OMAP hsmmc maintainer
>>> clarified, the cd-gpios isn't supported yet for DT. While supporting that it
>>> can use appropriate binding whichever works.
>>>
>>> But with OMAP1 breakage reported by Paul, I think we are not left with choice
>>> but to revert those commits. We *must* respect rc rules for the fixes.
>>> *No regression*
>>>
>>> Thanks for your hardwork to cook up those patches but now Linus's W proposal
>>> is going to be generic, hopefully the issue can be address better. Till
>>> then we can't get the ethernet support.
>>
>> The problem never was just the omap_hsmmc driver. I rather would say all drivers which do use GPIOs as IRQs were affected.
>>
>> I've only used the omap_hsmmc driver as example, because that was the driver I've tried to actually use with sd-cards, which is rather impossible without having a working CD-signal. And all code was already there and seems to work (at least during my few tests), so I've just added an entry to the dts to be able to use a mmc-slot as one would expect a mmc-slot does work.
>>
>> If someone wants to test a new feature at the same front, I would suggest to try it out using gpio-keys. That driver should work on almost any architecture/platform/hardware which supports gpios and is small enough to be a good test candidate. Having had a short look at gpio-keys.c, I think the same problems as with omap_hsmmc would have been occured when someone had tried to use that driver with 3.11-rc2.
>>
> The 3 OMAP platforms which supports DT are AM33XX, OMAP4 and OMAP5.
> OMAP3 based boards are getting converted but they are bit far from being
> DT only. So my statement was again from what we support on mainline today
> and those platform don't use gpio-keys. But for testing perspective,
> I guess its good idea.
>

I wonder how you do know that no board with OMAP chips does use gpio-keys?

Does TI restrict their users/customers to only certified drivers? ;)


> As mentioned above, we are going ahead with revert and possible better
> alternative to the root of the problem.
>
> Regards,
> Santosh
> P.S: Please sensibly wrap your email replies to 80 chars so that
> people can read it without scrolling to the end of the line.

Line-wrapping mail readers do exist since some decades and I believe 
people should be able to read e-mails with whatever line width they 
prefer (and NOT what I prefer). So I never will hard-limit mails to some 
specific line width on my side (besides from patch). That's just a very 
bad behaviour.

Regards,

Alexander Holler


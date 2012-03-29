From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: OMAP: i2c, gpio, spi, regulator and mmc DTS updates
Date: Thu, 29 Mar 2012 11:31:11 -0700
Message-ID: <CAOesGMg+xLrVNxF0XwO8poAtuduwEcxrXLN9pXa+T+y7kKMy7Q@mail.gmail.com>
References: <4F612C29.40608@ti.com>
	<20120315004638.GW12083@atomide.com>
	<201203150801.13183.arnd@arndb.de>
	<4F746CC0.9050507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50497 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933681Ab2C2SbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Mar 2012 14:31:13 -0400
Received: by wgbdr13 with SMTP id dr13so1824628wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 29 Mar 2012 11:31:12 -0700 (PDT)
In-Reply-To: <4F746CC0.9050507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org

On Thu, Mar 29, 2012 at 7:08 AM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Arnd and Olof,
>
>
> On 3/15/2012 9:01 AM, Arnd Bergmann wrote:
>>
>> On Thursday 15 March 2012, Tony Lindgren wrote:
>>>
>>> * Cousson, Benoit<b-cousson@ti.com> =A0[120314 16:41]:
>>>>
>>>> Hi Tony,
>>>>
>>>> Here are the remaining DTS patches for 3.4.
>>>>
>>>> On top of the previous pull request, I just added the MMC DTS sinc=
e the
>>>> driver adaptation just got queued.
>>>>
>>>> It will be still be good to have that for 3.4 if possible, otherwi=
se we
>>>> will
>>>> have a bunch of drivers DT adapted but no DTS file to use them :-(
>>>
>>>
>>> This might be doable as a follow-up patch series at the end
>>> of the merge window or at -rc1 when the related driver changes
>>> have been merged.
>>>
>>> Arnd and Olof, what do you guys think?
>>
>>
>> I'll have to look at the patches more closely, but from the diffstat=
 it
>> definitely
>> looks ok for a later merge once the driver is in. If you can rebase =
the
>> branch on
>> top of the mmc tree (or the merge of that tree with whatever else is
>> needed), it
>> should give us a bisectable history and I can stick it into a late/*
>> branch right
>> away.
>
>
> FYI, MMC DT adaptation just got merged, I2C, GPIO, SPI, regulator DT
> adaptation were already merged before, so it means that this branch c=
an be
> merged to take advantage of all the DT adapted drivers.

I've pulled this in as late/omap-dt, included in next/dt3 and
for-next. I'll let it sit in linux-next for at least one day before
it's sent in. Since it's just device tree additions, risk for
regressions should be low.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

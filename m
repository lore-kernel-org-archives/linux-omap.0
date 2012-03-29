From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP: i2c, gpio, spi, regulator and mmc DTS updates
Date: Thu, 29 Mar 2012 16:08:00 +0200
Message-ID: <4F746CC0.9050507@ti.com>
References: <4F612C29.40608@ti.com> <20120315004638.GW12083@atomide.com> <201203150801.13183.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37883 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab2C2OII (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 10:08:08 -0400
In-Reply-To: <201203150801.13183.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Arnd and Olof,

On 3/15/2012 9:01 AM, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Tony Lindgren wrote:
>> * Cousson, Benoit<b-cousson@ti.com>  [120314 16:41]:
>>> Hi Tony,
>>>
>>> Here are the remaining DTS patches for 3.4.
>>>
>>> On top of the previous pull request, I just added the MMC DTS since the driver adaptation just got queued.
>>>
>>> It will be still be good to have that for 3.4 if possible, otherwise we will
>>> have a bunch of drivers DT adapted but no DTS file to use them :-(
>>
>> This might be doable as a follow-up patch series at the end
>> of the merge window or at -rc1 when the related driver changes
>> have been merged.
>>
>> Arnd and Olof, what do you guys think?
>
> I'll have to look at the patches more closely, but from the diffstat it definitely
> looks ok for a later merge once the driver is in. If you can rebase the branch on
> top of the mmc tree (or the merge of that tree with whatever else is needed), it
> should give us a bisectable history and I can stick it into a late/* branch right
> away.

FYI, MMC DT adaptation just got merged, I2C, GPIO, SPI, regulator DT 
adaptation were already merged before, so it means that this branch can 
be merged to take advantage of all the DT adapted drivers.

Thanks,
Benoit

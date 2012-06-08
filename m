From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 8 Jun 2012 14:04:35 -0500
Message-ID: <4FD24CC3.50700@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201205190844.03654.arnd@arndb.de> <4FBA7C80.4080801@wwwdotorg.org> <201205211818.45646.arnd@arndb.de> <4FBAA64A.200@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45520 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837Ab2FHTEz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Jun 2012 15:04:55 -0400
In-Reply-To: <4FBAA64A.200@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jassi Brar <jaswinder.singh@linaro.org>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Stephen, Arnd,

Been a while ;-)

On 05/21/2012 03:32 PM, Stephen Warren wrote:
> On 05/21/2012 12:18 PM, Arnd Bergmann wrote:
>> On Monday 21 May 2012, Stephen Warren wrote:
>>>>
>>>> The point with the direction was that it covers most cases and makes
>>>> them rather simple, while for the rare case where you need more than
>>>> two channels, you just use the otherwise optional named interface
>>>> rather than the numbered one. My feeling is that this also makes a
>>>> lot of sense at the driver API level: most dirvers just ask for the
>>>> read and write channels using a very simple interface, and those drivers
>>>> that have more than two will want to name them anyway.
>>>
>>> How are you thinking of representing the direction in DT - as part of
>>> the DMA request specifier, so in a DMAC-specific way?
>>>
>>> If so, that seems a little odd; you have to request a DMA channel for
>>> "TX", but then end up having the common code check all the entries in
>>> the dmas property since it can't know which are TX, and then have the
>>> wrong ones almost accidentally fail, since the DMAC will then determine
>>> that it can't support TX on the RX DMA request IDs.
>>
>> I think the direction must be encoded in a way that does not depend on
>> the binding for the specific controller. There are two ways I can see
>> how we might do it:
>>
>> 1. have separate property names for tx and rx channels, and probably
>>    one for combined rx/tx channels
> 
>> 2. define the second cell in each channel specifier to be the direction
>>    in a predefined format, followed by the other (controller specific)
>>    attributes, if any.
> 
> In this option, lets say bit 0 is 0==TX, 1==RX (or perhaps 2 bits if
> combined TX/RX is needed)
> 
> Then, we could reserve say bits 7:1 as client DMA request ID.
> 
> And then have bits 31:8 as DMAC specific data.
> 
> Wouldn't that allow us to have our cake and eat it?

Sorry for not responding sooner.

It seems to me we were pretty close on alignment. In fact, I was quite
happy with Steven's 2nd to last proposal of  ...

simple 1 req:
dmas = <0 &dmac1 xxx>;

simple 2 req:
dmas = <0 &dmac1 xxx 1 &dmac1 yyy>;

multiple dmacs:
dmas = <0 &dmac1 xxx 0 &dmac2 zzz 1 &dmac1 yyy>;

Arnd, I know that you had some concerns. However, in the above case I
would expect that the 3rd parameter be optional and it can be some sort
of match variable. In other words, we don't care how the 32-bits are
encoded or what they represent but they would be used appropriately by
the xlate function being used. So the xlate and this "match" variable
would have to speak the same language.

I think that I prefer the idea of having a 3rd optional match variable
than encoding the DMA request ID and match data together in 1 32-bit
variable. However, not a big deal either way.

Cheers
Jon

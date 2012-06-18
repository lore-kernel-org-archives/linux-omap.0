From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 5/7] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
Date: Mon, 18 Jun 2012 23:36:49 +0200
Message-ID: <4FDF9F71.8030805@ti.com>
References: <20120618061037.30632.28539.stgit@dusk> <20120618061608.30632.62660.stgit@dusk> <4FDEF668.6050108@ti.com> <alpine.DEB.2.00.1206180937500.9031@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35090 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab2FRVg4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 17:36:56 -0400
In-Reply-To: <alpine.DEB.2.00.1206180937500.9031@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi Paul,

On 6/18/2012 5:45 PM, Paul Walmsley wrote:
> Hi
>
> On Mon, 18 Jun 2012, Cousson, Benoit wrote:
>
>> I guess that patch need to be revisited based on discussion we had and
>> the patch you proposed in [1]. Assuming Tony is OK, it should be
>> probably part of the -rc, because this domain should not have been
>> introduced in 3.5-rc1 at all for OMAP4.
>
> Well as mentioned already on the lists, these clockdomains clearly exist;
> they are documented in the TRM and functional specification, and make
> sense from a chip perspective.

OK, let's clarify: These are not clock domains for PRCM standpoint. 
These are the clock generators inside the PRCM, but they do not follow 
the functional clock domain mechanism at all.

Because of that they do not have any regular clkdm registers and that's 
why it does not worth using the current clkdm infrastructure since there 
is no SW control for them.

What is missing to make these domains valid is to extend the current 
definition to handle both the clock consumer domains and the clock 
generators.

> For 3.6, I've already agreed to remove those clockdomains, even though it
> doesn't really match what's there on the chip.  But I think 3.6 is the
> right time to do that.

OK, fair enough. I'll base the further cleanup series on that one.

>> So it will be better to revert the patch that introduced that first
>> before adding any new fix that will rely on a code that will disappear.
>>
>> In fact, I think the proper way to fix that while maintaining the
>> OMAP2&3 way of dealing with clkdm is to ensure that at least one clkdm
>> is there in either hwmod or the main_clk. That will fix these issues and
>> the one that will append when the fake main_clk will be removed.
>>
>> Here is a patch that is doing that.
>
> Please document what systems this has been tested on.

For the moment, Thunderbird 13.0.1 only since I do not have any board 
accessible :-(.

Regards,
Benoit

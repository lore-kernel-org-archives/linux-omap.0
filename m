From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 6/9] ARM: OMAP2+: Fix external clock support for dmtimers
Date: Tue, 22 May 2012 10:04:23 -0500
Message-ID: <4FBBAAF7.3030007@ti.com>
References: <1337124956-20133-1-git-send-email-jon-hunter@ti.com> <4FBA742D.6020800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42770 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755444Ab2EVPEX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 11:04:23 -0400
In-Reply-To: <4FBA742D.6020800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Benoit,

On 05/21/2012 11:58 AM, Cousson, Benoit wrote:
> Hi Jon,
> 
> On 5/16/2012 1:35 AM, Jon Hunter wrote:
>> From: Jon Hunter<jon-hunter@ti.com>
>>
>> Currently, the dmtimer determines whether an timer can support an
>> external
>> clock source (sys_altclk) for driving the timer by the IP version. Only
>> OMAP24xx devices can support an external clock source, but the IP version
>> between OMAP24xx and OMAP3xxx is common and so this incorrectly indicates
>> that OMAP3 devices can use an external clock source.
>>
>> Rather than use the IP version, use the OMAP_TIMER_HAS_ALTCLK flag added
>> to the HWMOD timer device attributes. By doing this, this allows us to
>> eliminate the "timer_ip_version" variable passed as part of the
>> platform data.
> 
> I do not think this is the right way to handle that. The timer IP itself
> does have only one input clock.
> This is the mux before that clock that will have several inputs
> depending on the SoC revision.
> So this is purely PRCM stuff and has nothing to do with the timer IP
> itself.
> 
> The OMAP_TIMER_HAS_ALTCLK is thus not a timer IP information and cannot
> be stored inside timer hwmod.

Ok, understood.

> In fact, if the alt clock is there the "alt_clk" alias will be there and
> thus you can use the clk_get(dev, "alt_clk") to figure out if the clock
> is there or not.

Ok, I can do this and did think about it, but then wondered why it had
been done this way in the first place? However, I prefer this approach
too as it simplifies the code :-)

So I modify how this is handled.

Cheers
Jon

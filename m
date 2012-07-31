From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP3xxx: clockdomain: fix software supervised wakeup/sleep
Date: Tue, 31 Jul 2012 13:12:47 -0500
Message-ID: <5018201F.7020206@ti.com>
References: <alpine.DEB.2.00.1207261503290.14468@utopia.booyaka.com> <50122A75.2030108@ti.com> <501761E8.3030307@ti.com> <50176FEF.6060600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53991 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628Ab2GaSMp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 14:12:45 -0400
In-Reply-To: <50176FEF.6060600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra,

On 07/31/2012 12:41 AM, Rajendra Nayak wrote:
> Hi Jon,
> 
> On Tuesday 31 July 2012 10:11 AM, Jon Hunter wrote:
>> Hi Paul, Rajendra,
>>
>> On 07/27/2012 12:43 AM, Rajendra Nayak wrote:
>>> On Friday 27 July 2012 02:34 AM, Paul Walmsley wrote:
>>>>
>>>> Commit 4da71ae6 ("OMAP: clockdomain: Arch specific funcs for
>>>> clkdm_clk_enable/disable") called the OMAP2xxx-specific functions for
>>>> clockdomain wakeup and sleep.  This would probably have broken
>>>> software-supervised clockdomain wakeup and sleep on OMAP3.
>>>
>>> Its strange this went unnoticed for so long. Thanks for this fix and
>>> sorry about introducing the bug in the first place.
>>
>> Any chance that's because of the following code? I needed to
>> remove this to get the EMU clock domain to turn off on OMAP3
>> whilst testing PMU.
> 
> No, this doesn't seem right. We still have clockdomains for omap2/3
> controlled using clkdm_clk_enable/disable functions called from
> within clk framework, and not clkdm_hwmod_enable/disable from
> within hwmod framework.
> Besides you removing these checks only in clkdm_hwmod_disable (and
> keeping them in clkdm_hwmod_enable) tells me its just hiding some
> usecounting issues you were having with clkdm_clk_enable/disable.

Yes you are right. I was focused in the disable side because the EMU CD
is staying on.

> Btw, on OMAP2/3 as long as a domain has interface clocks which are
> explicitly enabled and autoidled, the clkdm usecount never ends up
> going to 0, which is probably what you are hit with too.

Yes so after further debugging, this is not a problem and not the cause
of my problem either.

Sorry for the noise.

Cheers
Jon

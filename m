From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] save and restore etm state across core OFF modes
Date: Tue, 12 Jan 2010 11:33:13 -0600
Message-ID: <4B4CB259.2010301@ti.com>
References: <1263315891-4440-1-git-send-email-virtuoso@slind.org> <4B4CADA9.4020502@ti.com> <20100112173022.GG29059@shisha.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37800 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab0ALRdR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 12:33:17 -0500
In-Reply-To: <20100112173022.GG29059@shisha.kicks-ass.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Woodruff, Richar

Alexander Shishkin had written, on 01/12/2010 11:30 AM, the following:
> On Tue, Jan 12, 2010 at 11:13:13 -0600, Nishanth Menon wrote:
>> Alexander Shishkin had written, on 01/12/2010 11:04 AM, the following:

>>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
>>> index 69521be..0a5ec86 100644
>>> --- a/arch/arm/mach-omap2/sleep34xx.S
>>> +++ b/arch/arm/mach-omap2/sleep34xx.S
[...]
>>> 	/* Store current cpsr*/
>>> 	mrs	r2, cpsr
>>> 	stmia	r8!, {r2}
>>> @@ -520,6 +616,7 @@ clean_caches:
>>> 	cmp	r9, #1 /* Check whether L2 inval is required or not*/
>>> 	bne	skip_l2_inval
>>> clean_l2:
>>> +#if 0
>> my aversion to #if 0 kicks in here :(.. do we have an alternative
>> like using the CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG or something
>> else?
> 
> Fair enough. I could replace it with "#if !defined(...)" as the first
> thing that comes to mind. This way it will only take disabling the
> config option to catch any possible regressions in between. Does this
> sound reasonable?
sounds ok to me.. unless folks have ideas coz of clean_l2 label.. more 
comments might be useful before a rev2 of the patch..

-- 
Regards,
Nishanth Menon

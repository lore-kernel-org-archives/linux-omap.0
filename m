From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC][PATCH v2] OMAP: McBSP: Use register cache
Date: Sat, 28 Nov 2009 18:14:39 +0200
Message-ID: <20091128181439.8e5a7d99.jhnikula@gmail.com>
References: <200908121239.26346.jkrzyszt@tis.icnet.pl>
	<200911241231.18333.jkrzyszt@tis.icnet.pl>
	<20091126100000.add50e72.jhnikula@gmail.com>
	<200911261425.39562.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55271 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbZK1QNe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Nov 2009 11:13:34 -0500
Received: by bwz27 with SMTP id 27so1679459bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 28 Nov 2009 08:13:39 -0800 (PST)
In-Reply-To: <200911261425.39562.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi

On Thu, 26 Nov 2009 14:25:36 +0100
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

> 1. Is there any point for caching data written to DXR registers?
> 
> 2. There is at least one register, WAKEUPEN, never updated bit by bit, but 
> always rewritten from scratch with a few different values that can be 
> computed easily from other msbsp structure member values. For these rare 
> cases, is it any worth to bypass the cache while writing them, saving a few 
> instructions maybe?
> 
I would say it's better to favor simplicity and uniformity first.
Trying to avoid caching for few registers makes the cache code harder to
follow, more error prone and may not save the total memory footprint.

> 3. Sometimes a register is written several times in succession with different 
> values, like SYSCON inside omap34xx_mcbsp_free(), for example. Could all 
> writes but the last one bypass the cache for the same reason?
> 
> Another axample is omap_mcbsp_start() fiddling with SPCR2 several times. 
> However, there is a udelay(500) inbetween that I am not sure if can ever 
> happen to be interleaved with a concurrent suspend or idle or something like 
> that requiring the cache being up-to-date.
> 
I'm not sure about SYSCON but there are registers like SPCR2 where
specifications and practical findings define the minimum times between
activating the logic so caching must not optimize those away.

> That said, please confirm if a single write macro with caching still seems 
> sufficient, or a separate one without caching would provide enough benefits 
> to keep it as well.
> 
Single write with caching would be sufficient I would say.

> I just tried to minimize line wrapping :/. If we agree on a single caching 
> version of OMAP_MCBSP_WRITE(), what about OMAP_CACHE_READ()? If no better 
> ideas, I'll use what you suggest.
> 
Ok, I see. How about these? OMAP is obvious in this case so we can drop
it off from macro names.

MCBSP_WRITE
MCBSP_READ
MCBSP_READ_CACHE

> 1. All macros accept very same arguments, as long as applicable.
>    This is what I have put in my patch.
> 
Definitely this. Pass instance of "struct omap_mcbsp" as you did since
all other data is found from there.

> > I was thinking that should these read+read_cache changes be a separate
> > patch for fixing the 1510 issues since no other OMAPs are known to
> > corrupt registers and plain hw read is enough for them.
> 
> I see. Do you want the change limited to cpu_is_omap1510() case only?
> 
I think that's not necessary. The separate patch would explain that the
change is fixing 1510 issue and the code is fine for other OMAPs as
well.

> The only issue I am not satisfied how I have dealt with so far is SYSCON 
> register case. I have noticed that the register is never initialized like 
> others , but always updated based on values read back from hardware. 
> Initially I didn't find any good idea how to deal with this in respect of 
> caching, so decided to take an intermediate path: read from hardware, then 
> write with caching, even if the cached value is never referred for now. Here 
> is the relevant part of my patch:
> 
Probably simplest and safest is to do so that one patch will change the
macro arguments and rename them, another introducing caching with
adding _READ_CACHE and then one for 1510 fix. Then the code behaves the
same and more _READ_CACHE changes can be introduced gradually by
anothers if needed.


-- 
Jarkko

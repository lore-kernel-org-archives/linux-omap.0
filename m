From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] cpufreq: OMAP: fix build errors: depends on ARCH_OMAP2PLUS
Date: Fri, 13 Apr 2012 14:31:05 -0700
Message-ID: <87pqbb5nfq.fsf@ti.com>
References: <1332807568-638-1-git-send-email-khilman@ti.com>
	<4F7CC926.5050300@ti.com>
	<20120413185322.GG25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:60588 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752403Ab2DMVbH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 17:31:07 -0400
Received: by pbcwz17 with SMTP id wz17so4144731pbc.41
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 14:31:06 -0700 (PDT)
In-Reply-To: <20120413185322.GG25053@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 13 Apr 2012 19:53:22 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Wed, Apr 04, 2012 at 03:20:22PM -0700, Kevin Hilman wrote:
>> Hi Dave,
>>
>> On 03/26/2012 05:19 PM, Kevin Hilman wrote:
>>> The OMAP driver needs a 'depends on ARCH_OMAP2PLUS' since it only
>>> builds for OMAP2+ platforms.
>>>
>>> This 'depends on' was in the original patch from Russell King, but was
>>> erroneously removed by me when making this option user-selectable in
>>> commit b09db45c (cpufreq: OMAP driver depends CPUfreq tables.)  This
>>> patch remedies that.
>>>
>>> Apologies to Russell King for breaking his originally working patch.
>>>
>>> Also, thanks to Grazvydas Ignotas for reporting the same problem.
>>>
>>> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
>>> Cc: Grazvydas Ignotas<notasas@gmail.com>
>>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>>> ---
>>> Dave, this applies on top of your current fixes branch, and fixes a
>>> problem introduced there by me.  Please merge for v3.4-rc.  Thanks.
>>
>> Can you pick this up for v3.4-rc?
>
> Right, I'm fed up with chasing over this trivial patch.  It's been almost
> a full month since the problem was first reported and it _still_ remains
> unfixed in mainline, despite me chasing over it.  So, sorry, you lose.
>
> I'm merging my fix (attached) which I've been running against the nightly
> builds into my fixes branch and will ask Linus to pull it this weekend.
> If you want something else, then please send a patch on top of my fix to
> do what you want.
>
> Alternatively, send a replacement fix to Linus _before_ Sunday evening
> copying me with it and I'll drop this from my tree.  But I want to see
> an alternative going to Linus for that to happen.

I've (re)sent the patches now.

I just resent the CPUfreq driver Kconfig fix, this time directly to Linus.

I also just resent the arch/arm/mach-omap2 one to Tony/Paul with a
slightly updated changelog making it clear that removing that dead code
also fixes build errors so it can be queued ASAP for v3.4-rc.

Combined, those fix the problems your patch addresses.

Kevin


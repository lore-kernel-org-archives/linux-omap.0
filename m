From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM/ARM-SoC plans for v3.4 merge window
Date: Tue, 24 Jan 2012 09:50:09 +0000
Message-ID: <20120124095009.GS16726@n2100.arm.linux.org.uk>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38862 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab2AXJuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 04:50:22 -0500
Content-Disposition: inline
In-Reply-To: <20120123114902.GY1068@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-tegra@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>

On Mon, Jan 23, 2012 at 11:49:02AM +0000, Russell King - ARM Linux wrote:
> This is an outline of the plan for this cycle, up to the next merge
> window, agreed between Olof and myself.
> 
> As Nicolas' idle changes weren't merged before the last merge window
> opened, we have decided that Nicolas will resubmit his changes after
> -rc1 (in other words, now) and they will be merged into both the
> arm-soc and my trees.
> 
> I have at least one other patch which has a high 'will cause horrible
> conficts' rating (the debug option rearrangement patch), so I'll be
> including that for the arm-soc tree as well.
> 
> However, what this does mean is that Arnd, Olof, and myself will be
> in for up to three months of merge hell unless people take account of
> these changes.
> 
> Therefore, our plan is to publish this as a baseline, and we'd really
> appreciate any development submitted after that baseline has been
> established is based upon those changes and does not conflict with
> them.  That may mean you have to pull these changes into your tree
> and merge them into your development work (and fix up any conflicts
> there yourself.)
> 
> Once you've taken these changes into your tree, you must not rebase or
> modify them.  Changing those commits will cause all hell to break loose,
> and we'll have to refuse merging your tree (otherwise we'll be in Linus'
> sights for a roasting at gas mark 2 million.)

Right, although it's out there - but I'd like to get the AMBA changes
into it which are already conflicting the Samsung development.  So I'm
going to hold off officially asking for people to include the baseline
until this evening.  At that point, I will shut down my 'amba' branch
and transfer that over; that means I won't be accepting any further
acks etc for that work.

If you haven't acked changes in the amba branch (eg, to Versatile,
Realview etc) then it'll soon be too late...

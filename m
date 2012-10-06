From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
	HYP mode
Date: Sat, 6 Oct 2012 16:42:41 +0100
Message-ID: <20121006154241.GB28061@n2100.arm.linux.org.uk>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com> <1347036934-8519-3-git-send-email-marc.zyngier@arm.com> <20121005200822.GQ3874@atomide.com> <6d3553bfe8a2d1ac88cab852100616a7@localhost> <20121006144252.GY3874@atomide.com> <alpine.LFD.2.02.1210061129080.16518@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47457 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab2JFPmz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 11:42:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1210061129080.16518@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Oct 06, 2012 at 11:32:16AM -0400, Nicolas Pitre wrote:
> On Sat, 6 Oct 2012, Tony Lindgren wrote:
> > * Marc Zyngier <marc.zyngier@arm.com> [121006 03:19]:
> > 
> > > If so, that indicates some side effect of the safe_svcmode_maskall macro,
> > > and I suspect the "movs pc, lr" bit.
> > > 
> > > Can you try the attached patch? It basically falls back to the previous
> > > behaviour if not entered in HYP mode.
> > 
> > Yes, with this it boots OK.
> 
> OK. In that case, I suggest this patch be sent to Russell to fix this 
> issue so he could push the ARM stuff to Linus ASAP.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

I've already sent the pull request (it's late enough already for the
first bunch of stuff... Linus' truely brilliant timing for the N'th
time sees the merge window open when I'm away - why does he keep doing
that to me?) for everything _except_ stuff in my 'devel-stable' branch,
which includes the opcodes, virt, and new cache maintanence stuff.

I won't be sending Linus another pull request until at least three
days after he merges the current request, so we'll just have to hope
that this doesn't turn out to be a short merge window...

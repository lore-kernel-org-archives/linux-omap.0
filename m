From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: Implemented support for VFP PM context saving
Date: Tue, 24 Nov 2009 15:19:18 +0000
Message-ID: <20091124151918.GB14462@n2100.arm.linux.org.uk>
References: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com> <1259059024-23719-2-git-send-email-tero.kristo@nokia.com> <20091124114836.GA10510@n2100.arm.linux.org.uk> <1259068826.13956.22.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33945 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320AbZKXPTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 10:19:50 -0500
Content-Disposition: inline
In-Reply-To: <1259068826.13956.22.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Estes <cestes@quicinc.com>

On Tue, Nov 24, 2009 at 01:20:26PM +0000, Catalin Marinas wrote:
> BTW, the two patches below were mentioned to me some time ago but I
> haven't got the time to look at them:
> 
> [ARM] vfp: Fix bug in vfp_pm_suspend
> https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=commit;h=88984c9b2d69c222ee1e2afc948ca73f597d40ff

This one is bad - it gets the current CPU by directly referencing ti->cpu.
Too bad if you have kernel preemption enabled; the value obtained that
way is effectively meaningless.  The only way to get a meaningful value
is via 'get_cpu()' and after you've done with using it, 'put_cpu()'.
That ensures you can't be preempted onto a different CPU mid-operation.

It's safe in vfp_notifier because we're called in an already atomic context.

> [ARM] vfp: Add additional vfp interfaces
> https://www.codeaurora.org/gitweb/quic/le/?p=kernel/msm.git;a=commit;h=393e4bfaaf79377d29cd6bb2228f87601aeca668

I don't like what's in this one.  Lack of explaination in the commit log
doesn't help.

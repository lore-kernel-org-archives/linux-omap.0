From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6
Date: Fri, 19 Mar 2010 03:46:45 +0000
Message-ID: <20100319034645.GG14108@shareable.org>
References: <20100317175731.GE2900@atomide.com> <1268849278.19565.28.camel@e102109-lin.cambridge.arm.com> <20100317191114.GH2900@atomide.com> <1268910826.15334.32.camel@e102109-lin.cambridge.arm.com> <20100318170021.GN2900@atomide.com> <20100319013521.GP2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:48144 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab0CSDqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 23:46:49 -0400
Content-Disposition: inline
In-Reply-To: <20100319013521.GP2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren wrote:
> Also, I wonder if the change __kuser_get_tls is safe?
> 
> +	ldr     r0, [pc, #(16 - 8)]		@ TLS set at 0xffff0ff0?
> +	cmp	r0, #0				@ assume hw TLS if not set
> +	mrceq	p15, 0, r0, c13, c0, 3		@ read TLS register

You cannot assume the TLS value is non-zero, because it's provided by
userspace to use however it wants.  It doesn't even have to be an address.

I'm thinking, why not an alternative() macro like on x86, which is a
very nice way to describe run-time patches of one or a few instructions
which depend on arch feature bits.

Then all that switch_to() logic could be made the size it was before.

An alternative() macro could make a lot of other chip-dependent calls
smaller too, i.e. all those which dispatch through function pointers
at present for cache flushing etc - they could become direct calls, or
an inline instruction or two when possible.

-- Jamie

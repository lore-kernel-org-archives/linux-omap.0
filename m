From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Mon, 17 Jan 2011 14:21:07 -0800
Message-ID: <20110117222107.GB4957@atomide.com>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15848 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879Ab1AQWVU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 17:21:20 -0500
Content-Disposition: inline
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110117 11:20]:
> This patch series reworks the ARMv6/ARMv6K support options, code
> selection, and bit operations such that it's possible to safely
> build a kernel which supports ARMv6, ARMv6K, ARMv7 and ARMv7 SMP
> in one image.
> 
> Currently, we use CPU_V6 for both ARMv6 and ARMv6K, setting CPU_32v6K
> if we have the K extensions.  CPU_32v6K directly controlled whether
> we should include the ARMv6K instructions (clrex, load/store exclusive
> byte, half-word, double).  As the bitops code uses the load/store
> exclusive byte operations, unsetting CPU_32v6K results in these
> falling back to their non-SMP local-irq-disabling variants.  These
> are only safe in uniprocessor environments.
> 
> So, the first two patches convert the bitops to use the ARMv6 load/store
> exclusive word operations - and ensuring correctness by ensuring that
> the pointer passed in is word-aligned.
> 
> We then introduce a new CPU_V6K which indicates that we're including
> an ARMv6K CPU in the build, which frees up CPU_V6 to mean that we're
> including an ARMv6 non-K CPU.
> 
> We can then use CPU_V6 to ensure that the non-v6K code paths which are
> still SMP safe are selected.
> 
> Without this patch set, such a kernel will be unsafe when run on
> SMP platforms as it omits necessary SMP code to ensure that bit
> operations are safe.

Amazing, based on a quick test this series boots just fine on non-v6K
omap2420 using omap2plus_defconfig :)

Tony

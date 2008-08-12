From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM TLB: add v7wbi_{possible,always}_flags to
	{possible,always}_tlb_flags
Date: Tue, 12 Aug 2008 15:42:13 +0300
Message-ID: <20080812124212.GK6705@atomide.com>
References: <alpine.DEB.1.00.0808111358280.10219@utopia.booyaka.com> <1218528106.22045.8.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58659 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254AbYHLMlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 08:41:07 -0400
Content-Disposition: inline
In-Reply-To: <1218528106.22045.8.camel@pc1117.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, buytenh@wantstofly.org

* Catalin Marinas <catalin.marinas@arm.com> [080812 11:02]:
> On Mon, 2008-08-11 at 14:03 -0600, Paul Walmsley wrote:
> > Commit 2ccdd1e77da52ad494e9af46bf272d816830cb28 doesn't add 
> > v7wbi_possible_flags and v7wbi_always_flags to possible_tlb_flags and 
> > always_tlb_flags.  This causes the L2 cache flush in clean_pmd_entry() 
> > (intended for Feroceon only) to execute on ARMv7, and the CPU hangs.
> > 
> > This patch is required for OMAP3 boards to boot.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: <catalin.marinas@arm.com>
> > Cc: <buytenh@wantstofly.org>
> 
> Acked-by me as well. I posted it last month as well but I was waiting
> for the include stuff to settle down. 
> 
> http://article.gmane.org/gmane.linux.ports.arm.kernel/44729

I'll apply Paul's patch to l-o tree while waiting for it to fall down
from mainline.

Tony

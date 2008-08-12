From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM TLB: add v7wbi_{possible,always}_flags to
	{possible,always}_tlb_flags
Date: Tue, 12 Aug 2008 09:01:46 +0100
Message-ID: <1218528106.22045.8.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808111358280.10219@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:51641 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750808AbYHLICB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Aug 2008 04:02:01 -0400
In-Reply-To: <alpine.DEB.1.00.0808111358280.10219@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, buytenh@wantstofly.org

On Mon, 2008-08-11 at 14:03 -0600, Paul Walmsley wrote:
> Commit 2ccdd1e77da52ad494e9af46bf272d816830cb28 doesn't add 
> v7wbi_possible_flags and v7wbi_always_flags to possible_tlb_flags and 
> always_tlb_flags.  This causes the L2 cache flush in clean_pmd_entry() 
> (intended for Feroceon only) to execute on ARMv7, and the CPU hangs.
> 
> This patch is required for OMAP3 boards to boot.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: <catalin.marinas@arm.com>
> Cc: <buytenh@wantstofly.org>

Acked-by me as well. I posted it last month as well but I was waiting
for the include stuff to settle down. 

http://article.gmane.org/gmane.linux.ports.arm.kernel/44729

-- 
Catalin


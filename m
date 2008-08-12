From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM TLB: add v7wbi_{possible, always}_flags to
	{possible, always}_tlb_flags
Date: Tue, 12 Aug 2008 09:02:44 +0100
Message-ID: <1218528164.22045.10.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808111358280.10219@utopia.booyaka.com>
	 <20080811220806.GC21996@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:51755 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548AbYHLIDA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Aug 2008 04:03:00 -0400
In-Reply-To: <20080811220806.GC21996@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, 2008-08-11 at 23:08 +0100, Russell King - ARM Linux wrote:
> On Mon, Aug 11, 2008 at 02:03:10PM -0600, Paul Walmsley wrote:
> > Commit 2ccdd1e77da52ad494e9af46bf272d816830cb28 doesn't add 
> > v7wbi_possible_flags and v7wbi_always_flags to possible_tlb_flags and 
> > always_tlb_flags.  This causes the L2 cache flush in clean_pmd_entry() 
> > (intended for Feroceon only) to execute on ARMv7, and the CPU hangs.
> 
> And this most definitely is required.  One wonders how any ARMv7
> platform could boot without this.  Please submit to the patch
> system, I don't think any further acks are required.

It is a bug indeed but not visible until commit 99c6dc11
(Feroceon-specific TLB flushing which is undefined on ARMv7).

-- 
Catalin


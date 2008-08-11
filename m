From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM TLB: add v7wbi_{possible,always}_flags to {possible,always}_tlb_flags
Date: Mon, 11 Aug 2008 23:08:06 +0100
Message-ID: <20080811220806.GC21996@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0808111358280.10219@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46131 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758402AbYHKWIR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Aug 2008 18:08:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808111358280.10219@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, Aug 11, 2008 at 02:03:10PM -0600, Paul Walmsley wrote:
> Commit 2ccdd1e77da52ad494e9af46bf272d816830cb28 doesn't add 
> v7wbi_possible_flags and v7wbi_always_flags to possible_tlb_flags and 
> always_tlb_flags.  This causes the L2 cache flush in clean_pmd_entry() 
> (intended for Feroceon only) to execute on ARMv7, and the CPU hangs.

And this most definitely is required.  One wonders how any ARMv7
platform could boot without this.  Please submit to the patch
system, I don't think any further acks are required.

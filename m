From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: "Flush the D-cache during copy_user_highpage" breaks compile
	for v7 on -rc1
Date: Fri, 18 Dec 2009 08:18:52 +0000
Message-ID: <20091218081851.GB28704@n2100.arm.linux.org.uk>
References: <20091218031923.GA4575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59277 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZLRITR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 03:19:17 -0500
Content-Disposition: inline
In-Reply-To: <20091218031923.GA4575@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 17, 2009 at 07:19:24PM -0800, Tony Lindgren wrote:
> Hi Catalin,
> 
> You may have already run into this, but if not, looks like commit
> 115b22474eb1905da2f606a057da3455833333d3 breaks compile for v7:
> 
> arch/arm/mm/copypage-v6.c: In function 'v6_copy_user_highpage_nonaliasing':
> arch/arm/mm/copypage-v6.c:51: error: implicit declaration of function '__cpuc_flush_dcache_page'
> 
> Undoing that makes it work again.

It's a combination of changes - my initial changes for fixing the ARMv7
DMA support went in last night, but were based on a tree older than
Catalin's changes, which had already been committed.

My test build didn't catch any of these - it's the usual problem that
there is no way to adequately build-test the ARM kernel in a reasonable
time anymore.

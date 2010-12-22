From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: fix typo in OMAP3_IVA_MASK
Date: Wed, 22 Dec 2010 10:59:24 -0800
Message-ID: <20101222185924.GC7771@atomide.com>
References: <1293041676-1206-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47704 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab0LVS72 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 13:59:28 -0500
Content-Disposition: inline
In-Reply-To: <1293041676-1206-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Arno Steffen <arno.steffen@googlemail.com>

* Nishanth Menon <nm@ti.com> [101222 10:14]:
> From: Arno Steffen <arno.steffen@googlemail.com>
> 
> OMAP3_IVA_MASK should use OMAP3_IVA_SHIFT instead of OMAP3_SGX_SHIFT
> 
> Signed-off-by: Arno Steffen <arno.steffen@googlemail.com>
> ---
> Tony,
> 	looking at head:
> 	http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/mach-omap2/control.h/control.h;h=6e5f7e512ff7da063dbeb9448670f38cefd486e6;hb=HEAD
> 	This is a missing fix we have'nt incorporated yet.
> 
> V2: posted to l-o and l-a and rebased to 2.6.37-rc7
> 
> V1: http://marc.info/?t=129077184800003&r=1&w=2

Thanks, will queue.

Tony

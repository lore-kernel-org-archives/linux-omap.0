From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/2] OMAP: TWL: sparse fixes
Date: Wed, 5 Jan 2011 00:25:49 +0000
Message-ID: <20110105002549.GA1445@n2100.arm.linux.org.uk>
References: <1294081110-23695-1-git-send-email-nm@ti.com> <20110103223656.GA8414@n2100.arm.linux.org.uk> <4D22503F.9060100@ti.com> <4D238503.6070103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42721 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab1AEAZ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 19:25:59 -0500
Content-Disposition: inline
In-Reply-To: <4D238503.6070103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tony <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 04, 2011 at 02:37:23PM -0600, Nishanth Menon wrote:
> hmm.. minor nit (with codesourcery 2010.09-50 - 4.5.1):
> rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/ 2>Kerr;make C=2  
> arch/arm/mach-omap2/ 2>Kerr1;diff Kerr Kerr1
> [..]
> 1,4d0
> < arch/arm/mach-omap2/mux.c: In function 'omap_mux_get_by_name':
> < arch/arm/mach-omap2/mux.c:163:17: warning: 'found_mode' may be used  
> uninitialized in this function
> < arch/arm/mach-omap2/clkt_clksel.c: In function 'omap2_clksel_set_parent':
> < arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may be  
> used uninitialized in this function
>
> Kinda interesting to note that C=2 does'nt list all potential gcc  
> warnings :( if one wanted a collated list of all warnings, rm .../*.o  
> helps I guess.

C=2 only runs sparse - so if you're committing patches to fix sparse
warnings, that's what you should be interested in.

I'd suggest that fixing sparse warnings and GCC warnings in a single
patch is probably not the best thing to do - GCC warnings are less
subjective than sparse warnings.

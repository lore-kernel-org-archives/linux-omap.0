From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: SRAM: resolve sparse warnings
Date: Tue, 1 Jan 2013 10:15:09 -0800
Message-ID: <20130101181508.GB22106@atomide.com>
References: <20121224012304.13698.43551.stgit@dusk.lan>
 <20121224012500.13698.73653.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:38226 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752435Ab3AASPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jan 2013 13:15:10 -0500
Content-Disposition: inline
In-Reply-To: <20121224012500.13698.73653.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121223 17:30]:
> Commit bb77209432873214a796a70a4539e4ebdf3feb54 ("ARM: OMAP: Move
> omap2+ specific parts of sram.c to mach-omap2") adds some new sparse
> warnings:
> 
> arch/arm/plat-omap/sram.c:43:6: warning: symbol 'omap_sram_push_address' was not declared. Should it be static?
> arch/arm/plat-omap/sram.c:65:6: warning: symbol 'omap_sram_reset' was not declared. Should it be static?
> arch/arm/plat-omap/sram.c:73:13: warning: symbol 'omap_map_sram' was not declared. Should it be static?
> 
> Fix by creating a temporary header file containing prototypes for
> these SRAM functions - needed until the SRAM code is moved to
> drivers/.  arch/arm/plat-omap/include/plat/sram.h can't be added due
> to ARM CONFIG_ARCH_MULTIPLATFORM restrictions on the use of the "plat/"
> include path shortcut.

Here too we should just include <plat/sram.h>, that's OK for the
multiplatform builds. Just drivers will not have it available.
Then eventually the issue disappears as this code becomes a regular
device driver.

Regards,

Tony

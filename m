From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Drop remaining plat/cpu.h usage where
 possible
Date: Sun, 16 Dec 2012 12:05:34 -0800
Message-ID: <20121216200533.GQ4989@atomide.com>
References: <20121214194325.9874.95898.stgit@muffinssi.local>
 <20121214194450.9874.57095.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42768 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752010Ab2LPUFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Dec 2012 15:05:37 -0500
Content-Disposition: inline
In-Reply-To: <20121214194450.9874.57095.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>

* Tony Lindgren <tony@atomide.com> [121214 11:47]:
> These macros are now in local soc.h in arch/arm/mach-omap2,
> and plat/cpu.h is around only until the remaining drivers
> are fixed.
> 
> Also remove the unused plat/cpu.h from smartreflex.c as it
> will cause compile errors with ARCH_MULTIPLATFORM enabled.

Looks like we can remove it completely, so posted an updated
patch.

Tony

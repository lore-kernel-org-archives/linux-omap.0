From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V2 2/4] ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to
 dpll3xxx.c
Date: Thu, 10 May 2012 17:02:11 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205101701420.32719@utopia.booyaka.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com> <1336506724-5494-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48792 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800Ab2EJXCM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 19:02:12 -0400
In-Reply-To: <1336506724-5494-3-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, 9 May 2012, Vaibhav Hiremath wrote:

> In order to remove unnecessary idefs, move noncore and core
> dpll ops to dpll3xxx.c file (where it should have been already).
> 
> The clkops (clkops_omap3_core_dpll_ops & clkops_omap3_noncore_dpll_ops)
> is used in clock data files, and dependency is already handled by
> Makefile rule.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

This is probably okay.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul

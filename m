From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/3] ARM: omap: clk: Remove all direct dereferencing
 of struct clk
Date: Fri, 29 Jun 2012 14:23:34 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206291422050.2338@utopia.booyaka.com>
References: <1340786915-29507-1-git-send-email-rnayak@ti.com> <1340786915-29507-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41524 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268Ab2F2UXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 16:23:34 -0400
In-Reply-To: <1340786915-29507-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi

On Wed, 27 Jun 2012, Rajendra Nayak wrote:

> While we move to Common Clk Framework (CCF), direct deferencing of struct
> clk wouldn't be possible anymore. Hence get rid of all such instances
> in the current clock code and use macros/helpers similar to the ones that
> are provided by CCF.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

This patch generates checkpatch warnings.  Here's a sample:

WARNING: quoted string split across lines
#479: FILE: arch/arm/mach-omap2/clock.c:109:
 		pr_debug("clock: could not associate clk %s to "
+			 "clkdm %s\n", clk_name, clk->clkdm_name);

CHECK: Alignment should match open parenthesis
#594: FILE: arch/arm/mach-omap2/dpll3xxx.c:455:
+	if (__clk_get_rate(dd->clk_bypass) == rate &&
 	    (clk->dpll_data->modes & (1 << DPLL_LOW_POWER_BYPASS))) {

ERROR: Macros with complex values should be enclosed in parenthesis
#706: FILE: arch/arm/plat-omap/include/plat/clock.h:22:
+#define __clk_get_name(clk) clk->name

In the case of the quoted string warnings, please go ahead and
concatenate those strings while you are there.  That needs to be done
anyway.


- Paul

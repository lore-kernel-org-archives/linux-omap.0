From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 2/4] ARM: OMAP2+: CLEANUP: Move omap3 dpll ops to
 dpll3xxx.c
Date: Fri, 11 May 2012 07:01:19 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA221FF@DBDE01.ent.ti.com>
References: <1336506724-5494-1-git-send-email-hvaibhav@ti.com>
 <1336506724-5494-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1205101701420.32719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53004 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754829Ab2EKHBe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 03:01:34 -0400
In-Reply-To: <alpine.DEB.2.00.1205101701420.32719@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, May 11, 2012 at 04:32:11, Paul Walmsley wrote:
> On Wed, 9 May 2012, Vaibhav Hiremath wrote:
> 
> > In order to remove unnecessary idefs, move noncore and core
> > dpll ops to dpll3xxx.c file (where it should have been already).
> > 
> > The clkops (clkops_omap3_core_dpll_ops & clkops_omap3_noncore_dpll_ops)
> > is used in clock data files, and dependency is already handled by
> > Makefile rule.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> 
> This is probably okay.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> 

Thanks Paul,

Thanks,
Vaibhav

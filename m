From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP baseline test results for v3.13-rc1 (toolchain Debian
 4.7.2-5)
Date: Mon, 9 Dec 2013 09:16:18 -0800
Message-ID: <20131209171618.GC11433@atomide.com>
References: <alpine.DEB.2.02.1311250731410.1364@utopia.booyaka.com>
 <alpine.DEB.2.02.1311251514330.1364@utopia.booyaka.com>
 <alpine.DEB.2.02.1312090936530.32309@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40955 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755766Ab3LIRQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Dec 2013 12:16:22 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1312090936530.32309@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.linaro.org

* Paul Walmsley <paul@pwsan.com> [131209 01:55]:
> On Mon, 25 Nov 2013, Paul Walmsley wrote:
> 
> > On Mon, 25 Nov 2013, Paul Walmsley wrote:
> > 
> > > Boot to userspace:
> > >     FAIL ( 1/11): 37xxevm
> > 
> > So looks like this is due to the switchover to DT-based booting for 37xx 
> > EVM.  Will plug that in here and re-test.
> 
> Here's the updated test report.  Looks like dynamic idle PM tests are 
> failing on the 37xxevm now.

Off-idle and wake-up events work but need these two pending patches:

1. [PATCH] of/platform: Fix no irq domain found errors when populating interrupts
   http://lkml.org/lkml/2013/11/22/520

2. [PATCH] ARM: dts: Fix omap serial wake-up when booted with device tree
   http://www.spinics.net/lists/devicetree/msg13374.html

Without the first one we get some nasty looking harmless warnings, so I've
been holding off to merging #2 until #1 is fixed.

Regards,

Tony

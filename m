From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap1: Fix booting for 15xx and 730 with
 omap1_defconfig (Re: State of LDP3430 platform)
Date: Tue, 18 Jan 2011 15:21:03 -0800
Message-ID: <20110118232102.GU4957@atomide.com>
References: <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
 <20110115000301.GT4957@atomide.com>
 <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
 <20110115233744.GA18159@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
 <4D3309F9.8090900@gmail.com>
 <alpine.DEB.2.00.1101181234130.13225@utopia.booyaka.com>
 <20110118222613.GS4957@atomide.com>
 <20110118223536.GT4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10240 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1ARXVT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 18:21:19 -0500
Content-Disposition: inline
In-Reply-To: <20110118223536.GT4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Weber <thomas.weber.linux@googlemail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

* Tony Lindgren <tony@atomide.com> [110118 14:34]:
> For omap15xx and 730 we need to use the MPU timer
> as the 32K timer is not available. For omap16xx
> we want to use the 32K timer because of PM. Fix this
> by allowing to build in both timers.

This still needs one more patch to deal with the
sched_clock for MPU timer..

Tony

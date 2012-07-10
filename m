From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430
 SOC
Date: Tue, 10 Jul 2012 01:37:27 -0700
Message-ID: <20120710083726.GN1122@atomide.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com>
 <20120709131156.GH1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA69538@DBDE01.ent.ti.com>
 <20120710081851.GL1122@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA699A3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27674 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab2GJIhc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 04:37:32 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA699A3@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120710 01:35]:
> On Tue, Jul 10, 2012 at 13:48:52, Tony Lindgren wrote:
> > 
> > No thanks.. We don't want to make it 32 bit and bloat all the compiled in
> > clock even further. 
> > 
> 
> In that case, how about just get rid of cpu_mask completely and trust the 
> data passed by clock-tree for clksel dividers?
> Let clock-tree data handle this, even if in some cases we end up in 
> duplicating data for some clocks??

Yes something like that. We already know which clocks need to
be registered, so whatever we still use CK_XXXX for should be also
initialized in omapxxxx_clk_init() functions.

Regards,

Tony

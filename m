From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND v8 3/7] omap: gpmc: enable irq mode in gpmc
Date: Tue, 25 Jan 2011 08:57:35 -0800
Message-ID: <20110125165735.GL13589@atomide.com>
References: <1295443503-14515-1-git-send-email-s-ghorai@ti.com>
 <1295443503-14515-4-git-send-email-s-ghorai@ti.com>
 <20110121184020.GD11678@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB549@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60112 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab1AYQ5z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 11:57:55 -0500
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B036A8DB549@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Ghorai, Sukumar <s-ghorai@ti.com> [110122 09:53]:
> > 
> > I think I've commented on this before, but why don't you make gpmc_init
> > a subsys_initcall? There should be no reason to call this earlier.
> > If something does not work because of that, then that issue must be
> > fixed.
> 
> [Ghorai] You suggested the same in previous v5 and v6; and I mentioned 
> the issues [1] that - nand_init()called before subsys_initcall(gpmc_init);
> Let me know if I am missing anything again.

There should not be any need to call nand_init early either. We want
to initialize as much as possible late so we have proper console
error messages.

Tony

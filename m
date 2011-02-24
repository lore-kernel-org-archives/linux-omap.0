From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmodright before timer init
Date: Thu, 24 Feb 2011 07:41:09 -0800
Message-ID: <20110224154108.GB20560@atomide.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
 <20110223071153.5874.58923.stgit@twilight.localdomain>
 <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
 <alpine.DEB.2.00.1102240109500.6198@utopia.booyaka.com>
 <alpine.DEB.2.00.1102240114160.6198@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A0958B7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50202 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035Ab1BXPlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Feb 2011 10:41:21 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB037A0958B7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110224 00:27]:
> I have tested on OMAP3 and works fine.
> On OMAP2, I guess there is different issue for which it does not work.

That's because commit 15490ef8ff8fd22d677cb5d4f6a98e5a79118dba changed
things to include CONFIG_CPU_32v6K. And this means that omap-for-linus
won't boot on omap2 currently using omap2plus_defconfig. The master
branch boots because of the patches in omap-testing.

To boot test omap-for-linus, you can temporarily merge in the
omap-testing branch that has the pending patches from Russell to
make non-6K ARMv6 processors work with CONFIG_CPU_32v6K.

Regards,

Tony

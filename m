From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
 hwmodright before timer init
Date: Fri, 25 Feb 2011 19:37:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A095EA9@dbde02.ent.ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
 <20110223071153.5874.58923.stgit@twilight.localdomain>
 <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
 <alpine.DEB.2.00.1102240109500.6198@utopia.booyaka.com>
 <alpine.DEB.2.00.1102240114160.6198@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB037A0958B7@dbde02.ent.ti.com>
 <20110224154108.GB20560@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38856 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669Ab1BYOHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 09:07:25 -0500
In-Reply-To: <20110224154108.GB20560@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, February 24, 2011 9:11 PM
> To: DebBarma, Tarun Kanti
> Cc: Paul Walmsley; Shilimkar, Santosh; linux-omap@vger.kernel.org; linux-
> arm-kernel@lists.infradead.org; Hilman, Kevin; Cousson, Benoit
> Subject: Re: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
> hwmodright before timer init
> 
> * DebBarma, Tarun Kanti <tarun.kanti@ti.com> [110224 00:27]:
> > I have tested on OMAP3 and works fine.
> > On OMAP2, I guess there is different issue for which it does not work.
> 
> That's because commit 15490ef8ff8fd22d677cb5d4f6a98e5a79118dba changed
> things to include CONFIG_CPU_32v6K. And this means that omap-for-linus
> won't boot on omap2 currently using omap2plus_defconfig. The master
> branch boots because of the patches in omap-testing.
> 
> To boot test omap-for-linus, you can temporarily merge in the
> omap-testing branch that has the pending patches from Russell to
> make non-6K ARMv6 processors work with CONFIG_CPU_32v6K.
I have re-based the changes on omap-testing branch and tested on
OMAP2420 and OMAP2430.
--
Tarun

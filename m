From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: id: Add missing break statement in
 omap3xxx_check_revision
Date: Wed, 29 Feb 2012 14:42:50 -0800
Message-ID: <20120229224250.GT18901@atomide.com>
References: <1327305407-19914-1-git-send-email-hvaibhav@ti.com>
 <20120127002543.GG29812@atomide.com>
 <79CD15C6BA57404B839C016229A409A8317B530C@DBDE01.ent.ti.com>
 <79CD15C6BA57404B839C016229A409A8317B7282@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57012 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab2B2Wmx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:42:53 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317B7282@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pedanekar, Hemant" <hemantp@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120129 23:59]:
> On Fri, Jan 27, 2012 at 11:02:01, Hiremath, Vaibhav wrote:
> > On Fri, Jan 27, 2012 at 05:55:43, Tony Lindgren wrote:
> > > * Vaibhav Hiremath <hvaibhav@ti.com> [120122 23:26]:
> > > > Add missing break statement in the function omap3xxx_check_revision.
> > > > 
> > > > The commit id 4390f5b2cb1f56 [ARM: OMAP: TI814X: Add cpu type macros
> > > > and detection support], removed the 'break' statement from the function
> > > > omap3xxx_check_revision(), resulting into wrong omap/cpu_revision
> > > > initialization for AM335x devices.
> > > 
> > > Looks like this is already fixed, can you please verify with
> > > v3.3-rc1?
> > > 
> > Tony,
> > 
> > I just looked at your linux-omap/master branch and 'break' statement is missing. So this patch is still required.
> > 
> > I can still see,
> > 
> > 394                 }
> > 395                 break;
> > 396         case 0xb944:
> > 397                 omap_revision = AM335X_REV_ES1_0;
> > 398                 cpu_rev = "1.0";
> > 399         case 0xb8f2:
> > 400                 switch (rev) {
> > 
> > 
> Tony,
> 
> Can this be merged? I can still see "break" statement missing in the latest
> linux-omap/master branch.

OK thanks applying into fixes for the -rc cycle.

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for
 multi-omap
Date: Tue, 7 Sep 2010 20:30:30 -0700
Message-ID: <20100908033030.GM22507@atomide.com>
References: <4C6CFBAF.6020407@canonical.com>
 <20100819095705.GU12184@atomide.com>
 <20100819102025.GA32151@n2100.arm.linux.org.uk>
 <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
 <20100902162337.GP11597@atomide.com>
 <20100902193000.GX11597@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75B0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52002 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab0IHDao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 23:30:44 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75B0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100903 05:07]:
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Friday, September 03, 2010 1:00 AM
> > To: Russell King - ARM Linux
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > Bryan Wu; Will Deacon
> > Subject: Re: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-
> > omap
> > 
> > * Tony Lindgren <tony@atomide.com> [100902 09:16]:
> > > From c04a57fc3b41d886f56ccdc27cf9758de0c95202 Mon Sep 17 00:00:00 2001
> > > From: Tony Lindgren <tony@atomide.com>
> > > Date: Tue, 17 Aug 2010 13:33:23 +0300
> > > Subject: [PATCH 6/6] omap: Fix SMP on UP interrupt handling for multi-
> > omap
> > >
> > > Fix SMP on UP interrupt handling for multi-omap
> > 
> > Here's this one updated to use !smp_cpu() instead of smp_on_up().
> > Looks like the description and subject needed some refreshing too.
> > 
> As I commented on other patch we should just avoid doing anything
> When the CPU is not OMAP4. 

Looks like the only fix needed now is the localtimer fix. Posted
a patch that uses cpu_is_omap44xx() to test for that.

Tony

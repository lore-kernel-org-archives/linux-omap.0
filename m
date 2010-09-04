From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/6] ARM: Do not call test_for_ipi or test_for_ltrirq
	on UP systems
Date: Sat, 4 Sep 2010 11:55:50 +0100
Message-ID: <20100904105550.GB12674@n2100.arm.linux.org.uk>
References: <20100819073810.GR12184@atomide.com> <4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com> <20100819102025.GA32151@n2100.arm.linux.org.uk> <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com> <20100902133637.GJ26319@n2100.arm.linux.org.uk> <20100902161659.GJ11597@atomide.com> <20100902162124.GN11597@atomide.com> <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7590@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42800 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430Ab0IDK4C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Sep 2010 06:56:02 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7590@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

On Fri, Sep 03, 2010 at 05:30:57PM +0530, Shilimkar, Santosh wrote:
> > diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> > index bb2ef60..b8c1ec7 100644
> > --- a/arch/arm/kernel/entry-armv.S
> > +++ b/arch/arm/kernel/entry-armv.S
> > @@ -40,6 +40,11 @@
> >  	bne	asm_do_IRQ
> > 
> >  #ifdef CONFIG_SMP
> Do we need this code to be under " CONFIG_SMP" now ?

Yes, otherwise we get link errors for things like do_IPI and do_local_timer.

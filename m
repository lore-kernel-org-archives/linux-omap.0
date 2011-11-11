From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Fri, 11 Nov 2011 11:47:35 +0000
Message-ID: <20111111114735.GC5114@totoro>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <20111111114147.GE12410@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33983 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab1KKLrj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Nov 2011 06:47:39 -0500
Received: by eye27 with SMTP id 27so3257844eye.19
        for <linux-omap@vger.kernel.org>; Fri, 11 Nov 2011 03:47:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111111114147.GE12410@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, b-cousson@ti.com, "tony@atomide.com" <tony@atomide.com>, Ming Lei <ming.lei@canonical.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 11, 2011 at 11:41:47AM +0000, Will Deacon wrote:
> [Adding Benoit to CC].
> 
> On Thu, Nov 10, 2011 at 09:02:14AM +0000, Paul Walmsley wrote:
> > On Wed, 9 Nov 2011, Ming Lei wrote:
> > > Also, current arm perf code don't handle three IRQs(one pl310 irq and 
> > > two CTI irq) inside one device correctly.
> > 
> > To fix this, that ARM perf code should either be using 
> > platform_get_irq_byname(), or the hwmod hardware data will need to be 
> > rearranged to meet the arbitrary ordering requirement.  I'd suggest 
> > pinging Will on this issue to see what he wants to do.
> 
> The issue stems from the fact that we have to route the PMU interrupts to
> the correct CPU manually (I think only MSM routes them as PPIs, which is
> clearly the correct thing to do). To do this, we expect the IRQ resources to
> be laid out in CPU order. In hindsight, maybe naming the resources might
> have been a good idea, but them we'd still have to generate the names using
> CPU numbers when iterating through the platform device.

There isn't yet a way to do naming of resources with DT, and although I 
think there was a proposal for doing named register resources I don't 
think this has been accepted and there wasn't anything for IRQ 
resources...

Jamie

From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Fri, 11 Nov 2011 15:22:28 +0000
Message-ID: <20111111152228.GM12410@mudshark.cambridge.arm.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
 <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
 <alpine.DEB.2.00.1111080750130.10451@utopia.booyaka.com>
 <CACVXFVMSJUT2Ac+bWetrLpbyOs6PqY+npNHsbvHipEVZ0gWdgQ@mail.gmail.com>
 <alpine.DEB.2.00.1111100152430.4195@utopia.booyaka.com>
 <20111111114147.GE12410@mudshark.cambridge.arm.com>
 <20111111114735.GC5114@totoro>
 <4EBD3785.4050102@ti.com>
 <20111111145833.GL12410@mudshark.cambridge.arm.com>
 <4EBD3B71.5000801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55030 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752974Ab1KKPWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 10:22:46 -0500
Content-Disposition: inline
In-Reply-To: <4EBD3B71.5000801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Jamie Iles <jamie@jamieiles.com>, Paul Walmsley <paul@pwsan.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>, Ming Lei <ming.lei@canonical.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 11, 2011 at 03:12:49PM +0000, Cousson, Benoit wrote:
> Hi Will,

Hello,

> On 11/11/2011 3:58 PM, Will Deacon wrote:
> > Actually, I was hoping you could help Ming Lei with the hwmod stuff :)
> 
> And I'll do :-)

Cheers!

> We already started looking at that with Paul a couple of days ago, but 
> the organization of the debugss IPs inside MPUSS is a little bit messy 
> in OMAP :-)

Ok, I'm not familiar with it so that's why I've been pestering.

> For the moment the cti IRQs are attached to the MPU subsystem which make 
> sense for the HW partitioning point of view.
> Unfortunately, these debug IPs are accessed through an external L3_EMU 
> configuration bus and not using some internal bus inside the MPUSS.
> In the memory maps they are thus all located inside the 
> 0x54000000-0x54164FFF.
> 
> So for the driver point of view, it might be better to assign these IRQs 
> to the debugss IP instead of the MPUSS IP.
> 
> The MPU will then only have the PL310 IRQ.
> 
> static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] = {
> 	{ .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
> 	{ .irq = -1 }
> };

At some point I'd like to add support for the PL310 PMU, which will want to
use that IRQ. That would need to be passed to the PL310 driver though, which
will then register it's own PMU device with perf.

> The debugss one will have the cti ones, that will start at 0 and thus 
> will make them even accessible using the index.
> 
> static struct omap_hwmod_irq_info omap44xx_debugss_irqs[] = {
> 	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
> 	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
> 	{ .irq = -1 }
> };
> 
> I need to fix this IRQ mapping and then I'll be able to send a hwmod 
> version of this debugss virtual IP that should help Ming.

That looks cracking and should work out of the box.

Thanks,

Will

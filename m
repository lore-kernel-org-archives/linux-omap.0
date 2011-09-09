From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
 gic_arch_extn
Date: Fri, 9 Sep 2011 10:18:47 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109091017300.2723@ionos>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com> <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com> <878vpyhotu.fsf@ti.com> <4E69961D.40700@ti.com> <alpine.LFD.2.02.1109090912130.2723@ionos> <4E69C957.5070708@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60494 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758643Ab1IIISu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 04:18:50 -0400
In-Reply-To: <4E69C957.5070708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Fri, 9 Sep 2011, Santosh wrote:
> On Friday 09 September 2011 12:49 PM, Thomas Gleixner wrote:
> > 
> > The flag says: MASK ON SUSPEND and it does not imply that you don't
> > need a wake function. There might be cases where you want to setup
> > stuff in that function in order to have the wakeup happen on that
> > interrupt line despite of the mask on suspend.
> > 
> I see your point.
> 
> > We either need a separate flag or a global dummy set_wake function in
> > the core to avoid empty copies all over the place.
> > 
> A flag is probably better since you mentioned that on some arch, there
> might be need to have actual set_wake() handler. Or if the global
> dummy can be over-ridden by platform, that's fine too.

Global dummy would mean:

int irq_set_wake_dummy(...)
{
	return 0;
}

And you just add it to your chip, but either way I don't care whether
it's a dummy function or a flag.

Thanks,

	tglx

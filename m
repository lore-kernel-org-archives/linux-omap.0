From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/10] ARM: OMAP5: hwmod data: Create initial OMAP5 SOC
 hwmod data
Date: Tue, 22 Jan 2013 10:39:42 -0800
Message-ID: <20130122183942.GO15361@atomide.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
 <1358522856-12180-9-git-send-email-santosh.shilimkar@ti.com>
 <20130118171500.GC15361@atomide.com>
 <50FCF838.6000105@ti.com>
 <50FD5993.5010008@ti.com>
 <20130121180113.GA22517@atomide.com>
 <50FE909B.1020001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:20569 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752883Ab3AVSjp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jan 2013 13:39:45 -0500
Content-Disposition: inline
In-Reply-To: <50FE909B.1020001@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, b-cousson@ti.com, Paul Walmsley <paul@pwsan.com>

* Rajendra Nayak <rnayak@ti.com> [130122 05:17]:
> Hi Tony,
> 
> >>So I looked at this one with help of Rajendra. We can get rid of the
> >>IRQ and DMA data(needs DMA biding updates) easily. The address
> >>space though is needed since hwmod code uses it to setup the
> >>sysconfig registers.
> >
> >OK great. The address space tinkering in hwmod code should be
> >moved to be done in the drivers.
> >
> >As discussed earlier, there should be a driver specific reset
> >function driver_xyz_reset() in the driver header file so the
> >hwmod code can call it too in a late_initcall if no driver is
> >loaded.
> 
> I am a little confused with what you are saying. The hwmod doing
> reset of modules (and not relying on drivers doing it) was
> mainly for modules which do not have drivers built in (and hence
> run a risk of gating system sleep in case the bootloaders left
> them in a bad state).

Right, but we should not duplicate driver code in the hwmod in
those cases. And that's why those reset functions need to be in
the driver specific headers so they work both for the driver
probe, and hwmod late_initcall.

> But if the drivers aren't built in (or are built as modules) *then*
> hwmod still needs to be able to do reset (maybe in a late_initcall) of
> these modules on its own (because there is no driver code to do it).

Yes that's the idea.
 
> The other big reason why hwmod would need the address space
> tinkering is because it also controls the various OCP master/slave
> modes of these modules. Quite often these modes are broken and
> need tinkering every time the module is enable/idled and also
> need to be restored back to sane values (smart_idle/smart_standby)
> post reset. All of this is today handled as part of hwmod and
> would defeat the whole purpose of the framework if all this is
> moved into drivers.

It seems that we should have the iospace available in the driver
at that point. And it should be also available to the runtime PM
code in hwmod in the device somewhere?
 
> So completely getting rid of all address space tinkering in hwmod
> looks really difficult.

We can certainly use common hwmod functions via runtime PM for
doing that. There should not be any need to ioremap things both
in hwmod and in the driver. And there certainly should not be
need to provide duplicate iospace from both DT and hwmod. As the
DT is what we're standardizing on, we really must move over to
use that data.

Regards,

Tony

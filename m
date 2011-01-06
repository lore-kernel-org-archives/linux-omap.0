From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] omap: wd_timer: Fix crash frm wdt_probe
	when!CONFIG_RUNTIME_PM
Date: Thu, 6 Jan 2011 15:26:38 +0000
Message-ID: <20110106152638.GC1198@n2100.arm.linux.org.uk>
References: <1294234855-6623-1-git-send-email-santosh.shilimkar@ti.com> <20110105221839.GD8717@n2100.arm.linux.org.uk> <19b4a66bfdd4ef3e51fdb27bf43b9ce2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42471 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab1AFP0s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 10:26:48 -0500
Content-Disposition: inline
In-Reply-To: <19b4a66bfdd4ef3e51fdb27bf43b9ce2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jan 06, 2011 at 09:27:32AM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Thursday, January 06, 2011 3:49 AM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; Paul Walmsley; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH] omap: wd_timer: Fix crash frm wdt_probe
> > when!CONFIG_RUNTIME_PM
> >
> > On Wed, Jan 05, 2011 at 07:10:55PM +0530, Santosh Shilimkar wrote:
> > > Commit ff2516fb 'wd_timer: disable on boot via hwmod postsetup
> > mechanism'
> > > introduced watchdog timer state state management using
> > postsetup_state.
> > > This was done to allow some board files to support watchdog
> > coverage
> > > throughout kernel initialization and it work as intended when
> > RUNTIME_PM
> > > is enabled.
> > >
> > > With !CONFIG_RUNTIME_PM and no board is specifically requests
> > watchdog
> > > to remain enabled the omap_wdt_probe crashesh. This is because
> > hwmod
> > > in absense of runtime PM unable to turn watchdog clocks because
> > it's
> > > state is set to be disabled. For rest of the device, the state is
> > > set as enabled in absense of RUNTIME_PM
> >
> > Err... wasn't this provoked by an attempt to fix the LDP issue, that
> > is
> > (I believe) because the boot loader enables the watchdog and pre-
> > hwmod
> > kernels used to disable it.  Post-hwmod kernels stopped disabling
> > the
> > watchdog, resulting in a few seconds booting userspace before the
> > system
> > resets itself.
> 
> Yes. That's managed through the shutdown part. Apart from that there
> is another enhancement done in case some one wants to have WDT running
> throughout the kernel boot.

Good - and just to confirm, the fix for LDP watchdogging will be submitted
in the current merge window?

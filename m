From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Exception while  handling MEM Hole on OMAP3 / ARM Cortex A8
Date: Sat, 8 Aug 2009 18:03:00 +0100
Message-ID: <20090808170300.GA23481@n2100.arm.linux.org.uk>
References: <0680EC522D0CC943BC586913CF3768C00378FF3971@dbde02.ent.ti.com> <20090807220016.GG31543@n2100.arm.linux.org.uk> <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34239 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZHHRDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Aug 2009 13:03:11 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003790C5B3A@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Aug 08, 2009 at 08:45:44PM +0530, Syed Mohammed, Khasim wrote:
> Hi Russell,
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Saturday, August 08, 2009 3:30 AM
> > To: Syed Mohammed, Khasim
> > Cc: linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> > Subject: Re: Exception while handling MEM Hole on OMAP3 / ARM Cortex A8
> > 
> > On Sat, Aug 08, 2009 at 01:46:35AM +0530, Syed Mohammed, Khasim wrote:
> > > On OMAP3 we are creating a space for DSP components to have shared
> > > buffers using the boot arguments.
> > >
> > > mem=88M@0x80000000 mem=128M@0x88000000
> > 
> > Ensure that you have ARCH_HAS_HOLES_MEMORYMODEL enabled in the
> > configuration - you need OMAP3 to select this symbol.
> 
> We are on 2.6.29 on beagleboard, this kernel doesn't support ARCH_HAS_HOLES_MEMORYMODEL so I applied the patch from 
> 
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commitdiff;h=eb33575cf67d3f35fa2510210ef92631266e2465
> 
> Didn't help, still fails, do you suggest us to move to latest kernel and try the same instead of patch alone?

In which case, please supply a full bug report with a _full_ oops dump.

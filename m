From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Wed, 14 Nov 2012 20:22:44 +0000
Message-ID: <20121114202244.GE3332@n2100.arm.linux.org.uk>
References: <20121114185335.GU6801@atomide.com> <50A3EBCD.3040801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42402 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141Ab2KNUXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 15:23:51 -0500
Content-Disposition: inline
In-Reply-To: <50A3EBCD.3040801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Wed, Nov 14, 2012 at 01:06:53PM -0600, Jon Hunter wrote:
> 
> On 11/14/2012 12:53 PM, Tony Lindgren wrote:
> > Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
> > to not boot when enabled. The ARM core on it is an earlier r1p2:
> > 
> > CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
> > 
> > Unfortunately I don't have the details of errata 751472, but I'm
> > guessing we need to disable it for r1p*.
> 
> I checked the CA9MP errata document and this erratum impacts all
> r0/r1/r2 CPUs. I am wondering if the problem is because the workaround
> requires you to set a bit in the Diagnostic Control register and the
> read-modify-write sequence provided in the workaround is for secure
> mode. Not sure if there is a non-secure workaround available :-(

Most likely, and there's not a lot that the kernel can sanely do about
that.  We have ended up deciding (through being forced to because of
how the security stuff works) that the stages prior to the kernel will
implement the work-around enables because those stages are already
platform specific, and the kernel will implement a "test for the
work-around already enabled."

The net result is, if you enable an Errata in the kernel which your
earlier boot stages has not already configured, the kernel will hang.
Not much we can do about the hanging aspect, because the kernel takes
an exception which we can't trap at those early stages in the boot
process.

I'm not particularly happy about that design, but that's what we've
ended up with through the 'design' of the security stuff forced onto
us.

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Fri, 16 Nov 2012 18:41:36 +0000
Message-ID: <20121116184136.GK3332@n2100.arm.linux.org.uk>
References: <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com> <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com> <20121115110137.GA25985@arm.com> <50A4FCC5.2080604@gmail.com> <20121115143714.GF25985@arm.com> <50A50C24.9010702@gmail.com> <20121116100550.GI3332@n2100.arm.linux.org.uk> <20121116171333.GL6801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44007 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab2KPSmJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 13:42:09 -0500
Content-Disposition: inline
In-Reply-To: <20121116171333.GL6801@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robherring2@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <dave.martin@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 16, 2012 at 09:13:33AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121116 02:07]:
> > 
> > So, we don't detect whether we're running in secure mode or not; as I've
> > already stated, we don't have a way to do that.  We instead only apply
> > work-arounds which aren't already enabled prior to the kernel booting.
> > So, even on a secure mode platform, we will avoid writing the bits if the
> > work-around has already been applied.
> 
> This all assumes that we can read the value of the diagnostic register,
> and on my 4430 blaze the read returns zero. I have no idea if this is
> the correct value for the register, or if reads always just returns 0.

ARM Ltd has made that assumption since the inception of the errata
work-arounds appearing in the kernel for v6+ CPUs...

But your question may prove to be moot if we end up ripping all these
out, like I'm beginning to think we should do.

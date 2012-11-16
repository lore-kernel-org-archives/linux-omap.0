From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Fri, 16 Nov 2012 09:59:21 +0000
Message-ID: <20121116095921.GH3332@n2100.arm.linux.org.uk>
References: <20121114185335.GU6801@atomide.com> <50A3EBCD.3040801@ti.com> <20121114202244.GE3332@n2100.arm.linux.org.uk> <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com> <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com> <20121115110137.GA25985@arm.com> <50A4FCC5.2080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43624 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab2KPJ7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 04:59:37 -0500
Content-Disposition: inline
In-Reply-To: <50A4FCC5.2080604@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Tony Lindgren <tony@atomide.com>, Dave Martin <dave.martin@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Nov 15, 2012 at 08:31:33AM -0600, Rob Herring wrote:
> So we should make all these work-arounds depend on !MULTI_PLATFORM then.

No, because some of the work-arounds don't require setting bits in magic
registers.

Also realise this: we test for the revision of the CPU to which they're
applicable before attempting to set them.  If you have a work-around
enabled in the kernel, and it fails at boot, _that_ is an indicator not
that the kernel is doing something wrong, but that you need to ensure
that the work-around has been applied by the earlier stages.

It's not about "but platform X doesn't need it" - it's about platform X
not having the earlier stages updated to fix the errata.

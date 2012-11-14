From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Wed, 14 Nov 2012 11:19:00 -0800
Message-ID: <20121114191859.GW6801@atomide.com>
References: <20121114185335.GU6801@atomide.com>
 <20121114190137.GD3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19608 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161019Ab2KNTTH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 14:19:07 -0500
Content-Disposition: inline
In-Reply-To: <20121114190137.GD3332@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121114 11:03]:
> On Wed, Nov 14, 2012 at 10:53:35AM -0800, Tony Lindgren wrote:
> > Looks like enabling CONFIG_ARM_ERRATA_751472 causes omap4 blaze
> > to not boot when enabled. The ARM core on it is an earlier r1p2:
> > 
> > CPU: ARMv7 Processor [411fc092] revision 2 (ARMv7), cr=10c53c7d
> > 
> > Unfortunately I don't have the details of errata 751472, but I'm
> > guessing we need to disable it for r1p*.
> 
> Fails because it can't write the diagnostic register from non-secure
> mode or fails later?

Hmm good question, it fails a bit later on during the boot just
before __enable_mmu.

But I just tried commenting out the setting of bit 11:

@orrlt	r10, r10, #1 << 11              @ set bit #11

And just trying to write the unmodified diagnostic register
also makes it fail.

So yeah it seems to be related to the secure crap instead :(

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Fri, 16 Nov 2012 09:13:33 -0800
Message-ID: <20121116171333.GL6801@atomide.com>
References: <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com>
 <50A413D4.7000405@gmail.com>
 <20121114222159.GB6801@atomide.com>
 <50A43D58.5030404@gmail.com>
 <20121115110137.GA25985@arm.com>
 <50A4FCC5.2080604@gmail.com>
 <20121115143714.GF25985@arm.com>
 <50A50C24.9010702@gmail.com>
 <20121116100550.GI3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40570 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751773Ab2KPRNn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 12:13:43 -0500
Content-Disposition: inline
In-Reply-To: <20121116100550.GI3332@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rob Herring <robherring2@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <dave.martin@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121116 02:07]:
> 
> So, we don't detect whether we're running in secure mode or not; as I've
> already stated, we don't have a way to do that.  We instead only apply
> work-arounds which aren't already enabled prior to the kernel booting.
> So, even on a secure mode platform, we will avoid writing the bits if the
> work-around has already been applied.

This all assumes that we can read the value of the diagnostic register,
and on my 4430 blaze the read returns zero. I have no idea if this is
the correct value for the register, or if reads always just returns 0.

If we can verify that the read of the diagnostic register returns the
correct value, then we don't need to test for the secure mode like you
are saying, and can require the bootrom or bootloader set the right bits.

Can somebody confirm that reading of the diagnostic register without
using SMI is supposed to return the correct value?

Regards,

Tony

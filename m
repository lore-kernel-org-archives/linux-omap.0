From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Wed, 14 Nov 2012 11:21:06 -0800
Message-ID: <20121114192106.GX6801@atomide.com>
References: <20121114185335.GU6801@atomide.com>
 <50A3EBCD.3040801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21324 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423142Ab2KNTVJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 14:21:09 -0500
Content-Disposition: inline
In-Reply-To: <50A3EBCD.3040801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Dave Martin <dave.martin@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Jon Hunter <jon-hunter@ti.com> [121114 11:09]:
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

So it seems :( And I guess we still don't have a generic way to
check if the core has secure mode or not, and what registers are
accessible in secure mode.

Regards,

Tony

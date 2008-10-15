From: Tony Lindgren <tony@atomide.com>
Subject: Re: git pull request for minimal omap3 support one more time
Date: Wed, 15 Oct 2008 11:34:01 -0700
Message-ID: <20081015183401.GM8150@atomide.com>
References: <20081004070534.GB30190@muru.com> <20081009145436.GI435@flint.arm.linux.org.uk> <20081009151724.GK26230@atomide.com> <20081010073251.GN435@flint.arm.linux.org.uk> <20081010091557.GI3044@atomide.com> <20081010092520.GK3044@atomide.com> <20081010113533.GU3044@atomide.com> <20081013133256.GA3510@flint.arm.linux.org.uk> <20081014171907.GD8150@atomide.com> <20081015090250.d32cf7f7.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56857 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbYJOSeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 14:34:19 -0400
Content-Disposition: inline
In-Reply-To: <20081015090250.d32cf7f7.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hi,

* Jarkko Nikula <jarkko.nikula@nokia.com> [081014 23:03]:
> On Tue, 14 Oct 2008 10:19:08 -0700
> "ext Tony Lindgren" <tony@atomide.com> wrote:
> 
> > > Please take a look and resolve ASAP.  Thanks.
> > 
> > Sorry for the delay, I was sitting in an airplane again.
> > 
> > Here's the fix, looks like the missing McBSP irqs should have been
> > merged into the recent McBSP patches.
> > 
> > This patch is also in your patch system as 5301/1.
> > 
> Tony,
> 
> If my patch below from linux-omap was forgotten from original pull
> request, please note that it's required to add those rx/tx irqs into
> omap_mcbsp_platform_data structs in arch/arm/mach-omap2/mcbsp.c as
> well. Otherwise arch/arm/plat-omap/mcbsp.c: omap_mcbsp_request will
> fail when requesting zero defined irqs.
> 
> Sorry, not noting this before.
> 
> 
> Jarkko
> 
> commit c29cfcead32c8dcb9738a085d498aebe6ab160af
> Author: Jarkko Nikula <jarkko.nikula@nokia.com>
> Date:   Tue Sep 16 15:56:53 2008 +0300
> 
>     ARM: OMAP: Add RX/TX interrupts for 2430 and 34xx McBSP ports 3-5
>     
>     Without RX and TX interrupt definitions, the omap_mcbsp_request will
>     fail on OMAP2430 and OMAP34xx for ports 3-5 since default io_type is
>     OMAP_MCBSP_IRQ_IO.

It's there, in Russell's omap-all branch. I just merged your fix
into your other patch:

commit 05228c35c67995c745ae3c768eaf90740c643fa9
Author: Jarkko Nikula <jarkko.nikula@nokia.com>
Date:   Wed Oct 8 10:01:40 2008 +0300

    ARM: OMAP: Add support for OMAP2430 in McBSP

Regards,

Tony

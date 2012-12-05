From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 4/5] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Wed, 5 Dec 2012 09:41:14 -0800
Message-ID: <20121205174114.GH21682@atomide.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com>
 <1354204892-22762-5-git-send-email-zonque@gmail.com>
 <50B7BE9C.6040506@ti.com>
 <50B7C677.7090504@ti.com>
 <50B7C8BE.7050002@gmail.com>
 <50B7CCB1.6000506@ti.com>
 <50BF4670.8070602@gmail.com>
 <20121205171950.GF21682@atomide.com>
 <50BF83CA.5050007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38912 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803Ab2LERlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 12:41:21 -0500
Content-Disposition: inline
In-Reply-To: <50BF83CA.5050007@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, x0148406@ti.com, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, rob.herring@calxeda.com, avinashphilip@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Daniel Mack <zonque@gmail.com> [121205 09:29]:
> On 05.12.2012 18:19, Tony Lindgren wrote:
> > 
> > The plat/cpu.h file will disappear after the merge window, which means
> > omap2+ related drivers cannot use cpu_is_omap macros.
> >
> > For legacy booting systems, this flag should be just passed in the
> > platform_data from the platform init code. Then device tree can
> > deal with it based on the compatible flag.
> >
> 
> Ok, thanks for explaining.
> 
> Does that mean this patch series should be postponed until after the
> merge window and then build upon that change or should we merge the
> patch in question here as is and then care for the cleanups after the
> window?

Well to me it seems that you only have cpu_is_omap usage in
arch/arm/mach-omap2/gpmc-nand.c, which will be OK. Only the code
under drivers/* needs to be fixed for that. So your patches may
be OK, but..

> I can also rebase this set on top of the removal patches if they exist
> already somewhere.

..please check that your patches work with current linux next.

It's too late to queue thing for v3.8 merge window at this point,
as we want the patches sitting in linux next for a week at least
before they get pulled.

And we still need the acks for the device tree binding as well.

So let's plan on queueing these after -rc1.

Regards,

Tony

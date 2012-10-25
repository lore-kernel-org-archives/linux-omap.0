From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] drivers: bus: omap_interconnect: Fix rand-config build
 warning
Date: Thu, 25 Oct 2012 12:15:46 -0700
Message-ID: <20121025191546.GY11928@atomide.com>
References: <1350480519-1890-1-git-send-email-lokeshvutla@ti.com>
 <507EB3CC.6060005@ti.com>
 <20121025003509.GI11928@atomide.com>
 <20121025004216.GJ11928@atomide.com>
 <5088DD22.1050000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:60703 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760114Ab2JYTPu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 15:15:50 -0400
Content-Disposition: inline
In-Reply-To: <5088DD22.1050000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net

* Santosh Shilimkar <santosh.shilimkar@ti.com> [121024 23:34]:
> On Thursday 25 October 2012 06:12 AM, Tony Lindgren wrote:
> >* Tony Lindgren <tony@atomide.com> [121024 17:36]:
> >>* Santosh Shilimkar <santosh.shilimkar@ti.com> [121017 06:35]:
> >>>(Looping Arnd and Olof)
> >>>
> >>>On Wednesday 17 October 2012 06:58 PM, Lokesh Vutla wrote:
> >>>>When building omap_l3_noc/smx drivers as modules, the following
> >>>>warning appears:
> >>>>
> >>>>CC [M]  drivers/bus/omap_l3_smx.o
> >>>>drivers/bus/omap_l3_smx.c:291: warning: data definition has no type or storage class
> >>>>drivers/bus/omap_l3_smx.c:291: warning: type defaults to 'int' in declaration of 'postcore_initcall_sync'
> >>>>drivers/bus/omap_l3_smx.c:291: warning: parameter names (without types) in function declaration
> >>>>drivers/bus/omap_l3_smx.c:287: warning: 'omap3_l3_init' defined but not used
> >>>>CC [M]  drivers/bus/omap_l3_noc.o
> >>>>drivers/bus/omap_l3_noc.c:260: warning: data definition has no type or storage class
> >>>>drivers/bus/omap_l3_noc.c:260: warning: type defaults to 'int' in declaration of 'arch_initcall_sync'
> >>>>drivers/bus/omap_l3_noc.c:260: warning: parameter names (without types) in function declaration
> >>>>drivers/bus/omap_l3_noc.c:256: warning: 'omap4_l3_init' defined but not used
> >>>>
> >>>>Adding module_init() and macros in omap_l3_noc/smx drivers when building
> >>>>as modules to remove the above warning.
> >>>>
> >>>>Reported-by: Tony Lindgren <tony@atomide.com>
> >>>>Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> >>>>---
> >>>Thanks for the fix Lokesh. Looks fine to me.
> >>>
> >>>Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>
> >>Looks like nobody else has picked this up so I'll queue this along
> >>with few other omap warnings and regressions.
> >
> >Hmm actually this might require some more discussion. If we make
> >it use regular initcalls, then the ugly ifdefs can be left
> >out. Is there a reason to init this early, can't we just use regular
> >initcalls?
> >
> I thought about it. The whole reason we want interconnect errors
> enabled early in the boot to avoid bad accesses issued on
> interconnect
> in early boot by various init codes. We managed to discovered many
> init sequence issues where the a driver is trying to access registers
> when clocks are not active, or drivers are using bad mapping. At times
> these errors gets un-noticed because of the behavior of interconnect
> and later causes serious issues. Leaving the driver init late in the
> boot means we can't catch any of the issues happen till the L3 driver
> init happens.

OK yeah that makes sense. How about let's just make it
just postcore_initcall instead of postcore_initcall_sync?

In include/linux/module.h we have:

...
#else /* MODULE */

/* Don't use these in loadable modules, but some people do... */
#define early_initcall(fn)              module_init(fn)
#define core_initcall(fn)               module_init(fn)
#define postcore_initcall(fn)           module_init(fn)
...

While the postcore_initcall_sync does not have those.

No idea what the current plan is, but I sort of remember reading
that the _sync versions are going away at some point anyways?

Regards,

Tony

From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC/PATCH 8/7] ARM: OMAP: AM35xx: convert 3517 detection/flags
 to AM35xx
Date: Wed, 11 Jan 2012 16:29:57 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8317A10C9@DBDE01.ent.ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
	<1325876023-7040-1-git-send-email-khilman@ti.com>
	<79CD15C6BA57404B839C016229A409A80752F2@DBDE01.ent.ti.com>
 <87zkdwxyqg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37978 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab2AKQaC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 11:30:02 -0500
In-Reply-To: <87zkdwxyqg.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

On Tue, Jan 10, 2012 at 04:36:15, Hilman, Kevin wrote:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Hilman, Kevin
> >> Sent: Saturday, January 07, 2012 12:24 AM
> >> To: linux-omap@vger.kernel.org
> >> Cc: Paul Walmsley; Hiremath, Vaibhav
> >> Subject: [RFC/PATCH 8/7] ARM: OMAP: AM35xx: convert 3517 detection/flags
> >> to AM35xx
> >> 
> >> Currently cpu_is_omap3517() actually detects any device in the AM35x
> >> family (3517 and no-SGX version 3505.)  To make it more clear what is
> >> being detected, convert the names from 3517 to AM35xx.
> >> 
> >> For the same reason, replace the CK_3517 flag used in the clock data
> >> to CK_AM35XX.
> >> 
> >> Signed-off-by: Kevin Hilman <khilman@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/clock3xxx_data.c          |    8 ++++----
> >>  arch/arm/mach-omap2/hsmmc.c                   |    8 ++++----
> >>  arch/arm/mach-omap2/id.c                      |    7 +++----
> >>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
> >>  arch/arm/mach-omap2/powerdomains3xxx_data.c   |    2 +-
> >>  arch/arm/mach-omap2/usb-musb.c                |    2 +-
> >>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
> >>  arch/arm/plat-omap/include/plat/clkdev_omap.h |    3 +--
> >>  arch/arm/plat-omap/include/plat/cpu.h         |   15 +++++++--------
> >>  9 files changed, 23 insertions(+), 26 deletions(-)
> >> 
> > Is this also right time to change Makefile and Kconfig files???
> > Change in board/mach-types/Makefile/Kconfig files will bring
> > consistency across...
> 
> Probably, yes.  Although Tony might thing that is too much churn.
> 
> Feel free to spin up a patch and I'll add it to this series and we'll
> see what Tony thinks.
> 
Will submit the patch for this (Will be my first thing for tomorrow morning).

Thanks,
Vaibhav

> Kevin
> 


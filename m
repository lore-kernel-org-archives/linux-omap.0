From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2, 3: DSS2: Include linux/delay.h and common.h to
 fix build errors
Date: Thu, 8 Dec 2011 16:49:51 -0800
Message-ID: <20111209004951.GK31337@atomide.com>
References: <1322654481.11191.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26795 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751238Ab1LIAtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 19:49:53 -0500
Content-Disposition: inline
In-Reply-To: <1322654481.11191.1.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Axel Lin <axel.lin@gmail.com> [111130 03:26]:
> Include linux/delay.h to fix below build error:
> 
>   CC      arch/arm/mach-omap2/display.o
> arch/arm/mach-omap2/display.c: In function 'dispc_disable_outputs':
> arch/arm/mach-omap2/display.c:283: error: implicit declaration of function 'mdelay'
> arch/arm/mach-omap2/display.c: In function 'omap_dss_reset':
> arch/arm/mach-omap2/display.c:317: error: implicit declaration of function 'omap_test_timeout'
> make[1]: *** [arch/arm/mach-omap2/display.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Include common.h to fix below build error:
> 
>   CC      arch/arm/mach-omap2/display.o
> arch/arm/mach-omap2/display.c: In function 'omap_dss_reset':
> arch/arm/mach-omap2/display.c:318: error: implicit declaration of function 'omap_test_timeout'
> make[1]: *** [arch/arm/mach-omap2/display.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> I got the build error on linux-next 20111130.
> This patch is against linux-next 20111130.
> Axel

Thanks we already have commit deee6d5359969a0ce4e2760cfd7b9f379bd5698a
in Russell's devel-stable branch doing the same thing.

Regards,

Tony

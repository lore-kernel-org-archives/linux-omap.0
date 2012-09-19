From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] CPUFreq: OMAP: remove unnecessary plat/ includes
Date: Wed, 19 Sep 2012 22:03:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209192202430.8278@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209120030420.9444@utopia.booyaka.com> <201209142103.49421.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57790 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab2ISWDv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 18:03:51 -0400
In-Reply-To: <201209142103.49421.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Fri, 14 Sep 2012, Rafael J. Wysocki wrote:

> On Wednesday, September 12, 2012, Paul Walmsley wrote:
> > 
> > Remove some unnecessary plat/ includes that are interfering with multi-subarch
> > ARM kernels.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
> > Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > ---
> > 
> > Still awaiting some final testing here.  Rafael, was wondering if you 
> > would be willing to ack this so we can merge it via the OMAP tree?   
> > Otherwise the patch can be split into an OMAP part and a CPUFreq part that 
> > can go in across two merge windows.
> > 
> >  arch/arm/mach-omap2/clock2420_data.c |    1 +
> >  arch/arm/mach-omap2/clock2430_data.c |    1 +
> >  arch/arm/mach-omap2/clock3xxx_data.c |    1 +
> >  arch/arm/mach-omap2/clock44xx_data.c |    1 +
> >  drivers/cpufreq/omap-cpufreq.c       |   19 +------------------
> >  5 files changed, 5 insertions(+), 18 deletions(-)

Thanks Rafael.  Looks like you've got "cpufreq: OMAP: Check IS_ERR() 
instead of NULL for omap_device_get_by_hwmod_name" queued which conflicts 
with this patch, so will just queue the arch/arm/mach-omap2/ changes for 
now.  Then the drivers/cpufreq/omap-cpufreq.c part can go in during 3.8.

- Paul

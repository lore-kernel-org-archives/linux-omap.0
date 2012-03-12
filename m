From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] gpio/omap: Fix section warning for omap_mpuio_alloc_gc()
Date: Mon, 12 Mar 2012 11:45:03 -0600
Message-ID: <20120312174503.E06123E07B0@localhost>
References: <20120306212605.GY12083@atomide.com> <87pqcpb7y4.fsf@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36949 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591Ab2CLRpI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Mar 2012 13:45:08 -0400
Received: by eaaq12 with SMTP id q12so1311493eaa.19
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 10:45:07 -0700 (PDT)
In-Reply-To: <87pqcpb7y4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, 06 Mar 2012 15:55:47 -0800, Kevin Hilman <khilman@ti.com> wrote:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Mon, 5 Mar 2012 15:32:38 -0800
> > Subject: [PATCH] gpio/omap: Fix section warning for omap_mpuio_alloc_gc()
> >
> > Make omap_mpuio_alloc_gc() __devinit as omap_gpio_chip_init()
> > is __devinit. Otherwise we get:
> >
> > WARNING: vmlinux.o(.devinit.text+0xa10): Section mismatch in reference
> > from the function omap_gpio_chip_init() to the function .init.text:omap_mpuio_alloc_gc()
> > The function __devinit omap_gpio_chip_init() references
> > a function __init omap_mpuio_alloc_gc().
> > If omap_mpuio_alloc_gc is only used by omap_gpio_chip_init then
> > annotate omap_mpuio_alloc_gc with a matching annotation.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

applied, thx.

g.

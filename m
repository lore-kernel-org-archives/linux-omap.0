From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 7/8] ARM: OMAP: Remove plat/io.h by moving it into
	mach/io.h
Date: Thu, 1 Mar 2012 00:11:40 +0000
Message-ID: <20120301001140.GA18438@n2100.arm.linux.org.uk>
References: <20120221233619.18709.87982.stgit@kaulin.local> <20120221234049.18709.28987.stgit@kaulin.local> <4F4451FB.7070007@gmail.com> <20120224000657.GJ18185@atomide.com> <20120224182246.GL18185@atomide.com> <4F4AFCC7.3020509@gmail.com> <20120229014719.GK18901@atomide.com> <4F4EBBDF.9090806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57499 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab2CAAL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 19:11:57 -0500
Content-Disposition: inline
In-Reply-To: <4F4EBBDF.9090806@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org, Matt Mackall <mpm@selenic.com>

On Wed, Feb 29, 2012 at 05:59:27PM -0600, Rob Herring wrote:
> BTW, all these includes need to get removed. I'll add a fix to my series
> unless you already have fixes:
> 
> arch/arm/mach-omap1/sleep.S:#include <mach/io.h>
> arch/arm/mach-omap1/sram.S:#include <mach/io.h>
> arch/arm/plat-omap/include/plat/sdrc.h:#include <mach/io.h>
> drivers/media/video/davinci/vpbe_osd.c:#include <mach/io.h>
> drivers/media/video/davinci/vpbe_venc.c:#include <mach/io.h>
> drivers/video/omap2/vrfb.c:#include <mach/io.h>

All the ones included from .h and .c files should be using linux/io.h
and not some other derivative.

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: PRM: fix compile for OMAP4-only build
Date: Thu, 5 Apr 2012 15:53:45 -0700
Message-ID: <20120405225345.GJ3785@atomide.com>
References: <1333660837-23249-1-git-send-email-khilman@ti.com>
 <alpine.DEB.2.00.1204051533110.10302@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30412 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241Ab2DEWxt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 18:53:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204051533110.10302@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120405 14:36]:
> On Thu, 5 Apr 2012, Kevin Hilman wrote:
> 
> > For OMAP4 only builds, the omap2_prm_* functions have dummy wrappers
> > to detect incorrect usage.  However, several unrelated omap3 PRM
> > functions have made it inside the #else clause of the #ifdef wrapping
> > the omap2_prm stubs, causing them to disappear on OMAP4-only builds.
> > 
> > This was unnoticed until the IO chain support was added and introduced
> > a new function in this section which is referenced by omap_hwmod.c:
> > 
> > /work/kernel/omap/dev/arch/arm/mach-omap2/omap_hwmod.c: In function '_reconfigure_io_chain':
> > /work/kernel/omap/dev/arch/arm/mach-omap2/omap_hwmod.c:1665:3: error: implicit declaration of function 'omap3xxx_prm_reconfigure_io_chain' [-Werror=implicit-fungiction-declaration]
> > 
> > Fix by using the #ifdef to only wrap the omap2_prm functions that
> > need stubs on OMAP4-only builds.
> > 
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Kevin Hilman <khilman@ti.com>
> > ---
> > Paul, this patch applies on top your io_chain_devel_3.5 branch.
> 
> Thanks, Tony reported this too.  Any objections to me rolling this into 
> the offending patch?

I heard of this first from Kevin before I started hitting it with
my compiles..

Anyways, can you also check that we don't have a similar issue
with omap44xx_prm_reconfigure_io_chain for omap3 only builds?

Regards,

Tony

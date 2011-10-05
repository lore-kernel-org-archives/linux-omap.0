From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP: Remove calls to SRAM allocations for
 framebuffer
Date: Wed, 5 Oct 2011 15:41:41 -0700
Message-ID: <20111005224141.GF6324@atomide.com>
References: <20111005004339.26980.31149.stgit@kaulin.local>
 <20111005004544.26980.35612.stgit@kaulin.local>
 <1317797128.2631.2.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46794 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935461Ab1JEWlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 18:41:46 -0400
Content-Disposition: inline
In-Reply-To: <1317797128.2631.2.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [111004 23:11]:
> On Tue, 2011-10-04 at 17:45 -0700, Tony Lindgren wrote:
> > This assumes fixed mappings which will not work once we move
> > to use ioremap_exec(). It seems that these are currently
> > not in use, or in use for some out of tree corner cases.
> > 
> > If SRAM support for framebuffer is wanted, it should be done
> > with ioremap in the driver.
> > 
> > Note that further removal of the code can now be done,
> > but that can be done seprately by the driver maintainers.
> > 
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Looks good to me. I have similar changes in my working branch for omapfb
> cleanup.
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thanks. FYI, looks like there's a warning in display.c:

arch/arm/mach-omap2/display.c: In function 'omap_display_init':
arch/arm/mach-omap2/display.c:93: warning: assignment from incompatible pointer type

Do you have a patch for that already?

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: resolve sparse warning concerning
 debug_card_init()
Date: Tue, 16 Oct 2012 11:07:55 -0700
Message-ID: <20121016180754.GB15569@atomide.com>
References: <alpine.DEB.2.00.1210092028080.5736@utopia.booyaka.com>
 <50751D36.9020001@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55923 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755372Ab2JPSH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Oct 2012 14:07:57 -0400
Content-Disposition: inline
In-Reply-To: <50751D36.9020001@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [121010 00:02]:
> On 10/09/12 22:29, Paul Walmsley wrote:
> > 
> > Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
> > debug_card_init() function") results in the following new sparse
> > warning:
> > 
> > arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?
> > 
> > Fix by implementing Tony's suggestion to add a "sideways include" to the
> > new location of the debug-devices.h file in arch/arm/mach-omap2/.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Igor Grinberg <grinberg@compulab.co.il>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>

Thanks, applying into omap-for-v3.7-rc1/fixes-part2.

Regards,

Tony
 
> > ---
> >  arch/arm/plat-omap/debug-devices.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
> > index c7a4c09..5a4678e 100644
> > --- a/arch/arm/plat-omap/debug-devices.c
> > +++ b/arch/arm/plat-omap/debug-devices.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/smc91x.h>
> >  
> >  #include <mach/hardware.h>
> > +#include "../mach-omap2/debug-devices.h"
> >  
> >  /* Many OMAP development platforms reuse the same "debug board"; these
> >   * platforms include H2, H3, H4, and Perseus2.
> 
> -- 
> Regards,
> Igor.

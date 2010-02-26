From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCH 2/2] can:ti_hecc: board specific hookup on AM3517EVM
Date: Fri, 26 Feb 2010 16:25:01 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087030419499E@dbde02.ent.ti.com>
References: <1266907068-6210-1-git-send-email-srk@ti.com>
 <1266907068-6210-2-git-send-email-srk@ti.com>
 <1266907068-6210-3-git-send-email-srk@ti.com>
 <20100225220408.GL28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55859 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933370Ab0BZKzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 05:55:10 -0500
In-Reply-To: <20100225220408.GL28173@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, February 26, 2010 3:34 AM
> To: Govindarajan, Sriramakrishnan
> Cc: linux-omap@vger.kernel.org; Gole, Anant
> Subject: Re: [PATCH 2/2] can:ti_hecc: board specific hookup on AM3517EVM
> 
> * Sriramakrishnan <srk@ti.com> [100222 22:35]:
> > Add board specific hookup for TI HECC driver on
> > AM3517 EVM
> >
> > Signed-off-by: Sriramakrishnan <srk@ti.com>
> > Acked-by: Anant Gole <anantgole@ti.com>
> > ---
> > The driver requires that CAN_STB signal be driven low to enable
> > CAN PHY. Currently this is being managed from U-boot. Will submit a
> patch
> > for handling this as part of board init sequence.
> >
> >  arch/arm/mach-omap2/board-am3517evm.c     |   38
> +++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/include/mach/am35xx.h |   10 +++++++
> >  2 files changed, 48 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> omap2/board-am3517evm.c
> > index af99faf..42013b5 100644
> > --- a/arch/arm/mach-omap2/board-am3517evm.c
> > +++ b/arch/arm/mach-omap2/board-am3517evm.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/gpio.h>
> > +#include <linux/can/platform/ti_hecc.h>
> >
--- snip ----
> > +
> > +static struct ti_hecc_platform_data am3517_evm_hecc_pdata = {
> > +	.scc_hecc_offset        = AM35XX_HECC_SCC_HECC_OFFSET,
> > +	.scc_ram_offset         = AM35XX_HECC_SCC_RAM_OFFSET,
> > +	.hecc_ram_offset        = AM35XX_HECC_RAM_OFFSET,
> > +	.mbx_offset            = AM35XX_HECC_MBOX_OFFSET,
> > +	.int_line               = AM35XX_HECC_INT_LINE,
> > +	.version                = AM35XX_HECC_VERSION,
> > +};
> 
> The formatting above should use tabs instead of spaces. Please
> check and run checkpatch.pl --strict on this.
> 
> Also, sounds like the Kconfig changes should be 2/2, not 1/2
> to enable this.
> 
> Tony
> 
[Sriram] Tony, I did verify the patch with checkpatch(log below) but 
Somehow, it didn't flag any formatting errors. I realize that there are spaces that need to be converted to tabs. I will re-generate the patch and also re-order the patches as pointed out.

$scripts/checkpatch.pl --strict 2-2-can-ti_hecc-board-specific-hookup-on-AM3517EVM.patch
total: 0 errors, 0 warnings, 0 checks, 70 lines checked

2-2-can-ti_hecc-board-specific-hookup-on-AM3517EVM.patch has no obvious style problems and is ready for submission.

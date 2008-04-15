From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [PATCH 2/2] New Board file for OMAP3 EVM
Date: Tue, 15 Apr 2008 12:46:57 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0018C874C@dbde01.ent.ti.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8605@dbde01.ent.ti.com> <20080414181144.GB4463@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52794 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753341AbYDOHRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 03:17:11 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20080414181144.GB4463@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Monday, April 14, 2008 11:42 PM
> To: Syed Mohammed, Khasim
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/2] New Board file for OMAP3 EVM
> 
> On Mon, Apr 14, 2008 at 05:40:48PM +0530, Syed Mohammed, Khasim wrote:
> >
> > New board file for OMAP3 EVM
> >
> > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-omap3-evm.c |   79
> ++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> >
> > Index: my_branch/arch/arm/mach-omap2/board-omap3-evm.c
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ my_branch/arch/arm/mach-omap2/board-omap3-evm.c	2008-04-14
> 16:18:41.000000000 +0530
> > @@ -0,0 +1,79 @@
> > +/*
> > + * linux/arch/arm/mach-omap2/board-omap3-evm.c
> > + *
> > + * Copyright (C) 2008 Texas Instruments
> > + *
> > + * Modified from mach-omap2/board-3430sdp.c
> > + *
> > + * Initial code: Syed Mohammed Khasim
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */

<snip>

> > +static struct omap_board_config_kernel omap3_evm_config[] __initdata =
> {
> > +	{OMAP_TAG_UART,	&omap3_evm_uart_config },
> > +};
> > +
> > +static void __init omap3_evm_init(void)
> > +{
> > +	omap_board_config = omap3_evm_config;
> > +	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
> > +	omap_serial_init();
> > +}
> > +
> > +arch_initcall(omap3_evm_i2c_init);
> 
> why not putting the omap3_evm_i2c_init() call below
> omap_serial_init() inside omap3_evm_init()??
> 
I2C init needs clock init to be completed, I think this is good enough as it is in sync with other omap boards. 

Many thanks for reviewing the code.

Regards,
khasim

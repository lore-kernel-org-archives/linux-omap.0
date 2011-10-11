From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/8] ti816evm: Add support for musb interface
Date: Tue, 11 Oct 2011 21:58:17 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404ECCE5650@dbde02.ent.ti.com>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
 <1318332369-9732-4-git-send-email-ajay.gupta@ti.com>
 <4E9431DB.3070600@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42091 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694Ab1JKQ2c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Oct 2011 12:28:32 -0400
In-Reply-To: <4E9431DB.3070600@compulab.co.il>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "B, Ravi" <ravibabu@ti.com>, "Pedanekar, Hemant" <hemantp@ti.com>, Tony Lindgren <tony@atomide.com>

Hi,
> On 10/11/11 13:26, Ajay Kumar Gupta wrote:
> > From: Ravi Babu <ravibabu@ti.com>
> >
> > Adding musb support in ti816 EVM board file.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> > Signed-off-by: Ravi Babu <ravibabu@ti.com>
> > Acked-by: Felipe Balbi <balbi@ti.com>
> 
> This patch can result in a merge conflict, therefore I think
> this one should be taken through Tony's tree.
> 
> Also you should work together with Hemant Pedanekar and
> someone of you should rebase on top of the other otherwise
> one of the patches (yours or Hemant's) possibly will not apply.

Ok sure. I will submit the patches (v5) after creating it on top of
Hemant's and Vaibhav's patches.

Thanks,
Ajay
> 
> > ---
> >  arch/arm/mach-omap2/board-ti8168evm.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-
> omap2/board-ti8168evm.c
> > index 2c243df..1f3d423 100644
> > --- a/arch/arm/mach-omap2/board-ti8168evm.c
> > +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> > @@ -23,6 +23,14 @@
> >  #include <plat/irqs.h>
> >  #include <plat/board.h>
> >  #include <plat/common.h>
> > +#include <plat/usb.h>
> > +
> > +static struct omap_musb_board_data musb_board_data = {
> > +	.set_phy_power	= ti81xx_musb_phy_power,
> > +	.interface_type	= MUSB_INTERFACE_ULPI,
> > +	.mode           = MUSB_OTG,
> > +	.power		= 500,
> > +};
> >
> >  static struct omap_board_config_kernel ti8168_evm_config[] __initdata
> = {
> >  };
> > @@ -33,6 +41,7 @@ static void __init ti8168_evm_init(void)
> >  	omap_sdrc_init(NULL, NULL);
> >  	omap_board_config = ti8168_evm_config;
> >  	omap_board_config_size = ARRAY_SIZE(ti8168_evm_config);
> > +	usb_musb_init(&musb_board_data);
> >  }
> >
> >  static void __init ti8168_evm_map_io(void)
> 
> --
> Regards,
> Igor.

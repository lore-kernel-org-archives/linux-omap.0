From: "Janorkar, Mayuresh" <mayur@ti.com>
Subject: RE: [PATCH 6/7] OMAP4: DSS: Adding a picodlp in OMAP4430 SDP board
 file
Date: Thu, 21 Apr 2011 16:48:00 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB033D8839FC@dbde02.ent.ti.com>
References: <1303107350-22747-1-git-send-email-mayur@ti.com>
	 <1303107350-22747-7-git-send-email-mayur@ti.com>
 <1303214065.32281.47.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53061 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752387Ab1DULS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 07:18:27 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3LBINoj027641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 06:18:26 -0500
In-Reply-To: <1303214065.32281.47.camel@deskari>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>



> -----Original Message-----
> From: Valkeinen, Tomi
> Sent: Tuesday, April 19, 2011 5:24 PM
> To: Janorkar, Mayuresh
> Cc: linux-omap@vger.kernel.org; K, Mythri P
> Subject: Re: [PATCH 6/7] OMAP4: DSS: Adding a picodlp in OMAP4430 SDP
> board file
> 
> On Mon, 2011-04-18 at 11:45 +0530, Mayuresh Janorkar wrote:
> > An on-board panel named picodlp projector is available for OMAP4430 SDP.
> >
> > Entry for this panel is being added in dss_devices in the board file.
> > It also needs 4 GPIO pins and are defined and used in board file.
> > picodlp also needs an i2c client over i2c controller-2 at address 0x1b.
> >
> > Signed-off-by: Mayuresh Janorkar <mayur@ti.com>
> > Signed-off-by: Mythri P K <mythripk@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c |   40
> +++++++++++++++++++++++++++++++++++
> >  1 files changed, 40 insertions(+), 0 deletions(-)
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
> omap2/board-4430sdp.c
> > index 1503f0b..6827612
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -38,6 +38,7 @@
> >  #include <plat/omap4-keypad.h>
> >  #include <plat/display.h>
> >  #include <plat/nokia-dsi-panel.h>
> > +#include <plat/panel-picodlp.h>
> >
> >  #include "mux.h"
> >  #include "hsmmc.h"
> > @@ -585,6 +586,7 @@ static struct i2c_board_info __initdata
> sdp4430_i2c_boardinfo[] = {
> >  		.platform_data = &sdp4430_twldata,
> >  	},
> >  };
> > +
> 
> Unneeded change.

Fine.

> 
> >  static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
> >  	{
> >  		I2C_BOARD_INFO("tmp105", 0x48),
> > @@ -598,6 +600,7 @@ static struct i2c_board_info __initdata
> sdp4430_i2c_4_boardinfo[] = {
> >  		I2C_BOARD_INFO("hmc5843", 0x1e),
> >  	},
> >  };
> > +
> 
> Unneeded change.

Fine

> 
>  Tomi
> 


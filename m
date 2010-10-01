From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCHv3 6/17] dmtimer: add omap44xx hwmod database
Date: Fri, 1 Oct 2010 11:12:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CD0330B@dbde02.ent.ti.com>
References: <1285059188-26441-1-git-send-email-tarun.kanti@ti.com>
 <4CA501F0.5030203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57214 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab0JAFm7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 01:42:59 -0400
In-Reply-To: <4CA501F0.5030203@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

 

> -----Original Message-----
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara; Basak, 
> Partha; Paul Walmsley; Kevin Hilman; Tony Lindgren
> Subject: Re: [PATCHv3 6/17] dmtimer: add omap44xx hwmod database

<<snip>>

> > ---
> >   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  660 
> ++++++++++++++++++++++++++++
> >   1 files changed, 660 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > index e20b0ee..28d65e9 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -23,6 +23,8 @@
> >   #include<plat/omap_hwmod.h>
> >   #include<plat/cpu.h>
> >
> > +#include<plat/dmtimer.h>
> > +#include<plat/omap_device.h>

Why omap_device.h is required in hwmod database?

-V Charulatha

> >   #include "omap_hwmod_common_data.h"
> >
> >   #include "cm.h"

<<snip>>


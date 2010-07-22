From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: Add macros to evaluate cpu revision
Date: Thu, 22 Jul 2010 15:35:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C61C687F@dbde02.ent.ti.com>
References: <1279725163-3481-1-git-send-email-premi@ti.com>
 <4C4710DB.6060901@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0323B40084@dbde02.ent.ti.com>
 <4C481185.3090005@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7C764FD@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60865 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812Ab0GVKGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jul 2010 06:06:03 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6MA60Jq005592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 05:06:02 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6MA5xDk019286
	for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 15:35:59 +0530 (IST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7C764FD@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "Menon, Nishanth" <nm@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sanjeev,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Thursday, July 22, 2010 3:20 PM
> To: Menon, Nishanth; Gadiyar, Anand
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] omap: Add macros to evaluate cpu revision
> 
> > -----Original Message-----
> > From: Menon, Nishanth
> > Sent: Thursday, July 22, 2010 3:08 PM
> > To: Gadiyar, Anand
> > Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] omap: Add macros to evaluate cpu revision
> >
> > On 07/22/2010 01:53 AM, Gadiyar, Anand wrote:
> > >>> @@ -460,4 +461,35 @@ OMAP3_HAS_FEATURE(isp, ISP)
> > >>>   OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> > >>>   OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
> > >>>
> > >>> +/*
> > >>> + * Map revision bits to silicon specific revisions
> > >>> + */
> > >>> +#define ES_1_0		OMAP_REVBITS_00
> > >> probably need ES_1_1, 1_2 (considering 3630)
> > >
> > >
> > > This should be okay, since the 3630 is out with
> > > these revisions, but...
> > >
> > >>> +#define ES_2_0		OMAP_REVBITS_10
> > >>> +#define ES_2_1		OMAP_REVBITS_20
> > >> makes sense to go to 2_2
> > >>> +#define ES_3_0		OMAP_REVBITS_30
> > >>> +#define ES_3_1		OMAP_REVBITS_40
> > >>> +#define ES_3_1_2	OMAP_REVBITS_50
> > >> 3_2?
> > >
> > > This may not make sense to add now as there are no
> > > 2.2 or 3.2 revisions of any OMAP3/4 silicon?
> > >
> > Agreed for 3 and 4, but considering this is
> > arch/arm/plat-omap/include/plat/cpu.h, does it make sense in
> > looking all
> > OMAPs?
> 
> In this case, the best option would be to prefix OMAP34X_/ OMAP36X_
> OMAP44X_ etc and define the ES revisions for each context.
> 
Can please put the usecase need here. Do you want to use this for
ERRATA handling or OPP handling etc etc ?

Regards,
Santosh

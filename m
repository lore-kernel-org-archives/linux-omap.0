From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
 file
Date: Thu, 11 Mar 2010 15:01:18 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DD32B6B@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	 <1268297717-8062-1-git-send-email-hvaibhav@ti.com>
	 <1268297945.28571.81.camel@tubuntu.research.nokia.com>
	 <19F8576C6E063C45BE387C64729E7394044DD32B4F@dbde02.ent.ti.com>
 <1268299658.28571.89.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab0CKJbk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 04:31:40 -0500
In-Reply-To: <1268299658.28571.89.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: Thursday, March 11, 2010 2:58 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; tony@atomide.com
> Subject: RE: [PATCH-Fix] OMAP: Add DSI regulator supply to OMAP3EVM board
> file
> 
> 
> > > Are you sure vdvi is required by the panel? At least the panel in
> > > 3430SDP doesn't require it.
> > [Hiremath, Vaibhav] As I mentioned before also, we don't need vdvi supply
> for OMAP3EVM. Infact there is no supply like vdvi coming out of TWL4030
> > Since it was being used in panel file I had defined it. But now I can see
> that we are no longer using vdvi supply, so I can safely remove this supply.
> Thanks for pointing me to this.
> >
> > I have created another patch which will replace the vdvi with vdds_dsi
> regulator supply; I have tested it on OMAP3EVM.
> >
> > Please merge this patch, without this OMAP3EVM DSS/Fbdev will fail in
> regulator_get.
> 
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> 
> Board file changes will go through Tony. And you should generally send
> the patches as inline patches, not attachments.
[Hiremath, Vaibhav] Done, sent again.

Thanks,
Vaibhav

> 
>  Tomi
> 


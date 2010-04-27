From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] ARM:iommu support for OMAP4
Date: Tue, 27 Apr 2010 07:50:28 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B572408@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B216AE2@dlee03.ent.ti.com>
 <20100419.095028.193685755.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34798 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab0D0Muh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 08:50:37 -0400
In-Reply-To: <20100419.095028.193685755.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>


Hi,

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Monday, April 19, 2010 1:50 AM
> To: Kanigeri, Hari; paul@pwsan.com; khilman@deeprootsystems.com
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH] ARM:iommu support for OMAP4
> 
> Hi Hari,
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: [PATCH] ARM:iommu support for OMAP4
> Date: Fri, 16 Apr 2010 18:17:09 +0200
> 
> > From 708914e1a82a608d423b050cb31b4deb46eb8411 Mon Sep 17 00:00:00 2001
> > From: Hari Kanigeri <h-kanigeri2@ti.com>
> > Date: Mon, 8 Mar 2010 17:55:21 -0600
> > Subject: [PATCH] ARM:iommu support for OMAP4
> >
> > This patch provides the iommu support for OMAP4 co-processors.
> 
> This looks ok for now mostly. some minor fix are pointed out by
> Santosh, though.
> 
> In the long run, I guess that, this should be converted to "hwmod"?
> 
> ref: http://marc.info/?l=linux-omap&m=127012520411256&w=2 

Looks like for OMAP4 we currently don't have the mechanism to manage the 3 resets to Ducati (MMU, M3_0, M3_1) independently and they are all tied to one hwmod (ducati). I didn't check the OMAP3 implementation but hopefully the reset lines for MMU and IVA are not tied to one hwmod.

We would need independent control over these reset pins as RST3 (MMU) will be needed for programming MMU prior to bringing cores out of reset, RST_1 will be needed to control just M3_0 core, and RST_2 will be needed for M3_1.

I think until this change is done it will be difficult to migrate to hwmod for iommu.

Thank you,
Best regards,
Hari


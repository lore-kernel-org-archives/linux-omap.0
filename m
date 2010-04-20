From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] ARM:iommu support for OMAP4
Date: Tue, 20 Apr 2010 06:51:51 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B343B10@dlee03.ent.ti.com>
References: <AcrdgEPPAIDfiIBIR8aysAo+/YzhfA==>
	 <8F7AF80515AF0D4D93307E594F3CB40E4B216AE2@dlee03.ent.ti.com>
 <j2y94a0d4531004190011va5afdc92g5e9b1a204dee88b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54911 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081Ab0DTLv7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 07:51:59 -0400
In-Reply-To: <j2y94a0d4531004190011va5afdc92g5e9b1a204dee88b0@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> This looks like based on an old version of omap3-iommu.c; maybe you
> should update it.
>

-- I thought about doing this, but then I felt it doesn't make sense putting OMAP4 specific definitions in a file that is named after omap3 and all the functions in it having omap3 pre-fix.

May be we can rename the omap3-iommu file to omap-iommu and change omap3 prefix in functions to omap, and just change the devices structure based on the platform. This way it would look more generic to all OMAPs.

Please let me know your thoughts.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Monday, April 19, 2010 2:12 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Doyu Hiroshi (Nokia-D/Helsinki);
> Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH] ARM:iommu support for OMAP4
> 
> On Fri, Apr 16, 2010 at 7:17 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > From 708914e1a82a608d423b050cb31b4deb46eb8411 Mon Sep 17 00:00:00 2001
> > From: Hari Kanigeri <h-kanigeri2@ti.com>
> > Date: Mon, 8 Mar 2010 17:55:21 -0600
> > Subject: [PATCH] ARM:iommu support for OMAP4
> >
> > This patch provides the iommu support for OMAP4 co-processors.
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> 
> This looks like based on an old version of omap3-iommu.c; maybe you
> should update it.
> 
> --
> Felipe Contreras

From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/3][v2] OMAP:iommu support for OMAP4
Date: Tue, 20 Apr 2010 17:07:27 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B3BF8B8@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B3445E5@dlee03.ent.ti.com>
 <w2h94a0d4531004201448s1ad276f5ncf7c0de273481fe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54957 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab0DTWHc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 18:07:32 -0400
In-Reply-To: <w2h94a0d4531004201448s1ad276f5ncf7c0de273481fe2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>

Felipe,

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Tuesday, April 20, 2010 4:49 PM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; Hiroshi DOYU;
> tony@atomide.com
> Subject: Re: [PATCH 1/3][v2] OMAP:iommu support for OMAP4
> 
> On Wed, Apr 21, 2010 at 12:31 AM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> > From 9a6f91b0c108fd010afdb6bddcae92579c87fcbd Mon Sep 17 00:00:00 2001
> > From: Hari Kanigeri <h-kanigeri2@ti.com>
> > Date: Tue, 20 Apr 2010 12:03:03 -0500
> > Subject: [PATCH 1/3] OMAP:iommu support for OMAP4
> >
> > This patch provides the iommu support for OMAP4 co-processors.
> > This includes changes to omap3-iommu.c file to make it generic
> > for all OMAPs. Renamed omap3-iommu.c to omap-iommu.c
> 
> This smells like two patches: one that moves omap3-iommu to
> omap-iommu, and another one that adds omap4 support.
> 
> But unfortunately this would break multi-omap support. I think both
> omap3 and omap4 devices should be there, and selected at run-time.
> 

-- I am not sure as why this would break multi-omap support. We would select either OMAP3 or OMAP4 specific structures at compile time based on the platform selected, and rest of the code is same for both OMAP3/4.

> Cheers.
> 
> --
> Felipe Contreras

Thank you,
Best regards,
Hari

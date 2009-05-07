From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Thu, 7 May 2009 15:54:38 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2AED099C@dlee03.ent.ti.com>
References: <94a0d4530905071302g3510fdabne659a42bd9009909@mail.gmail.com>
	 <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2AED092B@dlee03.ent.ti.com>
 <94a0d4530905071339i7e67d1fm236af1858a6f13c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35615 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbZEGUyu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:54:50 -0400
In-Reply-To: <94a0d4530905071339i7e67d1fm236af1858a6f13c5@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Thursday, May 07, 2009 3:40 PM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; Felipe Contreras; Tony
> Lindgren
> Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
> 
> On Thu, May 7, 2009 at 11:28 PM, Kanigeri, Hari <h-kanigeri2@ti.com>
> wrote:
> >> Currently the iva2 code (tidspbridge) is not using iommu, therefore it
> >> can't be
> >> used as-is with the current omap iommu.
> >
> > Bridge can use IOMMU module that Hiroshi has sent by calling below 2
> lines of code.
> >
> > struct iommu *iva_iommu_ptr;
> > iva_iommu_ptr = iommu_get("iva2");
> 
> From where? Care to send an actual patch?
> 

I think it is in the initial set of patches that Hiroshi has sent some time ago.

He provided the link to it in this first email [patch 0/6].
http://marc.info/?l=linux-omap&m=122087083712670&w=2


Thank you,
Best regards,
Hari



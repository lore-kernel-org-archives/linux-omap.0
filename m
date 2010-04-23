From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
Date: Fri, 23 Apr 2010 08:46:04 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B4C2D80@dlee03.ent.ti.com>
References: <1271978196-26792-1-git-send-email-h-kanigeri2@ti.com>
	<1271978196-26792-5-git-send-email-h-kanigeri2@ti.com>
 <20100423.153411.116357255.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53179 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419Ab0DWNqZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 09:46:25 -0400
In-Reply-To: <20100423.153411.116357255.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Hiroshi,

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Friday, April 23, 2010 7:34 AM
> To: Kanigeri, Hari
> Cc: Gupta, Ramesh; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
> 
> Hi Hari,
> 
> From: ext Hari Kanigeri <h-kanigeri2@ti.com>
> Subject: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
> Date: Fri, 23 Apr 2010 01:16:36 +0200
> 
> > This patch adds TLB preservation support to IOMMU module
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > Signed-off-by: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
> 
> The above should be "Acked-by:"?

-- By you :)

> 
> BTW:
> Now the code gets a bit complicated for tlb iteration. So what about
> introducing the following macro?
> 
> Not yet tested, though....

-- I like it. Let me test your changes, and will send a revised patch with these changes.

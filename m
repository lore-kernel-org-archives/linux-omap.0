From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Wed, 28 Jan 2009 13:37:58 +0200 (EET)
Message-ID: <20090128.133758.55858977.Hiroshi.DOYU@nokia.com>
References: <20090117162139.GB12341@n2100.arm.linux.org.uk>
	<20090127.232935.68131092.Hiroshi.DOYU@nokia.com>
	<20090128104157.GC15907@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29727 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593AbZA1Lib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 06:38:31 -0500
In-Reply-To: <20090128104157.GC15907@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Wed, 28 Jan 2009 11:41:57 +0100

> On Tue, Jan 27, 2009 at 11:29:35PM +0200, Hiroshi DOYU wrote:
> > I attached the update one.
> 
> Thanks.  I want to hold off on taking these just a little bit longer.

OK. agreed.

> > +static const struct iommu_platform_data omap3_iommu_pdata[] __initconst = {
> > +     {
> > +             .name = "isp",
> > +             .nr_tlb_entries = 8,
> > +             .clk_name = "cam_ick",
> > +     },
> > +     {
> > +             .name = "iva2",
> > +             .nr_tlb_entries = 32,
> > +             .clk_name = "iva2_ck",
> 
> With the omap clk implementation in a state of flux, hopefully moving
> towards something which better reflects the intentions of the clk API,
> passing clk names around becomes entirely wasteful and unnecessary.
> 
> That's not to say that what you currently have won't work with the patches
> as they currently stand - it will work as is.  I'd just rather avoid
> having to have a separate patch to convert this code as well.

OK. I'll update later, then.

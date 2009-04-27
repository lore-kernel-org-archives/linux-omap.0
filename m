From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC] dspbridge: staging todo list
Date: Mon, 27 Apr 2009 06:52:31 +0300 (EEST)
Message-ID: <20090427.065231.116358333.Hiroshi.DOYU@nokia.com>
References: <983c694e0904260907o2e10da56xffeade20f1b3ff7c@mail.gmail.com>
	<20090426.203643.35024594.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2AA64125@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:39738 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbZD0Dwp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Apr 2009 23:52:45 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2AA64125@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com, tony@atomide.com
Cc: or.rmz1@gmail.com, linux-omap@vger.kernel.org, menon.nishanth@gmail.com, felipe.contreras@gmail.com, ameya.palande@nokia.com, dedekind@yandex.ru, grgupta@ti.com

Hi Hari,

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC] dspbridge: staging todo list
Date: Mon, 27 Apr 2009 05:05:38 +0200

> Hi,
> 
> > This DMM feature should be replaced with "omap iommu" driver which
> > commonly supports omap iommu feature. Currently it supports just a
> > mapping of in-kernel buffers(contiguous/discontiguous), but will be
> > extened to an user buffer soon. Anyway, "bitmap_find_free_region"
> > would bring better performance if the number of VMAs becomes huge.
> >
> 
> -- DMM is dynamic memory mapping, where DSP VA is mapped to Physical
> address of the buffers allocated by Multimedia applications. At
> present, Bridge is using its own version of MMU module for mapping
> the DSP VA to physical address, and this Bridge's MMU module can be
> replaced with the omap iommu. But before we do that, following
> things need to happen:
> 
> 	- The iommu should reside in linux-omap tree :)

Tony may keep it on one of the l-o branches. Anyway, I'll send them
again to Russell.

> 	- IOMMU module provides support for preservation of TLB
> 	  entries.

Yes, it's necessary for the performance.

> 	- IOMMU module provides support for notification of MMU
> 	  faults.

Actually the mmu fault hander can be set by a client module, but at
present, the registration interface is missing. I'll add this
interface.

> I did some basic sanity testing in Bridge by replacing the Bridge's
> MMU module with the iommu module and the above items need to happen
> before we migrate to use iommu.

Thank you for your evaluation. I'll send the update version of iommu
patchset soon.

	 Hiroshi DOYU





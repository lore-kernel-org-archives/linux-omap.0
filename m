From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Wed, 02 Jun 2010 14:06:44 +0300 (EEST)
Message-ID: <20100602.140644.70200461.Hiroshi.DOYU@nokia.com>
References: <20100602.105054.59678037.Hiroshi.DOYU@nokia.com>
	<20100602100100.GJ6465@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23112 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0FBLG7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 07:06:59 -0400
In-Reply-To: <20100602100100.GJ6465@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, h-kanigeri2@ti.com

Hi Felipe,

From: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Subject: Re: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Wed, 2 Jun 2010 12:01:00 +0200

> On Wed, Jun 02, 2010 at 09:50:54AM +0200, Doyu Hiroshi (Nokia-D/Helsinki) wrote:
>>      omap iommu: Introduce iopgd_is_table MACRO
>>      omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr
> 
> should these two be here or should they go to 2.6.36 merge window ? at 
> least from the description it doesn't look like they are fixing any 
> bugs.
> 
>>      omap iommu: add functionality to get TLB miss interrupt
> 
> for this "add functionality to get TLB miss interrupt"
> 
> the other two look suspicious looking only at the description.

This subject might be misleading.

These patches are for for-next, which means for v2.6.36. "v2.6.35-rc1"
on subject implies the base TAG for these patches.

For fixes: http://marc.info/?l=linux-omap&m=127546506730794&w=2



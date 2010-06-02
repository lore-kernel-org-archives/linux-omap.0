From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [GIT PULL] omap iommu: for-next for 2.6.35-rc1
Date: Wed, 2 Jun 2010 13:01:00 +0300
Message-ID: <20100602100100.GJ6465@nokia.com>
References: <20100602.105054.59678037.Hiroshi.DOYU@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:18167 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757722Ab0FBKBt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 06:01:49 -0400
Content-Disposition: inline
In-Reply-To: <20100602.105054.59678037.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "h-kanigeri2@ti.com" <h-kanigeri2@ti.com>

On Wed, Jun 02, 2010 at 09:50:54AM +0200, Doyu Hiroshi (Nokia-D/Helsinki) wrote:
>      omap iommu: Introduce iopgd_is_table MACRO
>      omap iommu: Rename iopte_[p,v]addr -> iopte_page_[p,v]addr

should these two be here or should they go to 2.6.36 merge window ? at 
least from the description it doesn't look like they are fixing any 
bugs.

>      omap iommu: add functionality to get TLB miss interrupt

for this "add functionality to get TLB miss interrupt"

the other two look suspicious looking only at the description.

-- 
balbi

DefectiveByDesign.org

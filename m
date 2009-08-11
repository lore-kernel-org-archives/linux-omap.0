From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] omap iommu: add initial debugfs support
Date: Tue, 11 Aug 2009 11:53:37 +0300 (EEST)
Message-ID: <20090811.115337.70184536.Hiroshi.DOYU@nokia.com>
References: <1248272642-5200-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23466 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbZHKMIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2009 08:08:10 -0400
In-Reply-To: <1248272642-5200-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org

Hi Tony,

From: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Subject: [PATCH 1/1] omap iommu: add initial debugfs support
Date: Wed, 22 Jul 2009 16:24:02 +0200

> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> This enables to peek the following data.
> 
> $ /debug/iommu/isp# ls
> mem             nr_tlb_entries  regs
> mmap            pagetable       tlb
> $ /debug/iommu/isp# head pagetable
> L:      da:      pa:
> -----------------------------------------
> 2: 00001000 8ae4a002
> 2: 00002000 8e7bb002
> 2: 00003000 8ae49002
> 2: 00004000 8ae65002
> .....
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Please apply this one too if there's no problem.

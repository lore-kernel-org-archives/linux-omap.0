From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: hwmod/PMU/PRCM patches for 3.7
Date: Sun, 23 Sep 2012 19:30:31 -0700
Message-ID: <20120924023031.GW28835@atomide.com>
References: <alpine.DEB.2.00.1209210103140.6888@utopia.booyaka.com>
 <20120921205322.GK28835@atomide.com>
 <20120921231039.GN28835@atomide.com>
 <alpine.DEB.2.00.1209220002290.6510@utopia.booyaka.com>
 <20120922002111.GP28835@atomide.com>
 <alpine.DEB.2.00.1209220211090.8626@utopia.booyaka.com>
 <20120923190933.GS28835@atomide.com>
 <20120923210638.GT28835@atomide.com>
 <alpine.DEB.2.00.1209240102290.31370@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:26019 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754764Ab2IXCaf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Sep 2012 22:30:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209240102290.31370@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120923 18:09]:
> On Sun, 23 Sep 2012, Tony Lindgren wrote:
> 
> > Or maybe it's possible to split the series into smaller chunks
> > that can be pulled in to the existing branches without causing
> > new merge conflicts?
> 
> Well here's what I did, hopefully it's suitable.  Built a tag with all of 
> the clock and hwmod/runtime PM patches together, and based it on v3.6-rc6 
> + omap-cleanup-b-for-3.7 + cleanup-fixes-for-v3.7 + 
> omap-devel-am33xx-for-v3.7.  All of these are upstream.
> 
> Then I did a test merge with your commit 
> 219e2d6f43760509a0f0a084e8aa4711efb78c56:
> 
>   git checkout -b temp_tmlind_merge
>   git reset --hard 219e2d6f43760509a0f0a084e8aa4711efb78c56
>   git merge omap-devel-b-c-2-for-3.7
> 
> There are two conflicts, both trivial, and the patch below is how they got 
> resolved here.
> 
> Then probably you'll want to add Santosh's branch back in on top of that.

OK thanks, that should work. The nasty merge conflicts seem to have been
caused by mostly commit df3d17e0 (ARM: pmu: remove arm_pmu_type enumeration)
that easily causes a nasty mis-merge of omap_init_pmu() and omap_init_rng()
without removing omap_init_pmu() which your patches move to a different
location.

Regards,

Tony

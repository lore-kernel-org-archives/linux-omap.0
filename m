From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PRCM/runtime PM patches for 3.7
Date: Sun, 23 Sep 2012 20:04:13 -0700
Message-ID: <20120924030413.GX28835@atomide.com>
References: <alpine.DEB.2.00.1209240058530.31370@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31175 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753465Ab2IXDEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Sep 2012 23:04:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1209240058530.31370@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120923 18:01]:
> Hi Tony
> 
> The following changes since commit 1e2ee2a60df5c3ab74dd1c9155fb01b5bc6f807d:
> 
>   Merge tag 'omap-devel-am33xx-for-v3.7' into test_v3.6-rc6_ocb3.7_cff3.7_odaf3.7 (2012-09-23 17:16:04 -0600)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-c-2-for-3.7
> 
> for you to fetch changes up to 76a5d9bfc42d60e9a672e0cae776157a60970f4e:
> 
>   ARM: OMAP4460/4470: PMU: Enable PMU for OMAP4460/70 (2012-09-23 17:28:30 -0600)
> 
> ----------------------------------------------------------------
> OMAP patches intended for the 3.7 merge window:
> 
> - Runtime PM conversions for the GPMC and RNG IP blocks
> - Preparation patches for the OMAP common clock framework conversion
> - clkdev alias additions required by other drivers
> - Performance Monitoring Unit (PMU) support for OMAP2, 3, and non-4430 OMAP4
> - OMAP hwmod code and data improvements
> - Preparation patches for the IOMMU runtime PM conversion
> - Preparation patches for OMAP4 full-chip retention support
> 
> Based on a merge of v3.6-rc6, the omap-cleanup-b-for-3.7 tag
> (7852ec0536ca39cefffc6301dc77f8ae55592926),the cleanup-fixes-for-v3.7
> tag (de6ca33a96a6bf61fcb91d3d399703e19ead9d1e), and the
> omap-devel-am33xx-for-v3.7 tag
> (11964f53eb4d9ce59a058be9999d9cfcb1ced878), due to dependencies.

Thanks, yeah this one works. Pulled into devel-late branch.

Regards,

Tony

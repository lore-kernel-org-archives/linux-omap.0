From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix some omap_device_build() calls that
 aren't compiled by default
Date: Tue, 12 Feb 2013 09:11:57 -0800
Message-ID: <20130212171156.GH4801@atomide.com>
References: <alpine.DEB.2.00.1302120358130.14983@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41839 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932366Ab3BLRMB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 12:12:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302120358130.14983@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130211 20:02]:
> 
> Commit c1d1cd597fc77af3086470f8627d77f52f7f8b6c ("ARM: OMAP2+:
> omap_device: remove obsolete pm_lats and early_device code") missed a
> few omap_device_build() calls that aren't included as part of the default
> OMAP2+ Kconfig, omap2plus_defconfig.
> 
> Ideally, all devices that are present on the SoC should be created by
> default, and only the corresponding device driver should be configured
> or deconfigured in Kconfig.  This allows drivers to be built as
> modules and loaded later, even if they weren't part of the original
> kernel build.  Unfortunately, we're not quite there yet.
> 
> Thanks to Tony Lindgren for reporting this, found during his
> randconfig tests.

Thanks, I'll apply this into omap-for-v3.9/pm-wfi as the breaking
commit is already in arm-soc/for-next.

Tony

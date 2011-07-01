From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap iommu fixes for v3.0-rc
Date: Fri, 1 Jul 2011 00:00:56 -0700
Message-ID: <20110701070056.GZ23145@atomide.com>
References: <BANLkTi=vd2TE6JjueGmY=ydRQRygo8-Q1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64319 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755130Ab1GAHA7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 03:00:59 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=vd2TE6JjueGmY=ydRQRygo8-Q1Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm <linux-arm-kernel@lists.infradead.org>

* Ohad Ben-Cohen <ohad@wizery.com> [110630 23:47]:
> Hi Tony,
> 
> Please pull from:
> 
> git://github.com/ohadbc/omap-iommu.git for-tony
> 
> To receive trivial iommu/iovmm fixes (iommu clk name fix, pte fix and
> a fix for iovmm's erroneous
> usage of sg_dma_len as reported by Russell).
> 
> All three patches were submitted to linux-omap and linux-arm-kernel for review,
> and are also attached below for convenience.

These look like real fixes, but can you please update the commits
with something like "This fixes an issue with foo when doing bar".

Otherwise it's easy to claim that these are "fixes for features that
never worked" and it might be hard to justify them this late into
the -rc cycle.

Tony

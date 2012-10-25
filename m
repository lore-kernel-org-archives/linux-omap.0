From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/16] ARM: OMAP2: Move plat/menelaus.h to
 linux/mfd/menelaus.h
Date: Thu, 25 Oct 2012 12:03:32 -0700
Message-ID: <20121025190332.GX11928@atomide.com>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
 <20121004220451.26676.62349.stgit@muffinssi.local>
 <20121025111158.GA5297@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37172 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934816Ab2JYTDf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 15:03:35 -0400
Content-Disposition: inline
In-Reply-To: <20121025111158.GA5297@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Samuel Ortiz <sameo@linux.intel.com> [121025 04:14]:
> Hi Tony,
> 
> On Thu, Oct 04, 2012 at 03:04:52PM -0700, Tony Lindgren wrote:
> > We can move menelaus.h to live with other mfd headers to
> > get it out of plat for ARM common zImage support.
> > 
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Thanks, I've now pushed a branch with this patch only
to omap-for-v3.8/cleanup-headers-menelaus branch in case
you need to merge it in too.

Regards,

Tony

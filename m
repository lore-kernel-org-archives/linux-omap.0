From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/7] Add L2 cache cleaning to generic CPU suspend
Date: Tue, 20 Sep 2011 08:46:25 +0100
Message-ID: <20110920074624.GF16591@n2100.arm.linux.org.uk>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk> <20110920034717.GG28084@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37664 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab1ITHqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 03:46:36 -0400
Content-Disposition: inline
In-Reply-To: <20110920034717.GG28084@S2100-06.ap.freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 20, 2011 at 11:47:18AM +0800, Shawn Guo wrote:
> On Mon, Sep 19, 2011 at 05:37:41PM +0100, Russell King - ARM Linux wrote:
> > This is a re-post of the previous patch series, but with an additional
> > TLB flush to ensure that hte global TLB entry in the page tables is
> > flushed out.  This is a flush of all TLB entries, but it could probably
> > be more targetted if we need to.
> > 
> 
> Here is the diff on suspend.c between last post and this series.  With
> the outer_clean_range() calls added back, the series works fine on
> imx6q, otherwise it hangs on resume.

You seem to be missing patch 7 from the second series.

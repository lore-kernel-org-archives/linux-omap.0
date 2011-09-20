From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 0/7] Add L2 cache cleaning to generic CPU suspend
Date: Tue, 20 Sep 2011 16:04:06 +0800
Message-ID: <20110920080405.GA28389@S2100-06.ap.freescale.net>
References: <20110919163741.GE16591@n2100.arm.linux.org.uk>
 <20110920034717.GG28084@S2100-06.ap.freescale.net>
 <20110920074624.GF16591@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:45660
	"EHLO DB3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752556Ab1ITHyb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 03:54:31 -0400
Content-Disposition: inline
In-Reply-To: <20110920074624.GF16591@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 20, 2011 at 08:46:25AM +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 20, 2011 at 11:47:18AM +0800, Shawn Guo wrote:
> > On Mon, Sep 19, 2011 at 05:37:41PM +0100, Russell King - ARM Linux wrote:
> > > This is a re-post of the previous patch series, but with an additional
> > > TLB flush to ensure that hte global TLB entry in the page tables is
> > > flushed out.  This is a flush of all TLB entries, but it could probably
> > > be more targetted if we need to.
> > > 
> > 
> > Here is the diff on suspend.c between last post and this series.  With
> > the outer_clean_range() calls added back, the series works fine on
> > imx6q, otherwise it hangs on resume.
> 
> You seem to be missing patch 7 from the second series.
> 
Oops, indeed.  So on imx6q for all the series:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn


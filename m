From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/16] ARM: omap: fix oops in arch/arm/mach-omap2/vp.c
 when pmic is not found
Date: Thu, 9 Feb 2012 08:51:52 -0800
Message-ID: <20120209165151.GG16877@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAV6-0006Gj-Di@rmk-PC.arm.linux.org.uk>
 <20120208183333.GA29796@atomide.com>
 <20120208234654.GC16877@atomide.com>
 <20120209164419.GA19159@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22813 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab2BIQv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 11:51:56 -0500
Content-Disposition: inline
In-Reply-To: <20120209164419.GA19159@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120209 08:13]:
> On Wed, Feb 08, 2012 at 03:46:54PM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [120208 10:02]:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:05]:
> > > 
> > > This is better than Kevin's earlier patch because of the descriptive
> > > error:
> > > 
> > > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > Hmm looks like the patch from Ahilash that Kevin queued has the
> > also a test for missing uv_to_vsel:
> > 
> > if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel)
> > 
> > So there seems to be more to it than what Russell's patch is
> > doing.
> 
> So, through the discussion in patch 5, do you want me to add the
> second check to my patch 1?

Yes, please do.

Regards,

Tony

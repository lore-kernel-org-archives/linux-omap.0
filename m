From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/16] ARM: omap: fix oops in arch/arm/mach-omap2/vp.c
	when pmic is not found
Date: Thu, 9 Feb 2012 16:44:20 +0000
Message-ID: <20120209164419.GA19159@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk> <E1RvAV6-0006Gj-Di@rmk-PC.arm.linux.org.uk> <20120208183333.GA29796@atomide.com> <20120208234654.GC16877@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49018 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab2BIQo0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 11:44:26 -0500
Content-Disposition: inline
In-Reply-To: <20120208234654.GC16877@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 08, 2012 at 03:46:54PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120208 10:02]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:05]:
> > 
> > This is better than Kevin's earlier patch because of the descriptive
> > error:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Hmm looks like the patch from Ahilash that Kevin queued has the
> also a test for missing uv_to_vsel:
> 
> if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel)
> 
> So there seems to be more to it than what Russell's patch is
> doing.

So, through the discussion in patch 5, do you want me to add the
second check to my patch 1?

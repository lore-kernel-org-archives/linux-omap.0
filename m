From: Tony Lindgren <tony@atomide.com>
Subject: Re: Please fix lcd_sx1.c
Date: Mon, 24 Nov 2008 13:20:07 -0800
Message-ID: <20081124212003.GC11997@atomide.com>
References: <20081123164618.GA17438@flint.arm.linux.org.uk> <20081123165748.GC17438@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58480 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753095AbYKXVUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2008 16:20:11 -0500
Content-Disposition: inline
In-Reply-To: <20081123165748.GC17438@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081123 08:58]:
> On Sun, Nov 23, 2008 at 04:46:18PM +0000, Russell King - ARM Linux wrote:
> > To me, it looks like this driver was tossed over into mainline without
> > any thought - it has never been in a buildable state.  Please fix or
> > remove this driver from mainline.
> 
> Actually, it was buildable, until this commit:
> 
> commit b4b58f5834a023dab67201db9a626bef07bb200c
> Author: Chandra Shekhar <x0044955@ti.com>
> Date:   Wed Oct 8 10:01:39 2008 +0300
> 
>     ARM: OMAP: Allocate McBSP devices dynamically
>     
>     Based on Chandra's earlier patches in linux-omap tree.
>     
>     Note that omap1_mcbsp_check and omap2_mcbsp_check are no longer
>     needed as there's now omap_mcbsp_check_valid_id() defined.
>     
>     Also some functions can now be marked __init.
>     
>     Signed-off-by: Chandra Shekhar <x0044955@ti.com>
>     Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> which means it's a regression and therefore needs fixing before 2.6.28.

Will send you a patch for this today.

Regards,

Tony

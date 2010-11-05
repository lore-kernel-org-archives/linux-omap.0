From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch v4] OMAP: AM3517/05: Add craneboard support
Date: Fri, 5 Nov 2010 14:54:09 -0700
Message-ID: <20101105215409.GA9264@atomide.com>
References: <1288336394-6320-1-git-send-email-srinath@mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56579 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab0KEVy0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 17:54:26 -0400
Content-Disposition: inline
In-Reply-To: <1288336394-6320-1-git-send-email-srinath@mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: srinath@mistralsolutions.com
Cc: linux-omap@vger.kernel.org, jdk@ti.com, khilman@deeprootsystems.com, nm@ti.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com

* srinath@mistralsolutions.com <srinath@mistralsolutions.com> [101029 00:19]:
> From: Srinath <srinath@mistralsolutions.com>
> 
> Craneboard is a hardware development platform based on the
> Sitara AM3517 ARM Cortex - A8 microprocessor device. This is a
> low cost reference design.
> 
> This patch adds basic board file. Detailed support will follow in
> subsequent patches.
> 
>   [1] http://www.ti.com/sitara
>   [2] http://www.ti.com/arm
>   [3] http://tiexpressdsp.com/index.php?title=Applications_Processors_Crossreference
>   [4] http://marc.info/?l=linux-omap&m=125615009412281&w=2
>   [5] http://www.mistralsolutions.com/products/craneboard.php

Are all these links needed? To me it seems that [2] and [5]
should be enough?
 
> History and comments:
> http://marc.info/?l=linux-omap&w=2&r=1&s=craneboard&q=b

This history and comments link you can leave out, the official
history starts when it gets to the mainline kernel tree.

Anyways, please repost one more time with linux-arm-kernel
mailing list Cc'd so I don't have to repost your patch
before merging.

Regards,

Tony

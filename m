From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 0/9] OMAP: DMA: hwmod and DMA as platform device
Date: Tue, 14 Dec 2010 15:19:23 -0800
Message-ID: <20101214231922.GC14990@atomide.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54596 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab0LNXTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 18:19:30 -0500
Content-Disposition: inline
In-Reply-To: <1291434246-30716-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* G, Manjunath Kondaiah <manjugk@ti.com> [101203 19:33]:
> *************************************************************************
> 
> Test Report:
> ************
> Build:
> omap2plus_defconfig    : Success
> omap_osk_5912_defconfig: Success
> 
> Boot:
> OMAP3530Beagle         : Success
> OMAP4430Blaze(ES2.1)   : Success

Can you please make sure that memory to memory DMA test
runs OK on OSK5912?x

AFAIK, Kevin tried it a few days ago and it hung.

To me that sounds like the only remaining issue merging these
in for testing.

Regards,

Tony

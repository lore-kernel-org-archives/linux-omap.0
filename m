From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] omap3: iovmm: Work around sg_alloc_table size
 limitation in IOMMU
Date: Tue, 31 May 2011 06:22:33 -0700
Message-ID: <20110531132233.GQ11352@atomide.com>
References: <1306759629-17232-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1306759629-17232-2-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16838 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751282Ab1EaNWg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 May 2011 09:22:36 -0400
Content-Disposition: inline
In-Reply-To: <1306759629-17232-2-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, teemu.tuominen@cybercom.com

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [110530 05:43]:
> sg_alloc_table can only allocate multi-page scatter-gather list tables
> if the architecture supports scatter-gather lists chaining. ARM doesn't
> fit in that category.
> 
> The IOMMU driver abuses the sg table structure only to hold page
> addresses without ever passing the table to the device.
> 
> Use __sg_alloc_table instead of sg_alloc_table and allocate all entries
> in one go. This avoids hitting a BUG_ON in __sg_alloc_table while still
> not faking sg list chaining support.

Can you please update the patch description with something like "Otherwise
foo will happen and bar does not work"?

Otherwise these will go into "features that never worked" category for
a later merge window.

Regards,

Tony

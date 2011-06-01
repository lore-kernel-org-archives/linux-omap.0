From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] omap3: iovmm: Work around sg_alloc_table size
 limitation in IOMMU
Date: Wed, 1 Jun 2011 06:11:44 -0700
Message-ID: <20110601131144.GG11352@atomide.com>
References: <20110531132233.GQ11352@atomide.com>
 <1306931102-10943-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37390 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750753Ab1FANLq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 09:11:46 -0400
Content-Disposition: inline
In-Reply-To: <1306931102-10943-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [110601 05:21]:
> sg_alloc_table can only allocate multi-page scatter-gather list tables
> if the architecture supports scatter-gather lists chaining. ARM doesn't
> fit in that category.
> 
> The IOMMU driver abuses the sg table structure only to hold page
> addresses without ever passing the table to the device.
> 
> Use __sg_alloc_table instead of sg_alloc_table and allocate all entries
> in one go. Otherwise trying to use a large userspace to capture video
> will hit a BUG_ON in __sg_alloc_table.

Is the "large userspace" above missing a word like buffer?

Tony

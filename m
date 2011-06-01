From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] omap3: iovmm: Support non page-aligned buffers
 in iommu_vmap
Date: Wed, 1 Jun 2011 05:50:24 -0700
Message-ID: <20110601125024.GD11352@atomide.com>
References: <20110531132233.GQ11352@atomide.com>
 <1306931102-10943-2-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:35251 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750915Ab1FAMu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 08:50:26 -0400
Content-Disposition: inline
In-Reply-To: <1306931102-10943-2-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [110601 05:21]:
> The IOMMU virtual memory mapping API requires page-aligned buffers.
> There's no hardware reason behind such a restriction. Remove it by
> rounding the address of the first page entry down, and adding the offset
> back to the IOMMU virtual address.

Does this one also fix some bug?

Tony

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 2/2] omap3: iovmm: Support non page-aligned buffers in iommu_vmap
Date: Wed, 1 Jun 2011 15:09:05 +0200
Message-ID: <201106011509.05514.laurent.pinchart@ideasonboard.com>
References: <20110531132233.GQ11352@atomide.com> <1306931102-10943-2-git-send-email-laurent.pinchart@ideasonboard.com> <20110601125024.GD11352@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:41968 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab1FANJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 09:09:07 -0400
In-Reply-To: <20110601125024.GD11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 01 June 2011 14:50:24 Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [110601 05:21]:
> > The IOMMU virtual memory mapping API requires page-aligned buffers.
> > There's no hardware reason behind such a restriction. Remove it by
> > rounding the address of the first page entry down, and adding the offset
> > back to the IOMMU virtual address.
> 
> Does this one also fix some bug?

Yes, but no oops. It fixes an OMAP3 ISP failure when the buffer passed from 
userspace is not page-aligned.

-- 
Regards,

Laurent Pinchart

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] iommu: Remove OMAP IOVMM driver
Date: Wed, 23 Jul 2014 23:54:12 -0700
Message-ID: <20140724065412.GH22006@atomide.com>
References: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <20140722061929.GD18374@atomide.com>
 <20140723135217.GE31450@8bytes.org>
 <4101565.HEj9dhtF5Z@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:65257 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934061AbaGXGzk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jul 2014 02:55:40 -0400
Content-Disposition: inline
In-Reply-To: <4101565.HEj9dhtF5Z@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Joerg Roedel <joro@8bytes.org>, Suman Anna <s-anna@ti.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140723 07:02]:
> Hi Joerg,
> 
> On Wednesday 23 July 2014 15:52:17 Joerg Roedel wrote:
> > On Mon, Jul 21, 2014 at 11:19:29PM -0700, Tony Lindgren wrote:
> > > > Tony, is there still time to get this (and especially patch 2/3, which
> > > > touches arch/ code) in v3.17 ?
> > > 
> > > Yes as long as Joerg is OK to merge that branch in :)
> > 
> > Fine with me, I can take only patch 1 or all 3 into my arm/omap branch,
> > given Tony's Acked-by.
> > 
> > Then you guys can merge in this branch wherever you want :)
> 
> Thank you. Assuming there's currently no conflict to be resolved, I believe 
> the easiest would be for both you and Tony to merge my branch in your trees.

Yes please merge that branch via the IOMMU tree, I only need to merge it
if I see merge conflicts with it.

Regards,

Tony

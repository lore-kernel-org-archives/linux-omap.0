From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 0/3] iommu: Remove OMAP IOVMM driver
Date: Wed, 23 Jul 2014 16:00:47 +0200
Message-ID: <4101565.HEj9dhtF5Z@avalon>
References: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com> <20140722061929.GD18374@atomide.com> <20140723135217.GE31450@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:48855 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbaGWOAd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2014 10:00:33 -0400
In-Reply-To: <20140723135217.GE31450@8bytes.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Hi Joerg,

On Wednesday 23 July 2014 15:52:17 Joerg Roedel wrote:
> On Mon, Jul 21, 2014 at 11:19:29PM -0700, Tony Lindgren wrote:
> > > Tony, is there still time to get this (and especially patch 2/3, which
> > > touches arch/ code) in v3.17 ?
> > 
> > Yes as long as Joerg is OK to merge that branch in :)
> 
> Fine with me, I can take only patch 1 or all 3 into my arm/omap branch,
> given Tony's Acked-by.
> 
> Then you guys can merge in this branch wherever you want :)

Thank you. Assuming there's currently no conflict to be resolved, I believe 
the easiest would be for both you and Tony to merge my branch in your trees.

-- 
Regards,

Laurent Pinchart


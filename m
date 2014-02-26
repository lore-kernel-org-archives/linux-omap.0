From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 08/16] ARM: OMAP3: remove deprecated
 CONFIG_OMAP_IOMMU_IVA2
Date: Wed, 26 Feb 2014 09:09:09 -0800
Message-ID: <20140226170909.GE11654@atomide.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
 <1392315347-32967-9-git-send-email-s-anna@ti.com>
 <1488816.z8hE0Kk16e@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbaBZRJY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2014 12:09:24 -0500
Content-Disposition: inline
In-Reply-To: <1488816.z8hE0Kk16e@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Suman Anna <s-anna@ti.com>, Joerg Roedel <joro@8bytes.org>, Florian Vaussard <florian.vaussard@epfl.ch>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [140225 13:18]:
> On Thursday 13 February 2014 12:15:39 Suman Anna wrote:
> > From: Florian Vaussard <florian.vaussard@epfl.ch>
> > 
> > CONFIG_OMAP_IOMMU_IVA2 was defined originally to avoid conflicting
> > usage by tidspbridge and other iommu users. The same can be achieved
> > by marking the DT node disabled, so remove this obsolete flag and
> > the corresponding hwmod data can be enabled.
> > 
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> > [s-anna@ti.com: revise commit log]
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Tony Lindgren <tony@atomide.com>

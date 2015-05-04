From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] arm: dts: omap3: Add #iommu-cells to isp and iva iommu
Date: Mon, 4 May 2015 09:13:09 -0700
Message-ID: <20150504161309.GJ24469@atomide.com>
References: <1427765290-4148-1-git-send-email-sre@kernel.org>
 <20150331063346.GG18321@valkosipuli.retiisi.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:48981 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbbEDQNM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 May 2015 12:13:12 -0400
Content-Disposition: inline
In-Reply-To: <20150331063346.GG18321@valkosipuli.retiisi.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

* Sakari Ailus <sakari.ailus@iki.fi> [150330 23:34]:
> On Tue, Mar 31, 2015 at 03:28:10AM +0200, Sebastian Reichel wrote:
> > Add missing #iommu-cells property to the isp and iva iommu nodes. This
> > fixes the binding (property is required according to the generic iommu
> > binding) and removes the following kernel warning triggered once the
> > iommu nodes are referenced:
> > 
> > [    0.647521] /ocp/isp@480bc000: could not get #iommu-cells for /ocp/mmu@480bd400
> > 
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > Cc: Sakari Ailus <sakari.ailus@iki.fi>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks!
> 
> Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

Applying into omap-for-v4.1/fixes thanks.

Tony

From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCHv2] arm: dts: omap3: Add #iommu-cells to isp and iva iommu
Date: Tue, 31 Mar 2015 09:33:46 +0300
Message-ID: <20150331063346.GG18321@valkosipuli.retiisi.org.uk>
References: <1427765290-4148-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:41545 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750769AbbCaGdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 02:33:50 -0400
Content-Disposition: inline
In-Reply-To: <1427765290-4148-1-git-send-email-sre@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Tue, Mar 31, 2015 at 03:28:10AM +0200, Sebastian Reichel wrote:
> Add missing #iommu-cells property to the isp and iva iommu nodes. This
> fixes the binding (property is required according to the generic iommu
> binding) and removes the following kernel warning triggered once the
> iommu nodes are referenced:
> 
> [    0.647521] /ocp/isp@480bc000: could not get #iommu-cells for /ocp/mmu@480bd400
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@iki.fi>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk

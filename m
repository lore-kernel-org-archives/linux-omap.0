From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Fri, 14 Sep 2012 16:46:23 -0600
Message-ID: <5053B3BF.40500@wwwdotorg.org>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:45996 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760169Ab2INWq1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 18:46:27 -0400
In-Reply-To: <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>, Vinod Koul <vinod.koul@intel.com>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Russell King <linux@arm.linux.org.uk>

On 09/14/2012 04:41 PM, Jon Hunter wrote:
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
> to add some basic helpers to retrieve a DMA controller device_node and the
> DMA request/channel information.

The binding looks good to me now, so,
Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>

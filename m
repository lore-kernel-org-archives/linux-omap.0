From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RFC 5/5] iommu/omap: eliminate the public omap_find_iommu_device() method
Date: Tue, 27 Sep 2011 13:46:13 +0200
Message-ID: <201109271346.13791.laurent.pinchart@ideasonboard.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com> <1316948337-7924-6-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:40915 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582Ab1I0LqR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Sep 2011 07:46:17 -0400
In-Reply-To: <1316948337-7924-6-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Cousson Benoit <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>

Hi Ohad,

Thanks for the patch.

On Sunday 25 September 2011 12:58:57 Ohad Ben-Cohen wrote:
> Eliminate the public omap_find_iommu_device() method, and don't
> expect clients to provide the omap_iommu handle anymore.
> 
> Instead, OMAP's iommu driver should now utilize dev_archdata's private
> iommu extension to be able to access the required iommu information.
> 
> Update omap3isp appropriately.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Tony Lindgren <tony@atomide.com>

For the OMAP3 ISP driver,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

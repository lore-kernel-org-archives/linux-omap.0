From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] IOMMU: function flush_iotlb_page is not flushing
 correct entry
Date: Thu, 11 Jun 2009 10:39:41 +0300 (EEST)
Message-ID: <20090611.103941.212704372.Hiroshi.DOYU@nokia.com>
References: <496565EC904933469F292DDA3F1663E60297C70514@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60943 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbZFKHjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 03:39:51 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E60297C70514@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH] IOMMU: function flush_iotlb_page is not flushing correct entry
Date: Wed, 10 Jun 2009 20:43:39 +0200

> 
> Hi,
> 
>         The function flush_iotlb_page is not loading into the CAM register the entry to be removed, so it function removes the last entry loaded into the CAM register, so it is leaving a mapped address which maybe would not be validad.
> 
> From 14aef69914856e4bc679bdacfaf48d9214f8dfc9 Mon Sep 17 00:00:00 2001
> From: Fernando Guzman Lugo <x0095840@ti.com>
> Date: Wed, 10 Jun 2009 13:32:14 -0500
> Subject: [PATCH] IOMMU: function flush_iotlb_page is not flushing correct entry
> 
> The function flush_iotlb_page is not loading the CAM register with
> the correct entry to be flushed, so it is flushing other entry
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>

Thanks, it's queued for next merge.

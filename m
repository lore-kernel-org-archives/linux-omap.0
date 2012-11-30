From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] of: dma: Fix-up for warnings !CONFIG_OF
Date: Fri, 30 Nov 2012 09:36:18 -0600
Message-ID: <50B8D272.7000603@ti.com>
References: <1354227867-13357-1-git-send-email-jon-hunter@ti.com> <1354232877.7077.74.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52844 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030753Ab2K3Pg2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Nov 2012 10:36:28 -0500
In-Reply-To: <1354232877.7077.74.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Rob Herring <robherring2@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Fengguang Wu <fengguang.wu@intel.com>


On 11/29/2012 05:47 PM, Vinod Koul wrote:
> On Thu, 2012-11-29 at 16:24 -0600, Jon Hunter wrote:
>> When compiling the kernel with DMA engine support enabled and device-tree
>> support disabled, the following warnings are observed.
> Thanks, already committed same change last night.

Great! Thanks.

Jon

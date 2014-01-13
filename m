From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 08/26] dmaengine: omap-dma: consolidate setup of CCR
Date: Mon, 13 Jan 2014 14:14:26 -0800
Message-ID: <20140113221425.GD7993@atomide.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61931 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751832AbaAMWOb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jan 2014 17:14:31 -0500
Content-Disposition: inline
In-Reply-To: <E1VyjuU-0005EQ-H5@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

* Russell King <rmk+kernel@arm.linux.org.uk> [140102 07:17]:
> Consolidate the setup of the channel control register.  Prepare the
> basic value in the preparation of the DMA descriptor, and write it into
> the register upon descriptor execution.

FYI, this patch seems to be the one that causes the
"DMA timeout with device 55" error for omap1.

Tony

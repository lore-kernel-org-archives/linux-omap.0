From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP2+: Simplify NAND support
Date: Thu, 16 May 2013 09:21:45 -0700
Message-ID: <20130516162144.GY5600@atomide.com>
References: <1367331082-27944-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61680 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab3EPQVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 12:21:50 -0400
Content-Disposition: inline
In-Reply-To: <1367331082-27944-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [130430 07:16]:
> Commit 8c8a777 (ARM: OMAP2+: Add function to read GPMC settings from
> device-tree) added a device-tree property "gpmc,device-nand" to indicate
> is the GPMC child device is NAND. This commit should have updated the
> GPMC NAND documentation (Documentation/devicetree/bindings/mtd/gpmc-nand.txt)
> to list the property "gpmc,device-nand" as a required property and also
> updated the example. However, this property is redundant and not needed
> because the GPMC child device node for NAND is called "nand". Therefore,
> remove this property.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks applying into omap-for-v3.11/gpmc.

Regards,

Tony

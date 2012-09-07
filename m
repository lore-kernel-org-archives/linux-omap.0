From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
Date: Fri, 7 Sep 2012 10:06:22 -0700
Message-ID: <20120907170621.GZ1303@atomide.com>
References: <504A11E4.6000406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19834 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751217Ab2IGRG1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 13:06:27 -0400
Content-Disposition: inline
In-Reply-To: <504A11E4.6000406@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

* Benoit Cousson <b-cousson@ti.com> [120907 08:26]:
> Thanks to Vaibhav <hvaibhav@ti.com> omap_device fix
> (ARM: OMAP: omap_device: Fix up resource names when booted with devicetre),
> we can now specify reg and interrupts using standard device tree
> attributes.
> 
> Update the OMAP4 dtsi file with missing reg and interrupts attributes.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> ---
> 
> Hi Tony,
> 
> This is the first step toward reduction of the hwmod data inside mach-omap2.
> OMAP2/3/4 data still need to be there for legacy boards, but it will allow
> OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwmod.

That's good to hear, that should cut down the data by some hundreds of lines :)
 
> DMA is still missing, but I hope that the discussion that happened during
> LPC will fixed that soon.

Yeah and that can be added when the binding is available. The drivers should
work with and without DMA as the channels can run out.

Regards,

Tony

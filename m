From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] ARM: OMAP2+: usb_host_fs: add custom reset for
 usb_host_fs (fsusb)
Date: Thu, 7 Jun 2012 00:31:13 -0700
Message-ID: <20120607073112.GX12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061308.25532.19767.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55468 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab2FGHbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 03:31:16 -0400
Content-Disposition: inline
In-Reply-To: <20120607061308.25532.19767.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

* Paul Walmsley <paul@pwsan.com> [120606 23:26]:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Add a custom reset function for the usb_host_fs/fsusb IP block, and
> connect it to the OMAP4 FSUSB block.
> 
> This is the first of two fixes required to get rid of the boot
> warning:
> 
> omap_hwmod: usb_host_fs: _wait_target_disable failed
> 
> and to allow the module to idle.
> 
> It may be necessary to use this reset method for OMAP2xxx SoCs as
> well; this is left for a future patch.

Here too I think driver like features like this should live in the
driver init for omap OHCI driver. In the likely case that FS OHCI is
not in use on the board, the OHCI glue can just reset it.
 
> +/* HCCOMMANDSTATUS: the register offset of the HCCOMMANDSTATUS register */
> +#define HCCOMMANDSTATUS			0x0008
> +
> +/* HCCOMMANDSTATUS_HCR: the bitmask of the host controller reset flag */
> +#define HCCOMMANDSTATUS_HCR_MASK	(1 << 0)

I don't think the bus layer code should need to know anything about driver
specific registers.

> +	omap_hwmod_write(HCCOMMANDSTATUS_HCR_MASK, oh, HCCOMMANDSTATUS);
> +
> +	omap_test_timeout(!(omap_hwmod_read(oh, HCCOMMANDSTATUS)
> +			    & HCCOMMANDSTATUS_HCR_MASK),
> +			  MAX_MODULE_SOFTRESET_WAIT, c);
> +

These should be accessed by the driver in a standard way after ioremapping
the device.

Tony

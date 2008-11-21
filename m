From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP: I2C: reprogram OCP_SYSCONFIG after device
	reset
Date: Fri, 21 Nov 2008 13:34:39 -0800
Message-ID: <20081121213433.GX4927@atomide.com>
References: <20081014121031.1210.96214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51565 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYKUVel (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 16:34:41 -0500
Content-Disposition: inline
In-Reply-To: <20081014121031.1210.96214.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>

* Paul Walmsley <paul@pwsan.com> [081014 10:47]:
> Hello,
> 
> This patch set programs the I2C controller OCP_SYSCONFIG register
> after the driver resets the device.  It is derived from the changes
> mentioned by Richard Woodruff <r-woodruff2@ti.com> at
> 
> http://git.omapzoom.org/?p=omapkernel;a=blob;f=drivers/i2c/busses/i2c-omap.c;hb=d0b4bad4926f9a147a73498f7a62a0ae1cf6f83a
> 
> however, the CLOCKACTIVITY change on clk_enable()/clk_disable() in that
> code currently seems pointless, so it has been excluded until more
> information is available from TI or until problems are encountered.
> 
> This patchset should only change behavior on OMAP2x30 and OMAP3xxx devices.
> 
> Boot-tested on 2430SDP and 3430SDP; compile-tested with the 5912OSK (OMAP1)
> defconfig.  Comments welcome,

Pushing both to l-o today, also adding to upstream i2c-omap queue.

Tony

> 
> 
> - Paul
> 
> ---
> 
>   text    data     bss     dec      hex filename
> 3472584  160600  105760 3738944  390d40 vmlinux.3430sdp.orig
> 3472616  160600  105760 3738976  390d60 vmlinux.3430sdp
> 
>  drivers/i2c/busses/i2c-omap.c |   65 ++++++++++++++++++++++++++++++++---------
>  1 files changed, 50 insertions(+), 15 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/5] net: cpsw: Add control-module macid driver
Date: Mon, 17 Mar 2014 10:11:36 -0700
Message-ID: <20140317171136.GC30471@atomide.com>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
 <1394888864-11007-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61948 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751448AbaCQRLn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2014 13:11:43 -0400
Content-Disposition: inline
In-Reply-To: <1394888864-11007-4-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi,

* Markus Pargmann <mpa@pengutronix.de> [140315 06:12]:
> This driver extracts the hardware macid from the control module of
> am335x processors. It exports a function cpsw_ctrl_macid_read for cpsw
> to get the macid from within the processor.

Few things have improved recently :) This can be now implemented
in a much cleaner way using regmap against the already defined syscon
node.

For an example, see how the MMC PBIAS regulator is using regmap
in Linux next:

11469e0bb1 (regulator: add pbias regulator support)
cd042fe5c1 (ARM: dts: add pbias dt node)

That avoids the problem of the tinkering with SoC specific registers
that belong to another device.

So please update this series for regmap, let's not add more mapping
of system control module registers to the drivers.

Regards,

Tony

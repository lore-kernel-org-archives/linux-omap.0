From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6.1 3/3] omap3: beaglexm: fix power on of DVI
Date: Tue, 11 Jan 2011 17:04:04 -0800
Message-ID: <20110112010403.GB4957@atomide.com>
References: <1294791809-28069-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51885 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769Ab1ALBEO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Jan 2011 20:04:14 -0500
Content-Disposition: inline
In-Reply-To: <1294791809-28069-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>

* Nishanth Menon <nm@ti.com> [110111 16:22]:
> From: Koen Kooi <koen@beagleboard.org>
> 
> TFP410 DVI chip is used to provide display out.
> This chip is controlled by 2 lines:
> LDO which supplies the power is controlled over gpio + 2
> and the enable of the chip itself is done over gpio + 1
> NOTE: the LDO is necessary for LED, serial blocks as well.
> 
> gpio + 1 was used to sense USB overcurrent in vanilla beagle.
> 
> Without this fix, the display would not function as the LDO
> remains shut down.

Thanks, applying.

Tony

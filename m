From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 03/10] omap: add mdio platform devices
Date: Tue, 7 Sep 2010 18:00:31 -0700
Message-ID: <20100908010031.GF22507@atomide.com>
References: <1283891142-15522-1-git-send-email-cyril@ti.com>
 <1283891142-15522-4-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:54808 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829Ab0IHBAf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 21:00:35 -0400
Content-Disposition: inline
In-Reply-To: <1283891142-15522-4-git-send-email-cyril@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cyril Chemparathy <cyril@ti.com>
Cc: netdev@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, davem@davemloft.net, khilman@deeprootsystems.com

* Cyril Chemparathy <cyril@ti.com> [100907 13:17]:
> This patch adds mdio platform devices on SoCs that have the necessary
> hardware.  Clock lookup entries (aliases) have also been added, so that the
> MDIO and EMAC drivers can independently enable/disable a shared underlying
> clock.  Further, the EMAC MMR region has been split down into separate MDIO
> and EMAC regions.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Acked-by: David S. Miller <davem@davemloft.net>

Looks good to me from omap point of view:

Acked-by: Tony Lindgren <tony@atomide.com>

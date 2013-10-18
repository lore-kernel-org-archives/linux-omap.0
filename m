From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/1] ARM: OMAP2+: remove legacy support for IGEP
 boards
Date: Fri, 18 Oct 2013 10:50:37 -0700
Message-ID: <20131018175036.GS15154@atomide.com>
References: <1382110673-17149-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46840 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756515Ab3JRRul (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Oct 2013 13:50:41 -0400
Content-Disposition: inline
In-Reply-To: <1382110673-17149-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [131018 08:38]:
> Device Tree support for IGEP boards in mainline is almost
> finished. The only remaining bits are support for the
> Marvell SD8686 wifi + BT and TFP410 DVI chips.
> 
> Adding support for these should be straightforward so let's
> not block OMAP3 moving to Device Tree only boot and remove
> the board file for IGEP boards.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks applied this to the updated board removal branch
and sent off the pull request.

Tony

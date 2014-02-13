From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] ARM: dts: Fixes for Overo/Tobi against 3.14-rc2
Date: Thu, 13 Feb 2014 15:36:52 -0800
Message-ID: <20140213233652.GU28216@atomide.com>
References: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17906 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751694AbaBMXhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 18:37:07 -0500
Content-Disposition: inline
In-Reply-To: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140213 02:28]:
> OMAP36xx-based Overo (Storm and alike) are now failing to boot with 3.14-rc2 [1].
> This series fixes this, by moving model-agnostic DT into a common dtsi file,
> and creating model-specific DT files:
> 
> - omap3-overo-tobi.dts -> older OMAP35xx Overo
> - omap3-overo-storm-tobi.dts -> newer OMAP36xx/AM37xx/DM37xx Overo
> 
> People will have to use the right Overo / expansion board combination.
> 
> (Patch 2 in an unrelated fix that was waiting in my queue.)
> 
> omap3-overo-tobi.dts tested with Overo Sand (OMAP3503) and omap3-overo-storm-tobi.dts
> tested with Overo EarthStorm (AM3703). Both boot. With the Overo Sand, I cannot
> mount the ext3 rootfs, but this seems unrelated to the current topic, maybe
> a missing errata.

Applying patches 1 to 3 into omap-for-v3.14/fixes thanks, the last
one still seems to have discussion going.

Tony

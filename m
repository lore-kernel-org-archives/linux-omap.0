From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 00/11] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Mon, 14 Jul 2014 04:24:12 -0700
Message-ID: <20140714112412.GE20068@atomide.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:34662 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbaGNLZi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jul 2014 07:25:38 -0400
Content-Disposition: inline
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>

* Dave Gerlach <d-gerlach@ti.com> [140710 19:58]:
> Hello,
> 
> This series adds suspend/resume support for am335x. Version 3 of this
> series can be found at [1]. I apologize for the large delay between this
> and the previous revision. This code has been heavily refined
> since the last version based on the various comments received for v3. The
> major change from previous version is moving all wkup_m3 code into a
> remoteproc based driver. The new driver handles all IPC and fw loading
> and exposes a small API to be used by PM code to achieve low power states.

Great, this is nice for all the am335x users. I made few comments
on the series that should be quite simple to fix up.

Then please split up your next version of this series into the
following independet patches:

1. Changes to the EDMA driver for suspend and resume support

2. Patches to add the rproc driver

3. SoC related changes to enable PM support

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: Device Tree for 3.13
Date: Fri, 11 Oct 2013 11:03:24 -0700
Message-ID: <20131011180324.GV29913@atomide.com>
References: <52582A67.6050108@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:25578 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab3JKSD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 14:03:29 -0400
Content-Disposition: inline
In-Reply-To: <52582A67.6050108@baylibre.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Benoit,

* Benoit Cousson <bcousson@baylibre.com> [131011 09:50]:
> Add the minimal DTS support for DRA7xx based SoC core.
> Add the initial support for N900 and gta04 phones.
> Enable USB3 on OMAP5 evm board.
> Add support for cryto accelerators
> Add new IGEP AQUILA board
> Add AM33XX EDMA support
> Update HSUSB node to use the reset-gpios fmwk

Looks good to me, but we're getting self-inflicted merge
conflicts in two places now with Paul's hwmod changes,
and my defconfig changes.

Can you please respin without the following two patches:

49bcd824c1c0db32fe4de0c1ba3ee36defdb11ca ARM: configs: omap2plus_defconfig: enable dwc3 and dependencies
736c4bb159c793b00331261438deb982cbac3c03 ARM: OMAP5: hwmod: add missing ocp2scp hwmod data

I can pick the two patches above and apply after pulling in
Paul's branch first.

However, if other branches are based on this, then we just
need to deal with the merge conflicts, and there's no point
in redoing your branch.

Regards,

Tony
